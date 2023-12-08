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
#  thumbnail_url           :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  listen_notes_podcast_id :string
#
require 'rails_helper'

RSpec.describe Podcast, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
