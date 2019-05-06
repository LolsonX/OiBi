class DatumController < ApplicationController
  def index
    @data = Datum.all
  end

  def new
    @datum = Datum.new
  end

  def create
    @data = Datum.new(datum_params.except(:attachment))

    if @data.save
      @data.attachment = datum_params.delete :attachment
      @data.save
      redirect_to root_path, notice: "The file #{@data.name} has been uploaded."
    else
      render 'new'
    end
  end

  def destroy
    @data = Datum.find(params[:id])
    @data.destroy
    redirect_to root_path, notice: "The file #{@data.name} has been deleted"
  end

  private

  def datum_params
    params.require(:datum).permit(:name, :attachment, :key, :encryption)
  end
end
