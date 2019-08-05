Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints :subdomain => 'minecraft' do
  root to: 'lander#index'
  get '/kart', to: 'lander#kart'
  get '/mapfolder', :to => redirect('/overviewer/')
    
  end
  
  
  get 'passkey', to: 'application#pkey'

  
constraints :subdomain => 'warp' do
scope module: 'warp' do
#  namespace :warp do
    root to: 'users#new'
    
constraints :domain => 'world-clone' do
  get '/.well-known/acme-challenge/Gh_vx-b_RURnzDNQV8hEGrPnn2ZBgm1fo_ZNPDh7Cp8', :to => redirect('/.well-known/acme-challenge/Gh_vx-b_RURnzDNQV8hEGrPnn2ZBgm1fo_ZNPDh7Cp8')
  
end
constraints :domain => 'world2' do
  get '/.well-known/acme-challenge/xySFohsy71COCvcTtHeHc45ph8v_obCM8Y_nFniH0H8', :to => redirect('/.well-known/acme-challenge/xySFohsy71COCvcTtHeHc45ph8v_obCM8Y_nFniH0H8')
end

	
	#get '/users/:user_id/
    get '/users/:user_id/replace', to: 'levels#replace', as: :viewer_replace
    get '/users/:user_id/remove', to: 'levels#remove', as: :viewer_remove
	
    #routes for a streamer / player
    resources :users, except: [:destroy] do
	  get 'submit', to: 'levels#create', as: :submission
      #routes for a level creator      
      resources :levels, only: [:index] do
		
		
	  end
    end
	
    get '/:api_key/', to: 'users#edit', as: :edit_list
	  
    get '/:api_key/enable', to: 'users#enable', as: :queue_open
    get '/:api_key/disable', to: 'users#disable', as: :queue_close
    
    get '/:api_key/clear/', to: 'users#clear', as: :list_clear_all
    get '/:api_key/skip/:level_code/', to: 'users#skip', as: :skip_level
    get '/:api_key/play/:level_code/', to: 'users#play', as: :play_level
    get '/:api_key/complete/:level_code/', to: 'users#complete', as: :complete_level
    get '/:api_key/remove/:level_code', to: 'users#remove', as: :remove_level
    get '/:api_key/reset/:level_code', to: 'users#reset', as: :reset_level
	  
  end
  
  
end
end
