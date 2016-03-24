class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments

  validates :text, presence: true
end
