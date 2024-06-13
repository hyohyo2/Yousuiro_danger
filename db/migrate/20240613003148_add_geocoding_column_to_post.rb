class AddGeocodingColumnToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :latitude, :float, null: false, default: 0
    add_column :posts, :longitude, :float, null: false, default: 0
  end
end
