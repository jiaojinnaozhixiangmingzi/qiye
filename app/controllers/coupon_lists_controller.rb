class CouponListsController < ApplicationController
  before_action :set_coupon_list, only: [:show, :edit, :update, :destroy]

  # GET /coupon_lists
  # GET /coupon_lists.json
  def index
    @coupon_lists = CouponList.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  # GET /coupon_lists/1
  # GET /coupon_lists/1.json
  def show
  end

  # GET /coupon_lists/new
  def new
    @coupon_list = CouponList.new
  end

  # GET /coupon_lists/1/edit
  def edit
  end

  # POST /coupon_lists
  # POST /coupon_lists.json
  def create
    @coupon_list = CouponList.new(coupon_list_params)

    respond_to do |format|
      if @coupon_list.save
        format.html { redirect_to @coupon_list, notice: 'Coupon list was successfully created.' }
        format.json { render :show, status: :created, location: @coupon_list }
      else
        format.html { render :new }
        format.json { render json: @coupon_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupon_lists/1
  # PATCH/PUT /coupon_lists/1.json
  def update
    respond_to do |format|
      if @coupon_list.update(coupon_list_params)
        format.html { redirect_to @coupon_list, notice: 'Coupon list was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon_list }
      else
        format.html { render :edit }
        format.json { render json: @coupon_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_lists/1
  # DELETE /coupon_lists/1.json
  def destroy
    @coupon_list.destroy
    respond_to do |format|
      format.html { redirect_to coupon_lists_url, notice: 'Coupon list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_list
      @coupon_list = CouponList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_list_params
      params.require(:coupon_list).permit(:name, :validity_type, :valid_from, :valid_to, :fixed_begin_term, :fixed_term)
    end
end
