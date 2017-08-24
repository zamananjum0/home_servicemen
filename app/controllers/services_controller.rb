class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update]

  def index
    if current_user.role.role_name == 'User'
      @services = Service.where(user_id: current_user.role_id, status: 'pending' )
    else
      @services = Service.where(role_id: current_user.role_id, status: 'pending' )
    end
  end

  def accepted_request
  if current_user.role.role_name == 'User'
      @services = Service.where(user_id: current_user.id, status: 'accepted')
    else
      @services = Service.where(role_id: current_user.role_id, status: 'accepted')
    end

  end

  def completed_request
    if current_user.role.role_name == 'User'
      @services = Service.where(user_id: current_user.id, status: 'completed')
    else
      @services = Service.where(role_id: current_user.role_id, status: 'completed')

    end
  end

  def cancelled_request
    if current_user.role.role_name == 'User'
      @services = Service.where(user_id: current_user.id, status: 'cancel')
    else
      @services = Service.where(role_id: current_user.role_id, status: 'cancel')
    end
  end


  def accept_request
    service = Service.find_by_id(params[:id])
    service.status = 'accepted'
    service.service_man_id = current_user.id
    service.save!
    redirect_to services_path
  end

  def cancel_request
    service = Service.find_by_id(params[:id])
    service.status = 'cancel'
    service.service_man_id = current_user.id
    service.save!
    redirect_to services_path
  end

  def complete_request
    service = Service.find_by_id(params[:id])
    service.status = 'completed'
    service.service_man_id = current_user.id
    service.save!
    redirect_to services_path
  end


  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user_id = current_user.id
    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @service = Service.find(params[:id])
  end

  def user_profile
    @user = User.find(params[:id])

  end
  def servicemen_list
    @user = User.all
  end
  def plumbers_list
    @users = User.all
    @plumbers= @users.where("role = ?", "3")
  end
  def electricians_list
    @users = User.all
    @electricians= @users.where("role = electrician ")
  end
  def carpenters_list
    @users = User.all
    @carpenters= @users.where("role = carpneter ")
  end
  def cleaners_list
    @users = User.all
    @cleaners= @users.where("role = cleaner ")
  end

  # def serviceman_timeline
  #   @services = Service.all
  #
  #   # if current_user.role
  #   #
  #   # end
  #   # if current_user.electrician?
  #   #
  #   # end
  #   # if current_user.carpenter?
  #   #
  #   # end
  #   # if current_user.cleaner?
  #   #
  #   # end
  #
  # end

  private
  def set_service
    @service = Service.find_by_id(params[:id])
  end



  def service_params
    params.require(:service).permit(:service_name,:user_id,:status,:description,:phone_no,:role_id, :raw_address, :latitude, :longitude)
  end

end

