class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.references :companies, null: true, foreign_key: true
      t.string :username
      t.string :type_user
      t.timestamps
    end
  end
end
