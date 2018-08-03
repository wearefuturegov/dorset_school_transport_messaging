class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.string :phone_number
      t.string :name
      t.references :route
    end
  end
end
