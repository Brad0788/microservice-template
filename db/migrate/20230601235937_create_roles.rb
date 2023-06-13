class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.text :description
      t.datetime :created_date
      t.timestamps
    end
  end
end
