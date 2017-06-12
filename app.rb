require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "helpers/cookbook"
require_relative "helpers/recipe"
require_relative "helpers/scrapper"
require 'nokogiri'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file    = File.join(__dir__, 'helpers/recipes.csv')
COOKBOOK = Cookbook.new(csv_file)
SCRAPPER = Scrapper.new

get '/' do
  erb :index
end
get '/about' do
  erb :about
end
get '/edit_cookbook' do
  erb :edit_cookbook
end
get '/list' do
  @recipes = COOKBOOK.all
  erb :list
end
get '/search' do
  erb :search
end
get '/add_recipe' do
  erb :add
end
get '/remove_recipe' do
  @recipes = COOKBOOK.all
  erb :remove
end
post '/recipes' do
  recipe = Recipe.new(params)
  COOKBOOK.add_recipe(recipe)
  redirect "/list"
end
post '/search' do
  recipies = SCRAPPER.add_lcf(params[:ingredient], params[:diff].to_i)
  recipies.each { |recipe| COOKBOOK.add_recipe(Recipe.new(recipe)) }
  redirect "/list"
end
post '/remove' do
  
  COOKBOOK.remove_recipe(params[:index].to_i - 1)
  redirect "/list"
end
