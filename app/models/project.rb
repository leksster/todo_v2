class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :user_id, presence: true
end
