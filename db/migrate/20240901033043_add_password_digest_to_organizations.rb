class AddPasswordDigestToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :password_digest, :string
  end
end
