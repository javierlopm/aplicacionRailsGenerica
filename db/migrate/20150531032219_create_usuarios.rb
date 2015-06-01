class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :usuario
      t.string :password
      t.string :alias
      t.string :email

      t.timestamps null: false
    end
  end
end
