# == Schema Information
#
# Table name: genres
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  listen_notes_genre_id :integer
#
class Genre < ApplicationRecord
  has_many :user_genres, dependent: :destroy
  has_many :users, through: :user_genres
end
