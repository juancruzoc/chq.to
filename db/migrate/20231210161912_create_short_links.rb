class CreateShortLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :short_links do |t|
      t.integer :user_id
      t.string :short_url
      t.string :url
      t.datetime :expiration_date
      t.string :password
      t.integer :usages

      t.timestamps
    end
  end
end
