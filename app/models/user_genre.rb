# == Schema Information
#
# Table name: user_genres
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_genres_on_genre_id  (genre_id)
#  index_user_genres_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#  fk_rails_...  (user_id => users.id)
#
class UserGenre < ApplicationRecord
  belongs_to :user
  belongs_to :genre
end
