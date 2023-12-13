class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.string :host
      t.string :audio_url
      t.string :listen_notes_podcast_id
      t.string :thumbnail_url
      t.integer :genres, array: true, default: []

      t.timestamps
    end
  end
end
