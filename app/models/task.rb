class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :text, presence: true

  delegate :user, :to => :project, :allow_nil => true
end
