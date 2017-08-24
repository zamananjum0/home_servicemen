class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :description
      t.string :status, default: 'pending'
      t.integer :user_id
      t.integer :role_id
      t.string :phone_no
      t.string :address
      t.float  :latitude
      t.float  :longitude
      t.string :service_man_id
      t.timestamps
    end
  end
end
