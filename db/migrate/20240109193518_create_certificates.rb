class CreateCertificates < ActiveRecord::Migration[7.1]
  def change
    create_table :certificates do |t|
      t.string :title
      t.references :companies, null: false, foreign_key: true
      t.date :validity
      t.string :type
      t.integer :value
      t.string :cnpj
      t.text :description

      t.timestamps
    end
  end
end
