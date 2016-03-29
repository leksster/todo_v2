class Attach < ActiveRecord::Base
  belongs_to :comment

  mount_uploader :file, AttachUploader
end
