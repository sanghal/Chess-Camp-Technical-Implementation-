class RegistrationsController < ApplicationController
def new

    @registration = Registration.new
    @registration.camp_id = params[:camp_id] unless params[:camp_id].nil?
    @registration.student_id = params[:student_id] unless params[:student_id].nil?
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
       if params[:from] == 'camp'
        redirect_to camp_path(@registration.camp), notice: "registration was added to the system."
      elsif params[:from] == 'student'
        redirect_to student_path(@registration.student), notice: "registration was added to the system."
      end  
    else
      render action: 'new'
    end
  
  end

  def update
 
    if @registration.update(registration_params)
      redirect_to @registration, notice: "registration was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: "registration was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id , :student_id , :payment_status, :points_earned)
    end



end
