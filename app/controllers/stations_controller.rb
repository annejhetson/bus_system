class StationsController < ApplicationController

  def index
    @lines = Line.all
    @stations = Station.all
    @station = Station.new
  end

  def create
    @lines = Line.all
    @station = Station.new(params.require(:station).permit(:name))
    if @station.save
      if params[:line_ids] != nil
        params[:line_ids].each do |lineId|
          @station.stops.create({station_id: @station.id, line_id: lineId})
        end
      end

      flash[:notice] = "#{@station.name.capitalize} has been saved"
      redirect_to station_path(@station)

    else
      redirect_to stations_path
    end
  end

  def show
    @station = Station.find(params[:id])
  end

  def edit
    @lines = Line.all
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(params.require(:station).permit(:name))
      if @station.stops[0] != nil
        stops_to_destroy = Stop.where("station_id = #{@station.id}")
        stops_to_destroy.each { |stop| stop.destroy }
      end

      params[:line_ids].each do |lineId|
        Stop.create({station_id: @station.id, line_id: lineId})
      end

      flash[:notice] = "#{@station.name.capitalize} has been updated"
      redirect_to station_path(@station)
    else
      render 'edit'
    end
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to stations_path
  end
end
