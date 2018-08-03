class ResidentsController < ApplicationController

  def create
    resident = Resident.new(resident_params)
    resident.route = Route.new
    resident.save
    
    render json: resident
  end
  
  private
  
    def resident_params
      params.require(:resident).permit(:phone_number)
    end

end
