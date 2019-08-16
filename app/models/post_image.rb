class PostImage < ApplicationRecord
  mount_uploader :data, ImagesUploader
  belongs_to :post
end
