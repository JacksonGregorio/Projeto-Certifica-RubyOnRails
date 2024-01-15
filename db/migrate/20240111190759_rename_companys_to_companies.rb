class RenameCompanysToCompanies < ActiveRecord::Migration[7.1]
  def change
    rename_table :companys, :companies
  end
end
