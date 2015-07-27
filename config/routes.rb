Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: { sign_in: 'admin', sign_out: 'logout' }

  root 'home#index'

  resources :settings, only: %i(index show edit update)

  resources :page_element_texts, path: 'page-element-texts', only: %i(edit show update)
  resources :page_element_links, path: 'page-element-links', only: %i(edit show update)

  get 'contact', to: 'contact#index'

  get 'team',          to: 'team_members#index',   as: :team_members
  get 'team/new',      to: 'team_members#new',     as: :new_team_member
  get 'team/:id',      to: 'team_members#show',    as: :team_member
  get 'team/:id/edit', to: 'team_members#edit',    as: :edit_team_member
  match 'team',        to: 'team_members#create',  via: :post
  match 'team/:id',    to: 'team_members#update',  via: :patch
  match 'team/:id',    to: 'team_members#destroy', as: :delete_team_member, via: :delete

  get 'blog',               to: 'blog_articles#index',     as: :blog_articles
  get 'blog/new',           to: 'blog_articles#new',       as: :blog_article_new
  get 'blog/:id',           to: 'blog_articles#show',      as: :blog_article
  get 'blog/:id/edit',      to: 'blog_articles#edit',      as: :blog_article_edit
  get 'blog/:id/publish',   to: 'blog_articles#publish',   as: :blog_article_publish
  get 'blog/:id/unpublish', to: 'blog_articles#unpublish', as: :blog_article_unpublish
  match 'blog',             to: 'blog_articles#create',    via: :post
  match 'blog/:id',         to: 'blog_articles#destroy',   as: :blog_article_delete, via: :delete
  match 'blog/:id',         to: 'blog_articles#update',    via: :patch

  get 'jobs',          to: 'jobs#index', as: :jobs
  get 'jobs/new',      to: 'jobs#new',   as: :job_new
  get 'jobs/:id',      to: 'jobs#show',  as: :job
  get 'jobs/:id/edit', to: 'jobs#edit',  as: :job_edit
  match 'jobs',        to: 'jobs#create', via: :post
  match 'jobs/:id',    to: 'jobs#update', via: :patch
  match 'jobs/:id',    to: 'jobs#destroy', as: :job_delete, via: :delete

  get 'job-locations',          to: 'job_locations#index',   as: :job_locations
  get 'job-locations/new',      to: 'job_locations#new',     as: :job_locations_new
  get 'job-locations/:id',       to: 'job_locations#show',     as: :job_location
  get 'job-locations/:id/edit', to: 'job_locations#edit',    as: :job_location_edit
  match 'job-locations',        to: 'job_locations#create',  via: :post
  match 'job-locations/:id',    to: 'job_locations#destroy', as: :job_location_delete, via: :delete
  match 'job-locations/:id',     to: 'job_locations#update',  via: :patch

  get 'products',         to: 'products#index',   as: :products
  get 'products/new',      to: 'products#new',     as: :products_new
  get 'products/:id',      to: 'products#show',    as: :product
  get 'products/:id/edit', to: 'products#edit',    as: :product_edit
  match 'products',        to: 'products#create',  via: :post
  match 'products/:id',    to: 'products#destroy', as: :product_delete, via: :delete
  match 'products/:id',    to: 'products#update',  via: :patch

  get 'products/:product_id/specification/:specification_id',           to: 'products#new_specification',     as: :product_product_specification
  get 'products/:id/specifications',                                    to: 'products#index_specification',   as: :product_specifications
  get 'products/:id/add-specification',                                 to: 'products#new_specification',     as: :product_add_specification
  get 'products/:product_id/specifications/:specification_id/edit',     to: 'products#edit_specification',    as: :product_edit_specification
  match 'products/:product_id/specifications/:specification_id/delete', to: 'products#destroy_specification', as: :product_delete_specification, via: :delete
  match 'products/:id/specifications',                                  to: 'products#create_specification',  via: :post
  match 'products/:product_id/specifications/:specification_id',        to: 'products#update_specification',  via: :patch

  get 'products/:product_id/reviews/:review_id',                to: 'product_reviews#new',     as: :product_product_review
  get 'products/:id/reviews',                                   to: 'product_reviews#index',   as: :product_product_reviews
  match 'products/:product_id/reviews/:review_id/delete',       to: 'product_reviews#destroy', as: :delete_product_review, via: :delete
  match 'products/:id/reviews',                                 to: 'product_reviews#create',  via: :post
  match 'products/:product_id/reviews/:review_id',              to: 'product_reviews#update',  via: :patch

  get 'products/:id/images',                           to: 'product#index_images',  as: :product_product_images
  get 'products/:product_id/image/:image_id',          to: 'products#show_image',   as: :product_product_image
  get 'products/:id/add-image',                        to: 'products#new_image',    as: :product_add_image
  get 'products/:product_id/image/:image_id/edit',     to: 'products#edit_image',   as: :product_edit_image
  match 'products/:product_id/image/:image_id/delete', to: 'products#destroy_image', as: :product_delete_image, via: :delete
  match 'products/:id/images',                         to: 'products#create_image', via: :post
  match 'products/:product_id/image/:image_id',        to: 'products#update_image', via: :patch

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
