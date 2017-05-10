class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :name
      t.string :user_id
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :image
    end
  end
end
