class CreateCompanys < ActiveRecord::Migration[7.1]
  def change
    create_table :companys do |t|
      t.string :name
      t.string :cnpj
      t.string :email
      t.timestamps
    end
  end
end
