require 'ipaddr'

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

$now = Time.now
$a_day_ago = $now - 86400 # now - 60 * 60 * 24
$user_agent_list = ["Mozilla/5.0", "Chrome/121.0.0.0", "CriOS/121.0.6167.171", "Safari/537.36"]

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

def generate_reports short_link_id
  rand(5..15).times do
    Report.create!([{
      short_link_id: short_link_id,
      ip: IPAddr.new(rand(2**32),Socket::AF_INET),
      date: (time_rand Time.local(2023, 12, 1), Time.now),
      hour: rand($a_day_ago..$now),
      user_agent: $user_agent_list.sample,
    }])
  end
end

@default_link = ShortLink.new({
  user_id: @test_user.id,
  url: "http://facebook.com",
  short_url: "4f7c06c",
  password: ""
})
@default_link.save
generate_reports @default_link.id

@password_protected_link = ShortLink.new({
  user_id: @test_user.id,
  url: "http://x.com",
  short_url: "1b3b988",
  password: "123123"
})
@password_protected_link.save
generate_reports @password_protected_link.id

@not_expired_link = ShortLink.new({
  user_id: @test_user.id,
  url: "http://medium.com",
  short_url: "c371990",
  password: "",
  expiration_date: Date.new(2025,01,31),
})
@not_expired_link.save
generate_reports @not_expired_link.id

@usages_capped_link = ShortLink.new({
  user_id: @test_user.id,
  url: "http://youtube.com",
  short_url: "64aa817",
  password: "",
  usages: "50"
})
@usages_capped_link.save
generate_reports @usages_capped_link.id

@zero_usages_link = ShortLink.new({
  user_id: @test_user.id,
  url: "http://linkedin.com",
  short_url: "e5373d5",
  password: "",
  usages: "0"
})
@zero_usages_link.save
generate_reports @zero_usages_link.id

@expired_link = ShortLink.new({ # Expired link
    user_id: @test_user.id,
    url: "http://instagram.com",
    short_url: "c3c40c8",
    password: "",
    expiration_date: Date.new(2023,12,31),
})
@expired_link.save(validate: false)
generate_reports @expired_link.id
