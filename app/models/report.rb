class Report < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "date", "hour", "id", "id_value", "ip", "short_link_id", "updated_at", "user_agent"]
    end

    def generate(short_link_id, request)
        self.short_link_id = short_link_id
        self.date = Date.today
        self.hour = Time.now.localtime
        self.ip = request.remote_ip
        self.user_agent = request.user_agent
        self.save
    end
end
