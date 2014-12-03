class API::V1::ZonesController < API::V1::ApiController
  respond_to :json
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:show, :update, :destroy]

  def index
    respond_with current_user.zones
  end

  def show
    respond_with zone
  end

  def update
    zone.update(zone_params)
    respond_with zone
  end

  def destroy
    respond_with zone.destroy
  end

  def create
    respond_with :api, :v1, current_user.zones.create(zone_params)
  end

  private

  def zone
    @zone ||= Zone.find(params[:id])
  end

  def zone_params
    params.require(:zone).permit(:name, :city_name, :minutes_offset)
  end

  def authorize_user!
    if zone.user != current_user
      render status: :forbidden, json: {message: "You are not authorized to access this resource."}
    end
  end

end

