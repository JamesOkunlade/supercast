# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  first_name               :string
#  language                 :string
#  last_name                :string
#  preferred_podcast_length :integer
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :user_genres, dependent: :destroy
  has_many :genres, through: :user_genres

  has_many :likes, dependent: :destroy
  has_many :liked_podcasts, through: :likes, source: :podcast

  # Validations
  validates_presence_of :first_name, :last_name, length: { maximum: 50 }
end
