class UserSkill < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :skill, dependent: :destroy
end
