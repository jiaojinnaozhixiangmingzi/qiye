class UserCardsController < ApplicationController
  before_action :set_user_card, only: [:show, :edit, :update, :destroy, :charge]
  before_action :set_user, only: [:charge]

  # GET /user_cards
  # GET /user_cards.json
  def index
    @user_cards = UserCard.all
  end

  # GET /user_cards/1
  # GET /user_cards/1.json
  def show
  end

  # GET /user_cards/new
  def new
    @user_card = UserCard.new
  end

  # GET /user_cards/1/edit
  def edit
  end

  # POST /user_cards
  # POST /user_cards.json
  def create
    @user_card = UserCard.new(user_card_params)

    respond_to do |format|
      if @user_card.save
        format.html { redirect_to @user_card, notice: 'User card was successfully created.' }
        format.json { render :show, status: :created, location: @user_card }
      else
        format.html { render :new }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_cards/1
  # PATCH/PUT /user_cards/1.json
  def update
    respond_to do |format|
      if @user_card.update(user_card_params)
        format.html { redirect_to @user_card, notice: 'User card was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_card }
      else
        format.html { render :edit }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_cards/1
  # DELETE /user_cards/1.json
  def destroy
    @user_card.destroy
    respond_to do |format|
      format.html { redirect_to user_cards_url, notice: 'User card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getUserCard
    @user_cards = UserCard.find_by_sql(["SELECT * FROM user_cards WHERE user_id = ? LIMIT 1;", params[:userId]])
    userCard = @user_cards[0]
    respond_to do |format|
      if @user_cards.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => userCard}.to_json }
      end
    end
  end

  def charge
    if request.post?
      @user_card_log = UserCardLog.new(user_card_log_params.merge(kind: 1, loggable: current_worker, user_card: @user.user_card))

      respond_to do |format|
        if @user_card_log.save
          @user.user_card.charge(@user_card_log.real_money, @user_card_log.fake_money)
          format.html { redirect_to @user, notice: '充值成功！' }
        else
          format.html { render :new }
        end
      end
    else
      @user_card_log = UserCardLog.new
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_card
    @user_card = UserCard.find(params[:id])
  end


  def user_card_params
    params.require(:user_card).permit(:real_money, :balance, :user_id)
  end

  def user_card_log_params
    params.require(:user_card_log).permit(:real_money, :fake_money)
  end
end
