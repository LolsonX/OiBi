class Datum < ApplicationRecord
  #attr_accessor :encryption, :key, :attachment
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true
  validates :key, presence: true
  validates :encryption, presence: true
  validate :key_length_correct


  def key_length_correct
    case self.encryption
      when 'blowfish'
        return true if self.key.length>=4 and self.key.length<=56
        self.errors.add :key, 'Blowfish key must be between 4 and 56'
        return false
      when 'aes-256-cbc', 'aria-256-cbc'
        puts self
        return true if self.key.length == 32
        self.errors.add :key, "#{self.encryption} needs 32 letters long key"
        return false
      when 'cast5-cbc'
        return true if self.key.length ==16
        self.errors.add :key, 'CAST5 key must be 16 signs long'
        return false
      when 'des-ede3-cbc'
        return true if self.key.length == 21
        self.errors.add :key, '3DES key must be 21 signs long'
        return false
      else
        false
    end
  end
end
#aes-256-cbc aria-256-cbc blowfish cast5-cbc des-ede3-cbc