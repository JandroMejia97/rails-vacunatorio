class TurnsController < ApplicationController
  include SessionsHelper, RolesHelper
  before_action :set_turn, only: %i[ show edit update destroy ]

  # GET /turns or /turns.json
  def index
    @turns = Turn.where(user_id: current_user.id)
    @pedding_turns = @turns.where(status: Turn.statuses[:pendding])
    @assigned_turns = @turns.where(status: Turn.statuses[:assigned])
    @finished_turns = @turns.where(status: Turn.statuses[:finished])
   end

  def show_all
    @turns=Turn.where(status: Turn.statuses[:finished]).or(Turn.where(status: Turn.statuses[:canceled])).or(Turn.where(status: Turn.statuses[:lost]))
    if params[:search_date]
    @turns, @message = @turns.search_date(params[:search_date], @turns)
    if @message[:error].present?
      flash[:error] = @message[:error]
    else
      @turns
    end
  end
  end

  # GET /turns/1 or /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns or /turns.json
  def create
    @turn = Turn.new(turn_params)
    @turn.user_id = current_user.id

    respond_to do |format|
      if @turn.save
        flash[:success] = I18n.t('base_text.success_saved')
        format.html { redirect_to turns_url }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1 or /turns/1.json
  def update
    respond_to do |format|
      if @turn.update(turn_params)
        format.html { redirect_to @turn }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turns/1 or /turns/1.json
  def destroy
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to turns_url }
    end
  end

  def mark_turns_as_lost
   @turns=Turn.where(status: Turn.statuses[:assigned],date: Date.today,vaccination_center_id: current_user.vaccination_center_id)
   @turns.update_all(status: Turn.statuses[:lost])
  end

  def pending_turns
    @covid_turns=Turn.where(status: Turn.statuses[:pendding]).where(date: Date.today).where(campaign_id: 1)
    @fever_turns=Turn.where(status: Turn.statuses[:pendding]).where(date: Date.today).where(campaign_id: 3)
    @flu_turns=Turn.where(status: Turn.statuses[:pendding]).where(date: Date.today).where(campaign_id: 2)
    @turn =Turn.where(status: Turn.statuses[:pendding]).where(date: Date.today)
    @turns, @message = Turn.search(params[:search])
    if @message[:error].present?
      flash[:danger] = @message[:error]
    else
      @turns
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:campaign_id, :vaccination_center_id, :user_id)
    end
end
