class AddOtherToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :expires_at, :datetime
    add_column :api_keys, :user_id, :integer
    add_column :api_keys, :active, :boolean
  end

  add_index :api_keys, ["user_id"], name: "index_api_keys_on_user_id", unique: false
  add_index :api_keys, ["access_token"], name: "index_api_keys_on_access_token", unique: true

end
