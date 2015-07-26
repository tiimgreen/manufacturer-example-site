class TeamMembersController < ApplicationController
  before_action :authenticate_user!, except: %w( index show )

  def index
    @team_members = TeamMember.all
  end

  def new
    @team_member = TeamMember.new
  end

  def create
    @team_member = TeamMember.new(team_member_params)

    if @team_member.save
      flash[:success] = 'Team Member created'
      redirect_to team_members_path
    else
      render :new
    end
  end

  def edit
    @team_member = TeamMember.find(params[:id])
  end

  def update
    @team_members = TeamMember.find(params[:id])

    if @team_members.update_attributes(team_member_params)
      flash[:success] = 'Team Member updated'
      redirect_to team_members_path
    else
      render :edit
    end
  end

  def destroy
    if TeamMember.find(params[:id]).destroy
      redirect_to team_members_path
      flash[:success] = 'Team Member successfully deleted'
    else
      redirect_to team_members_path
      flash[:warning] = 'Problem deleting Team Member'
    end
  end

  private

    def team_member_params
      params.require(:team_member).permit(:first_name, :last_name,
                                          :contact_email, :job_title,
                                          :short_info, :avatar)
    end
end
