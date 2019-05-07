class DatumController < ApplicationController
  def index
    @data = Datum.all
  end

  def new
    @data = Datum.new
  end

  def create
    @data = Datum.new(datum_params.except(:attachment))

    if @data.save
      @data.attachment = datum_params.delete :attachment
      redirect_to datum_index_url,
                  notice: "The file #{@data.name} has been uploaded." and return if @data.save
      render 'new'
    else
      render 'new'
    end
  end

  def destroy
    @data = Datum.find(params[:id])
    @data.destroy
    redirect_to datum_index_url, notice: "The file #{@data.name} has been deleted"
  end

  private

  def datum_params
    params.require(:data).permit(:name, :attachment, :key, :encryption)
  end
end
