class CreateUserAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :user_authentications do |t|
      t.bigint   :user_id, null: false
      t.string   :provider, null: false
      t.string   :uid
      t.string   :token
      t.datetime :token_expires_at
      t.text     :auth_data
      t.timestamps
    end

    add_index :user_authentications, [:uid, :provider], unique: true
  end
end
