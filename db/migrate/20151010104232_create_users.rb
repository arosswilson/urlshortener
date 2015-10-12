require 'bcrypt'
class CreateUsers < ActiveRecord::Migration
  include BCrypt
  def change
    create_table :users do |t|
      t.string :username, null: false, uniqueness: true
      t.string :password_hash, null: false, minimum: 6

      t.timestamps
    end
  end
end