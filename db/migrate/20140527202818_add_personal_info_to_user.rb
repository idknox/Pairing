class AddPersonalInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :phone, :string
    add_column :users, :twitter, :string
    add_column :users, :blog, :string
  end
end
