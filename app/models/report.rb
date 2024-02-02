class Report < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "date", "hour", "id", "id_value", "ip", "short_link_id", "updated_at", "user_agent"]
    end
end
