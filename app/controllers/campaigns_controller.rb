class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all

  end

  def show
    @campaign = Campaign.find(params[:id])
    @votes_by_candidate = @campaign.votes.joins(:candidate)
                                        .where(validity: 'during')
                                        .group('candidates.name')
                                        .count
    @votes_out_of_time = @campaign.votes.where(validity: 'pre').count + @campaign.votes.where(validity: 'post').count
    @candidates = Candidate.where(id: @campaign.votes.pluck(:candidate_id).uniq)
  end
end
