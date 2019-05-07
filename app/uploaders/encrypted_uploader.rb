class EncryptedUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  after :store, :decrypt
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


  def decrypt(tmp)
    dir = Rails.root.join('public', 'uploads', model.class.to_s.underscore, 'attachment', model.id.to_s)
    directory = Dir.open(dir)
    puts 'test_up'
    directory.each do |file|
      puts file
      unless File.directory?(File.basename(file))
        begin
        cipher = OpenSSL::Cipher::Cipher.new(model.encryption)
        cipher.decrypt

        cipher.iv = '0'*16
        cipher.key = model.key
        puts 'test'
        buf = ''
        File.open("#{dir}/#{File.basename(file)}dec" , 'wb') do |outf|
          File.open("#{dir}/#{File.basename(file)}", 'rb') do |inf|
            while inf.read(4096, buf)
              outf << cipher.update(buf)
            end
            outf << cipher.final
          end
        end
        FileUtils.move "#{dir}/#{File.basename(file)}dec", "#{dir}/#{File.basename(file)}"
        rescue Exception => e
          FileUtils.remove "#{dir}/#{File.basename(file)}"
        end
      end

    end
  end
end
