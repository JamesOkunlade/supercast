# == Schema Information
#
# Table name: podcasts
#
#  id                      :bigint           not null, primary key
#  audio_url               :string
#  description             :text
#  duration                :integer
#  genres                  :integer          default([]), is an Array
#  host                    :string
#  likes_count             :integer          default(0)
#  thumbnail_url           :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  listen_notes_podcast_id :string
#
class Podcast < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
    
  validates_presence_of :title, :description, :duration, :audio_url, :host, :thumbnail_url
end
