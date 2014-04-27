class FamiliesController < ApplicationController
	before_action :set_family, only: [:show, :edit, :update, :destroy]

  def index
    @active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @family = ㄹFamily.new
  end

  def edit
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      redirect_to @family, notice: "#{@family.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @family.update(family_params)
      redirect_to @family, notice: "#{@family.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @family.destroy
    redirect_to families_url, notice: "#{@family.name} was removed from the system."
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def curriculum_params
      params.require(:family).permit(:family_name, :parent_first_name, :phone, :email, :active)
    end

end
