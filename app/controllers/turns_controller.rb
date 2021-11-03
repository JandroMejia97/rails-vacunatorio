class TurnsController < ApplicationController
  include SessionsHelper
  before_action :set_turn, only: %i[ show edit update destroy ]

  # GET /turns or /turns.json
  def index
    @turns = Turn.where(user_id: current_user.id)
    @pedding_turns = @turns.where(status: Turn.statuses[:pedding])
    @assigned_turns = @turns.where(status: Turn.statuses[:assigned])
    @finished_turns = @turns.where(status: Turn.statuses[:finished])
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:campaign_id, :vaccination_center_id)
    end
end