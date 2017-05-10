class UserCardLogsController < ApplicationController
  before_action :set_user_card_log, only: [:show, :edit, :update, :destroy]

  # GET /user_card_logs
  # GET /user_card_logs.json
  def index
    @user_card_logs = UserCardLog.all
  end

  # GET /user_card_logs/1
  # GET /user_card_logs/1.json
  def show
  end

  # GET /user_card_logs/new
  def new
    @user_card_log = UserCardLog.new
  end

  # GET /user_card_logs/1/edit
  def edit
  end

  # POST /user_card_logs
  # POST /user_card_logs.json
  def create
    @user_card_log = UserCardLog.new(user_card_log_params)

    respond_to do |format|
      if @user_card_log.save
        format.html { redirect_to @user_card_log, notice: 'User card log was successfully created.' }
        format.json { render :show, status: :created, location: @user_card_log }
      else
        format.html { render :new }
        format.json { render json: @user_card_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_card_logs/1
  # PATCH/PUT /user_card_logs/1.json
  def update
    respond_to do |format|
      if @user_card_log.update(user_card_log_params)
        format.html { redirect_to @user_card_log, notice: 'User card log was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_card_log }
      else
        format.html { render :edit }
        format.json { render json: @user_card_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_card_logs/1
  # DELETE /user_card_logs/1.json
  def destroy
    @user_card_log.destroy
    respond_to do |format|
      format.html { redirect_to user_card_logs_url, notice: 'User card log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getList
    @user_card_logs = UserCardChargeSetting.find_by_sql(["SELECT * FROM user_card_logs WHERE kind = 3 AND
user_card_id = (SELECT id FROM user_cards WHERE user_id = ? LIMIT 1) ORDER BY created_at DESC;", params[:userId]])
    respond_to do |format|
      if @user_card_logs.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @user_card_logs}.to_json }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_card_log
      @user_card_log = UserCardLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_card_log_params
      params.require(:user_card_log).permit(:kind, :real_money, :fake_money, :loggable_type, :loggable_id)
    end
end
