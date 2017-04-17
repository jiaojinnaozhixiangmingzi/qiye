class WorkersController < ApplicationController
   load_and_authorize_resource
  
  before_action :set_worker, only: [:show, :edit, :update, :destroy]
  
  def index
    @workers = Worker.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  # GET /workers/1
  # GET /workers/1.json
  def show
  end

  # GET /workers/new
  def new
    @worker = Worker.new
  end

  def create
    @worker = Worker.new(worker_create_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to workers_path, notice: 'Worker was successfully created.' }
        format.json { render :show, status: :created, location: @worker }
      else
        format.html { render :new }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    @worker = Worker.where(["email = ? and encrypted_password = ?", params[:email], params[:encrypted_password]])

    respond_to do |format|
      if @worker.empty?
        format.json { render :json => {:data => "Login failed"}.to_json}
      else
        format.json { render :json => {:data => "Login succ!"}.to_json}
      end
    end
  end

  # GET /workers/1/edit
  def edit
  end

  def reset_password
  end

  # PATCH/PUT /workers/1
  # PATCH/PUT /workers/1.json
  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to workers_path, notice: 'Worker was successfully updated.' }
        format.json { render :show, status: :ok, location: @worker }
      else
        format.html { render :edit }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Worker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_current_city
    session[:current_city_id] = params[:id]
    redirect_to :back
  end

  private
    def set_outlet
      @outlet = Outlet.find(params[:outlet_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.require(:worker).permit(:email, :encrypted_password, role_ids: [], city_ids: [])
    end

   def worker_create_params
     params.require(:worker).permit(:email, :password, :encrypted_password, role_ids: [], city_ids: [])
   end

end
