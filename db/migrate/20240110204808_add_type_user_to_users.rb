class AddTypeUserToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :type_user, :string
  end
end
