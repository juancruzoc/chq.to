class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.integer :short_link_id
      t.date :date
      t.time :hour
      t.string :ip
      t.string :user_agent

      t.timestamps
    end
  end
end
