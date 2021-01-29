class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :first_name, :last_name, presence: true

  has_many :img_videos, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :calendars
  # has_many :categories, through: :user_categories, source: :categories
  belongs_to :coverage, optional: true
end
