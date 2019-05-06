class EncryptedFile < ApplicationRecord
  attr_accessor :encryption, :key, :attachment
  mount_uploader :attachment, EncryptedUploader# Tells rails to use this uploader for this model.
  validates :name, presence: true
  validates :key, presence: true
  validates :encryption, presence: true
end
