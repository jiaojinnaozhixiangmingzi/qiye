class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = current_user.addresses.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_path, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_path, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def suggestion
    url = 'http://api.map.baidu.com/place/v2/suggestion'
    resp = RestClient.get url, {params: {region: '全国', output: 'json', ak: '9c0105d4f31da574429c49cca95c5566', query: params[:term]}}

    result = JSON.parse(resp)['result'].map do |result|
      city = Region.find_by_name_and_level(result['city'], 2)
      area = city.children.find_by_name(result['district'])
      {id: result['name'], text: result['name'], lat: result['location']['lat'], lng: result['location']['lng'], region_id: area.id}
    end
    
    render json: {results: result}
  end

  def createAddress
    @address = Address.new(create_address_params)
    respond_to do |format|
      if @address.save
        format.json { render :json => {:data => @address}.to_json }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
    end

  def getAddressByUser
    @address = Address.find_by_sql(["SELECT * FROM addresses WHERE addressable_type = 'User' and addressable_id = ?;
", params[:userId]])
    respond_to do |format|
      if @address.empty?
        format.json { render :json => {:data => "Get failed"}.to_json }
      else
        format.json { render :json => {:data => @address}.to_json }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:address, :lat, :lng, :comment, :contact_name, :contact_phone)
      end

    def create_address_params
      params.permit(:address, :lat, :lng, :addressable_type, :addressable_id)
    end
end
