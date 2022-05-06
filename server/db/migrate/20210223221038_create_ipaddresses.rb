class CreateIpaddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :ipaddresses do |t|
      t.string :ip
      t.text :user
      
      t.timestamps
    end
  end
end
