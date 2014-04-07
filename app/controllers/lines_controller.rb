class LinesController < ApplicationController

  def index
    @stations = Station.all
    @lines = Line.all
    @line = Line.new
  end

  def create
    @line = Line.new(params[:line])
    if @line.save

      params[:station_ids].each do |stationID|
        @line.stops.create({station_id: stationID, line_id: @line.id})
      end
      # params[:line][:slug] = ("#{@line.id}-#{@line.name}").parameterize
      # @line.update(params[:line]) ## will fix this later!!!
      flash[:notice] = "#{@line.name.capitalize} has been saved"
      redirect_to line_path(@line)
    else
      render 'index'
    end
  end

  def show
    @line = Line.find(params[:id])
  end

  def edit
    @stations = Station.all
    @line = Line.find(params[:id])
  end

  def update
    @line = Line.find(params[:id])
    if @line.update(params[:line])

      params[:station_ids].each do |stationID|
        @line.stops.create({station_id: stationID, line_id: @line.id})
      end

      flash[:notice] = "#{@line.name.capitalize} has been updated"
      redirect_to line_path(@line)
    else
      render 'edit'
    end
  end

  def destroy
    @line = Line.find(params[:id])
    @line.destroy
    redirect_to lines_path
  end
end
