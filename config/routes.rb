Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints :subdomain => 'minecraft' do
  # scope module: 'minecraft' do
    root to: 'lander#index'
    get '/kart', to: 'lander#kart'
    get '/mapfolder', :to => redirect('/overviewer/')
  # end
  end

  constraints :subdomain => 'warp' do
    scope module: 'warp' do
      #routes for a viewer and new users
      root to: 'users#new'
      resources :users, only: [:new, :create] do
        get 'submit', to: 'levels#create', as: :submission
        get 'replace', to: 'levels#replace', as: :replacement
        get 'remove', to: 'levels#remove', as: :removal

        resources :levels, only: [:index] do
        end
      end

      #routes for existing users
      scope ':api_key' do
        root to: 'users#edit', as: :edit_list
        patch 'update', to: 'users#update', as: :update_queuer

        scope 'q' do  #for control of queue
          get 'enable', to: 'users#enable', as: :queue_open
          get 'disable', to: 'users#disable', as: :queue_close
          get 'clear', to: 'users#clear', as: :list_clear_all
        #TO DO: below
          get 'timer', to: 'users#set_timer', as: :queue_timer
          get 'next', to: 'users#next', as: :go_to_next
          get 'prev', to: 'users#prev', as: :go_to_prev
        end
        scope 'c' do  #for streamer's controls in list
        get 'skip/:level_code/', to: 'users#skip', as: :skip_level
        get 'play/:level_code/', to: 'users#play', as: :play_level
        get 'complete/:level_code/', to: 'users#complete', as: :complete_level
        get 'remove/:level_code', to: 'users#remove', as: :remove_level
        get 'reset/:level_code', to: 'users#reset', as: :reset_level
        end
      end

    end
  end

  
end