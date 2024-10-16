class RemoveAgeAndAddressFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :age, :integer
    remove_column :users, :address, :string
  end
end
