class LinesController < ApplicationController

  def index
    @stations = Station.all
    @lines = Line.all
    @line = Line.new
  end

  def create
    @stations = Station.all
    @line = Line.new(params.require(:line).permit(:name))
    if @line.save
      if params[:station_ids] != nil
        params[:station_ids].each do |stationID|
          @line.stops.create({station_id: stationID, line_id: @line.id})
        end
      end
      flash[:notice] = "#{@line.name.capitalize} has been saved"
      redirect_to line_path(@line)

    else
      flash[:notice] = "error"
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
    if @line.update(params.require(:line).permit(:name))
      if @line.stops[0] != nil
        stops_to_destroy = Stop.where("line_id = #{@line.id}")
        stops_to_destroy.each { |stop| stop.destroy }
      end

      params[:station_ids].each do |stationID|
        Stop.create({station_id: stationID, line_id: @line.id})
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
