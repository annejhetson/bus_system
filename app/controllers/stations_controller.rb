class StationsController < ApplicationController

  def index
    @lines = Line.all
    @stations = Station.all
    @station = Station.new
    if params[:search] != nil
      @found_stations = Station.where("name LIKE '%#{params[:search]}%'")
      @found_lines = Line.where("name LIKE '%#{params[:search]}%'")

      if @found_stations.first == nil &&  @found_lines.first == nil
        flash[:notice] = "No search results found"
        render "/search"
      elsif @found_stations
        render "/search"
      else @found_lines
        render "/search"
      end
    end
  end

  def create
    @lines = Line.all
    @station = Station.new
    if @station.save
      if params[:line_ids] != nil
        params[:line_ids].each do |lineId|
          @station.stops.create({station_id: @station.id, line_id: lineId})
        end
      end

      flash[:notice] = "#{@station.name.capitalize} has been saved"
      redirect_to station_path(@station)

    else
      flash[:alert] = "System error!"
      render stations_path
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
    if @station.update()
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



  private
  def user_params
    params.require(:station).permit(:name)
  end

end
