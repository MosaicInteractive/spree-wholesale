# Put your extension routes here.

# map.namespace :admin do |admin|
#   admin.resources :whatever
# end  

map.namespace :admin do |admin|
  admin.resources :users, :has_many => [:wholesale_products]
end
