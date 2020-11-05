class Warp::LevelsController < ApplicationController
  
  
  def replace
    submitter = CGI::unescape params[:added_by]
    
    code = params[:code]
    pattern = /(([a-hj-np-yA-Z0-9]{3}-){2}[a-hj-np-yA-Z0-9]{3})/
    matches = code.match(pattern)
    if matches == nil or matches == [] then
      render plain: "Sorry, you must've misspelled - try again @#{submitter}!"      
      return
    end
    code = matches[0]
    
    warp_user = Warp::User.find params[:user_id]
	
    level = Warp::Level.find_by(added_by: submitter, user_id: warp_user.id, status: nil)
	if level == nil or level == [] then
      render plain: "Sorry, @#{submitter} - you've not submitted any replaceable levels recently!"
      return
    else
	  #["current", "skipped", "completed"].each do |s|
	  #  if s == level.status then
	  #    level
		  
		#  render :plain => nil
     #     return
    #    end
	 # end
    end
    
    level.code = code
    level.save
    
    render plain: "@#{submitter}, your most recent submission has been successfully replaced!"
    
  end
  
  # render plain: "Sorry, #{submitter} - that's not a level you've submitted! Try again."
  
  def remove
    submitter = CGI::unescape params[:added_by]
    
    code = params[:code]
    pattern = /(([a-hj-np-yA-Z0-9]{3}-){2}[a-hj-np-yA-Z0-9]{3})/
    matches = code.match(pattern)
    if matches == nil or matches == [] then
      render plain: "Sorry, you must've misspelled - try again @#{submitter}!"      
      return
    end
    code = matches[0]
    
    warp_user = Warp::User.find params[:user_id]
    
	# viewer has mistyped
    level = Warp::Level.find_by code: code
    if level == nil or level == [] then
      render plain: "Sorry, #{submitter} - that's not a level you've submitted -"
      return
    end
    
    # viewer has not submitted ANY levels
    level = Warp::Level.find_by user_id: warp_user.id, added_by: submitter, status: nil
    if level == nil or level == [] then
      render plain: "Sorry, @#{submitter} - you've not submitted any removable levels recently!"
      return
    end
    
	#
	
    level.destroy
    render plain: "@#{submitter}, your level (#{code}) has been successfully removed from the queue! But why? 😯"
    
  end
  
  
  
  # GET /warp/levels
  # GET /warp/levels.json
  def index
    @warp_user = Warp::User.find params[:user_id]
    @levels = @warp_user.levels
    #@warp_levels = Warp::Level.where user_id: @warp_user.id
  end


  # POST /warp/levels
  # POST /warp/levels.json
  def create
    submitter = CGI::unescape params[:added_by]
    user = Warp::User.find params[:user_id]
    #check if queue is closed or not
    if user.active == false then
      render plain: "Sorry, @#{submitter} - it seems like the submission queue has been closed for now!"
      return
    end
    code = params[:code]

    pattern = /(([a-hj-np-yA-Z0-9]{3}[-|\s]){2}[a-hj-np-yA-Z0-9]{3})/
    matches = code.match(pattern)
    if matches != nil then
      code = matches[0]
      warp_level = Warp::Level.where(code: code, user_id: user.id)
      if warp_level == nil or warp_level == [] then

      warp_level = Warp::Level.new
      warp_level.added_by = submitter
      warp_level.code = code
      warp_level.user_id = user.id
      warp_level.save
      
      render plain: "@#{submitter}, your level has been successfully added to our queue!"
      else
      render plain: "Sorry, @#{submitter}, it seems someone has added that level to the queue already!"
      end
    else
      render plain: "Sorry, you must've misspelled - try again @#{submitter}!"      
    end
    return
  
    

    respond_to do |format|
      if @warp_level.save
        format.html { redirect_to @warp_level, notice: 'Level was successfully created.' }
        format.json { render :show, status: :created, location: @warp_level }
      else
        format.html { render :new }
        format.json { render json: @warp_level.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warp_level
      @warp_level = Warp::Level.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warp_level_params
      #params.require(:code, :added_by)
    end
end
