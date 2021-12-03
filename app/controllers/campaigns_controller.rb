class CampaignsController < ApplicationController
  include VaccinesHelper, RolesHelper

  # GET /campaings/1/assign_turns
  def assign_turns
    set_campaign
    @campaign = $campaign
    @turns_count = Turn.pendding.where(campaign_id: @campaign.id).count
  end

  def load_batch
    @campaign = $campaign
  end

  # POST /campaings/1/assign_turns
  def assign_turns_to_campaign
    @campaign = $campaign
    $turns_count = Turn.pendding.where(campaign_id: @campaign.id).count
    
    quantity_to_assign = params[:quantity_to_assign].to_i
    
    if quantity_to_assign > $turns_count
      flash[:danger] = I18n.t("campaign.not_enough_turns", turns: $turns_count)
      redirect_to assign_turns_path(@campaign)
    else
      stock = get_quantity_of_vaccines_available(@campaign)
      if quantity_to_assign > stock
        flash[:danger] = I18n.t("campaign.not_enough_vaccines", vaccines: stock)
        redirect_to assign_turns_path(@campaign)
      else
        @turns = Turn.pendding.joins(:user, :campaign, :vaccination_center).where(campaign_id: params[:id]).order("users.birthdate, turns.created_at")
        @turns = @turns.sort_by { |turn| turn.user.comorbidity ? 0 : 1 }
        @turns = @turns.slice!(0, quantity_to_assign)
    
        has_errors = false
        error = ""
    
        @turns.each do |turn|
          if turn.update(status: Turn.statuses[:assigned], date: params[:turn_date], campaign_id: params[:id])
            TurnMailer.with(turn: turn).assign_turn.deliver_later
          else
            error = turn.errors.full_messages.join(", ")
            has_errors = true
            break
          end
        end
    
        if has_errors
          flash[:danger] = "#{I18n.t("campaign.turns_not_assigned", campaign: @campaign.name)} - #{error}"
          render :assign_turns
        else
          flash[:success] = I18n.t("campaign.turns_assigned", campaign: @campaign.name, quantity: quantity_to_assign)
          redirect_to vaccines_url
        end
      end
    end 

  end

  # PATCH/PUT /vaccines/1 or /vaccines/1.json
  def update
    @campaign = Campaign.find(params[:id])
    params[:campaign][:stock] = stock_params[:stock].to_i + @campaign.stock
    if @campaign.update(stock_params)
      flash[:success] = I18n.t("campaign.stock_updated", campaign: @campaign.name)
      redirect_to vaccines_url
    else
      render :edit, status: :unprocessable_enti
    end
  end

  private

  def set_campaign
    $campaign = Campaign.find(params[:id])
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
