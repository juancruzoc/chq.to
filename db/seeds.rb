User.destroy_all

test_user = User.new
test_user.email = 'test@example.com'
test_user.password = '123123'
test_user.password_confirmation = '123123'
test_user.save!

empty_user = User.new
empty_user.email = 'empty@example.com'
empty_user.password = '123123'
empty_user.password_confirmation = '123123'
empty_user.save!

ShortLink.destroy_all

ShortLink.create!([{ # Normal link
    user_id: test_user.id,
    url: "http://facebook.com",
    short_url: "4f7c06c",
    password: ""
  },
  { # Password protected link
    user_id: test_user.id,
    url: "http://x.com",
    short_url: "1b3b988",
    password: "123123"
  },
  { # Link with setted expiration date
    user_id: test_user.id,
    url: "http://medium.com",
    short_url: "c371990",
    password: "",
    expiration_date: Date.new(2025,01,31),
  },
  { # Usages capped link
    user_id: test_user.id,
    url: "http://youtube.com",
    short_url: "64aa817",
    password: "",
    usages: "50"
  },
  { # 0 Usages left link
    user_id: test_user.id,
    url: "http://linkedin.com",
    short_url: "e5373d5",
    password: "",
    usages: "0"
  }]
)

ShortLink.new({ # Expired link
    user_id: test_user.id,
    url: "http://instagram.com",
    short_url: "c3c40c8",
    password: "",
    expiration_date: Date.new(2023,12,31),
  }).save(validate: false) 