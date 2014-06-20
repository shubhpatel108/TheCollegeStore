class CreateCityVendors < ActiveRecord::Migration
  def change
    create_table :city_vendors do |t|
      t.string	:vendor_name,			null: false, default: ""
      t.string	:mobile, 					null: false, default: ""
      t.string	:email,						null: false, default: ""
      t.string	:city, 						null: false, default: "" 
      t.timestamps
    end
  end
end
