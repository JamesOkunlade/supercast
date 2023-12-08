class AddMoreFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :preferred_podcast_length, :integer
    add_column :users, :language, :string
  end
end
