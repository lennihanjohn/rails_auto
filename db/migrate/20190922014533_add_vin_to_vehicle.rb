class AddVinToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :vin, :string
  end
end
