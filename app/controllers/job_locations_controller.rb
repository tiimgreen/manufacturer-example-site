class JobLocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @job_locations = JobLocation.all
  end

  def new
    @job_location = JobLocation.new
  end

  def create
    @job_location = JobLocation.new(job_location_params)

    if @job_location.save
      flash[:success] = 'Job Location created'
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job_location = JobLocation.find(params[:id])

    # Edit Breadcrumbs
    @breadcrumb_components.last[:name] = "Edit #{@job_location.title}"
    @breadcrumb_components.delete_at(-2)
  end

  def update
    @job_location = JobLocation.find(params[:id])

    if @job_location.update_attributes(job_location_params)
      flash[:success] = 'Job Location updated'
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    if JobLocation.find(params[:id]).destroy
      redirect_to job_locations_path
      flash[:success] = 'Job Location successfully deleted'
    else
      redirect_to job_locations_path
      flash[:warning] = 'Problem deleting Job Location'
    end
  end

  private

    def job_location_params
      params.require(:job_location).permit(:title)
    end
end
