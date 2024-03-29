class Api::V1::VerticalsController < ApplicationController
  before_action :set_vertical, only: %i[ show update destroy ]

  # GET /verticals
  def index
    @verticals = Vertical.search(params.fetch(:q, "*"))

    render json: @verticals
  end

  # GET /verticals/1
  def show
    render json: @vertical
  end

  # POST /verticals
  def create
    @vertical = Vertical.new(vertical_params)

    if @vertical.save
      render json: @vertical, status: :created, location: api_v1_vertical_url(@vertical)
    else
      render json: @vertical.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /verticals/1
  def update
    if @vertical.update(vertical_params)
      render json: @vertical
    else
      render json: @vertical.errors, status: :unprocessable_entity
    end
  end

  # DELETE /verticals/1
  def destroy
    @vertical.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vertical
      @vertical = Vertical.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vertical_params
      params.require(:vertical).permit(:name, categories_attributes: [:id , :name, :state])
    end
end
