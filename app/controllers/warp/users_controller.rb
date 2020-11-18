class Warp::UsersController < ApplicationController
  
  #before_action :set_warp_user, only: [:destroy]
  before_action :using_api_key, only: [:update, :enable, :disable, :play, :start, :remove, :skip, :complete, :reset, :clear]
  
  after_action :respond_to_submission_management, only: [:enable, :disable]
  
  
    
  def play     #unused
    code = params[:code]
    if code != nil then
      # change level
      @warp_user.current = Level.find_by(code: code)
      @warp_user.save
    end
  end

  
  def enable
    allow_submissions
  end
  def disable
    allow_submissions false
  end    
  def clear
    @warp_user.levels.destroy_all
  end





  def redir
    redirect_to queuer_path(params[:api_key])
  end

  def start
    level = Warp::Level.find_by user_id: @warp_user.id, code: params[:level_code]
    level.status = "current"
    level.started_at = Time.now
    level.save
    redir
  end
  
  def remove
    level = Warp::Level.find_by user_id: @warp_user.id, code: params[:level_code]
    level.destroy
    redir
  end
  
  def reset
    level = Warp::Level.find_by user_id: @warp_user.id, code: params[:level_code]
    level.status = nil
    level.started_at = nil
    level.completed_at = nil
    level.save
    redir
  end
  
  def complete
    level = Warp::Level.find_by user_id: @warp_user.id, code: params[:level_code]
    level.status = "completed"
    level.completed_at = Time.now
    level.save
    redir
  end
  
  def skip
    level = Warp::Level.find_by user_id: @warp_user.id, code: params[:level_code]
    level.status = "skipped"
    level.completed_at = Time.now
    level.save
    redir
  end
  
  # GET /warp/users
  # GET /warp/users.json
  def index
    @warp_users = Warp::User.all
  end


  # GET /warp/users/new
  def new
    @warp_user = Warp::User.new
  end

  # GET /warp/users/1/edit
  def edit
    @warp_user = Warp::User.find_by(api_key: params[:api_key])
    if @warp_user == nil then
      render plain: "Sorry, but you either haven't signed up, or you've mistyped. P:"
      return
    end
    @levels = Warp::Level.find @warp_user.level_ids  
  end

  # POST /warp/users
  # POST /warp/users.json
  def create
    @warp_user = Warp::User.new(warp_user_params)

    respond_to do |format|
      if @warp_user.save
        format.html { redirect_to queuer_path(@warp_user.api_key), notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @warp_user }
      else
        format.html { render :new }
        #format.json { render json: @warp_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warp/users/1
  # PATCH/PUT /warp/users/1.json
  def update
    new_name = params[:new_name]
    new_key = params[:new_key]
    @warp_user.channel_name = new_name
    @warp_user.api_key = new_key
    @warp_user.save
    respond_to do |format|
        format.html { redirect_to queuer_path(@warp_user.api_key), notice: 'User was successfully updated.' }
    end
  end

  # DELETE /warp/users/1
  # DELETE /warp/users/1.json
  def destroy
    @warp_user.destroy
    respond_to do |format|
      format.html { redirect_to warp_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warp_user
      @warp_user = Warp::User.find(params[:id])
    end
    def using_api_key
      @warp_user = Warp::User.find_by api_key: params[:api_key]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def warp_user_params
      params.require(:warp_user).permit(:api_key, :channel_name)
    end
	
	
	# allow / deny level submissions
    def allow_submissions(bool=true)
      @warp_user.active = bool
      @warp_user.save
    end
    def respond_to_submission_management
      @active = @warp_user.active
    end
end
