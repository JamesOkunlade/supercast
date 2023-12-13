class AddLikesCountToPodcast < ActiveRecord::Migration[7.1]
  def change
    add_column :podcasts, :likes_count, :integer, default: 0
  end
end
