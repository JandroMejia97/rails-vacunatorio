class CampaignsController < ApplicationController
  include VaccinesHelper

  # GET /campaings/1/assign_turns
  def assign_turns
    @campaign = Campaign.find(params[:id])
    @vaccines = Vaccine.where(campaign_id: @campaign.id)
  end

  def load_batch
    @campaign = Campaign.find(params[:id])
  end

  # POST /campaings/1/assign_turns
  def assign_turns_to_campaign
    @turns =  Turn.where(campaign_id: params[:id], status: Turn.statuses[:pendding]).order
  end

  # PATCH/PUT /vaccines/1 or /vaccines/1.json
  def update
    @campaign = Campaign.find(params[:id])
    params[:campaign][:stock] = stock_params[:stock].to_i + @campaign.stock
    if @campaign.update(stock_params)
      flash[:success] = I18n.t('campaign.stock_updated', campaign: @campaign.name)
      redirect_to vaccines_url
    else
      render :edit, status: :unprocessable_enti
    end
  end

  private
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def assing_turns_params
      params.require(:assign_turns).permit(:vaccine_id, :quantity_to_assign)
    end

    def stock_params
      params.require(:campaign).permit(:stock)
    end

    def campaign_params
      params.require(:campaign).permit(:name, :description, :stock)
    end
    
end