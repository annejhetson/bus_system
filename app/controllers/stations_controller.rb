class StationsController < ApplicationController

  def index
    @lines = Line.all
    @stations = Station.all
    @station = Station.new
  end

  def create
    @lines = Line.all
    @station = Station.new(params[:station])
    if @station.save
      # params[:station][:slug] = ("#{@station.id}-#{@station.name}").parameterize
      # @station.update(params[:station]) ## will fix this later!!!

      params[:line_ids].each do |lineId|
        @station.stops.create({station_id: @station.id, line_id: lineId})
      end

      flash[:notice] = "#{@station.name.capitalize} has been saved"
      redirect_to station_path(@station)
    else
      render 'index'
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
    if @station.update(params[:station])

      params[:line_ids].each do |lineId|
        @station.stops.create({station_id: @station.id, line_id: lineId})
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
