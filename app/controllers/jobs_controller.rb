class JobsController < ApplicationController
  before_action :authenticate_user!, only: %w( new create edit update destroy )

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      flash[:success] = 'Job created'
      redirect_to jobs_path
    else
      render :new
    end
  end

  def index
    redirect_to job_path Job.first if Job.first.present?
    @job_locations = JobLocation.all.order(:title)
  end

  def show
    @job_locations = JobLocation.all.order(:title)
    @job = Job.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        fenced_code_blocks: true,
                                        prettify: true)
    @breadcrumb_components.last[:name] = @job.title
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(job_params)
      flash[:success] = 'Job updated'
      redirect_to job_path @job
    else
      render :edit
    end
  end

  def destroy
    if Job.find(params[:id]).destroy
      redirect_to jobs_path
      flash[:success] = 'Job successfully deleted'
    else
      redirect_to jobs_path
      flash[:warning] = 'Problem deleting Job'
    end
  end

  private

    def job_params
      params.require(:job).permit(:title, :subtitle, :body, :apply_url,
                                  :job_location_id)
    end
end
