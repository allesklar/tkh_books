namespace :tkh_books do

  desc "Create migrations"
  task :install do
    system 'rails g tkh_books:create_or_update_migrations'
  end

  desc "Update files. Skip existing migrations."
  task :update do
    system 'rails g tkh_books:create_or_update_migrations -s'
  end

end
