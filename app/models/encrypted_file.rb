class EncryptedFile < ApplicationRecord
  #attr_accessor :encryption, :key, :attachment
  mount_uploader :attachment, EncryptedUploader# Tells rails to use this uploader for this model.
  validates :name, presence: true
  validates :key, presence: true
  validates :encryption, presence: true
  validate :key_length_correct

  def key_length_correct
    case self.encryption
      when 'blowfish'
        return true if self.key.length>=4 and self.key.length<=56
        self.errors.add :key, 'Blowfish key must be between 4 and 56'
      when 'aes-256-cbc', 'aria-256-cbc'
        return true if self.key.length == 32
        self.errors.add :key, "#{self.encryption} needs 32 letters long key"
      when 'cast5-cbc'
        return true if self.key.length >= 5 and self.key.length <=16
        self.errors.add :key, 'CAST5 key must be between 5 and 16 signs long'
      when 'des-ede3-cbc'
        return true if self.key.length == 21
        self.errors.add :key, '3DES key must be 21 signs long'
      else
        true
    end
  end

end
