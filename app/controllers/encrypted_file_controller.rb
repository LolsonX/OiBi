class EncryptedFileController < ApplicationController
  def index
    @data = EncryptedFile.all
  end

  def new
    @data = EncryptedFile.new
  end

  def create
    @data = EncryptedFile.new(datum_params.except(:attachment))
    @data.attachment = datum_params.delete :attachment
    @data.valid?
    redirect_to encrypted_file_index_url,
                  notice: "The file #{@data.name} has been uploaded." and return if @data.save
    render 'new'
  end

  def destroy
    @data = EncryptedFile.find(params[:id])
    @data.destroy
    redirect_to encrypted_file_index_url, notice: "The file #{@data.name} has been deleted"
  end

  private

  def datum_params
    params.require(:data).permit(:name, :attachment, :key, :encryption)
  end
end
