class FamiliesController < ApplicationController
	before_action :set_family, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :index, @family
    @active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
   authorize! :show, @family
  end

  def new
    authorize! :new, @family
    @family = Family.new
  end

  def edit
    authorize! :edit, @family
  end

  def create
    authorize! :create, @family
    @family = Family.new(family_params)
    if @family.save
      redirect_to @family, notice: "#{@family.family_name} family was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @family
    if @family.update(family_params)
      redirect_to @family, notice: "#{@family.family_name} family was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @family
    @family.destroy
    redirect_to families_url, notice: "#{@family_family.name} family was removed from the system."
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :phone, :email, :active)
    end

end
