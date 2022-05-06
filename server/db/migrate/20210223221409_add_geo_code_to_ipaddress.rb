class AddGeoCodeToIpaddress < ActiveRecord::Migration[6.1]
  def change
    add_column :ipaddresses, :latitude, :float
    add_column :ipaddresses, :longitude, :float
  end
end
