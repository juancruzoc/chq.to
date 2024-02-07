class ShortLink < ApplicationRecord
    validates :url, presence: true
    validates :short_url, presence: true
    validates :expiration_date, comparison: { greater_than: Date.today }, :allow_blank => true
    validates :password, length: { maximum: 25 }
    validates :usages, length: { maximum: 100 }

    before_validation do
        unless self.url.include?("http://") || self.url.include?("https://")
            self.url = "http://" + self.url
        end

        self.short_url = Digest::SHA256.hexdigest(self.url + self.user_id.to_s).first(7)

        if self.expiration_date
            @e_date = self.expiration_date
            self.expiration_date = DateTime.new(@e_date.year, @e_date.month, @e_date.day, 0, 0, 0)
        end
    end

    def decrease_usages
        if self.usages
            self.usages -= 1
            self.save
        end
    end
end
