class ShortLink < ApplicationRecord
    validates :url, presence: true
    validates :short_url, presence: true
    validates :expiration_date, comparison: { greater_than: Date.today }, :allow_blank => true
    validates :password, length: { maximum: 25 }
    validates :usages, length: { maximum: 100 }
end
