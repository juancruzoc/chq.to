User.destroy_all
ShortLink.destroy_all
Report.destroy_all

@test_user = User.new
@test_user.email = 'test@example.com'
@test_user.password = '123123'
@test_user.password_confirmation = '123123'
@test_user.save!

@empty_user = User.new
@empty_user.email = 'empty@example.com'
@empty_user.password = '123123'
@empty_user.password_confirmation = '123123'
@empty_user.save!

ShortLink.destroy_all

@report_link = ShortLink.new({ # Reports link
  user_id: @test_user.id,
  url: "http://facebook.com",
  short_url: "4f7c06c",
  password: ""
})
@report_link.save

ShortLink.create!([{ # Password protected link
    user_id: @test_user.id,
    url: "http://x.com",
    short_url: "1b3b988",
    password: "123123"
  },
  { # Link with setted expiration date
    user_id: @test_user.id,
    url: "http://medium.com",
    short_url: "c371990",
    password: "",
    expiration_date: Date.new(2025,01,31),
  },
  { # Usages capped link
    user_id: @test_user.id,
    url: "http://youtube.com",
    short_url: "64aa817",
    password: "",
    usages: "50"
  },
  { # 0 Usages left link
    user_id: @test_user.id,
    url: "http://linkedin.com",
    short_url: "e5373d5",
    password: "",
    usages: "0"
  }]
)

ShortLink.new({ # Expired link
    user_id: @test_user.id,
    url: "http://instagram.com",
    short_url: "c3c40c8",
    password: "",
    expiration_date: Date.new(2023,12,31),
  }).save(validate: false)

Report.create!([{
  short_link_id: @report_link.id,
  ip: "238.245.60.165",
  date: Date.new(2024, 1, 15),
  hour: Time.now.midnight,
  user_agent: "Mozilla/5.0"
  },
  {
    short_link_id: @report_link.id,
    ip: "49.31.210.164",
    date: Date.new(2024, 1, 16),
    hour: Time.now.midday,
    user_agent: "Mozilla/5.0"
  },
  {
    short_link_id: @report_link.id,
    ip: "10.111.2.94",
    date: Date.new(2024, 1, 16),
    hour: Time.now.midnight,
    user_agent: "Chromium"
  },
  {
    short_link_id: @report_link.id,
    ip: "173.156.71.29",
    date: Date.new(2024, 1, 17),
    hour: Time.now.midday,
    user_agent: "Chrome"
  },
  {
    short_link_id: @report_link.id,
    ip: "173.156.71.29",
    date: Date.new(2024, 1, 20),
    hour: Time.now.midnight,
    user_agent: "Chrome"
  },
  {
    short_link_id: @report_link.id,
    ip: "227.10.252.218",
    date: Date.new(2024, 1, 25),
    hour: Time.now.midday,
    user_agent: "Mozilla/5.0"
    },
    {
      short_link_id: @report_link.id,
      ip: "227.122.8.98",
      date: Date.new(2024, 2, 1),
      hour: Time.now.midnight,
      user_agent: "Mozilla/5.0"
    },
    {
      short_link_id: @report_link.id,
      ip: "141.211.225.179",
      date: Date.new(2024, 2, 1),
      hour: Time.now.midday,
      user_agent: "Chromium"
    },
    {
      short_link_id: @report_link.id,
      ip: "90.181.161.171",
      date: Date.new(2024, 2, 1),
      hour: Time.now.midnight,
      user_agent: "Chrome"
    },
    {
      short_link_id: @report_link.id,
      ip: "70.115.217.237",
      date: Date.new(2024, 2, 1),
      hour: Time.now.midday,
      user_agent: "Chrome"
    },]
)
