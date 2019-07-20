class ApplicationController < ActionController::Base
  before_action :filter_ip

  def pkey
	
	pass = 'burper00'
	
	
	j = '{pass:"0'+Base64.encode64(pass)+'"}'
	
	render json: j
	
  end
  
  protected
  
  def filter_ip
    ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
	head :unauthorized if ip == '113.53.29.171'
  end	
	
end
