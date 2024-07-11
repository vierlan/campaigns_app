class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all

  end

  def show
    @campaign = Campaign.find(params[:id])
    @votes = @campaign.votes.includes(:candidate)
  end
end
