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
require 'rails_helper'

RSpec.describe Podcast, type: :model do
  # Association test

  # Validation tests
  # ensure columns title, description, genre, duration, rss_feed_url, and 
  # host are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:host) }
end
