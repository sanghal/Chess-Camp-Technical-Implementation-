class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @active_users = User.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_users = User.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "#{@user.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "#{@user.name} was removed from the system."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def curriculum_params
      params.require(:user).permit(:name, :username,  :password_confirmation, :password, :instructor_id, :role, :active)
    end



end
