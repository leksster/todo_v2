class Comment < ActiveRecord::Base
  belongs_to :task
  has_many :attaches, dependent: :destroy

  validates :text, presence: true

  accepts_nested_attributes_for :attaches
end
