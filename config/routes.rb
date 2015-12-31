Rails.application.routes.draw do

  unless  Gem::Specification::find_all_by_name('route_translator').any?

    # normal translation scoping
    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
      resources :books do
        member do
          get  :admin_view
          post :publish
          post :unpublish
        end
      end

      resources :book_components do
        member do
          post :publish
          post :unpublish
        end
        collection { post :sort }
      end
    end

  else # special routing for localized routes via the route_translator gem

    localized do
      resources :books do
        member do
          get  :admin_view
          post :publish
          post :unpublish
        end
      end

      resources :book_components do
        member do
          post :publish
          post :unpublish
        end
        collection { post :sort }
      end
    end

  end

end
