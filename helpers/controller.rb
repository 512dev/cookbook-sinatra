require_relative 'recipe_view.rb'
require_relative 'recipe.rb'
require_relative 'scrapper.rb'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = RecipeView.new
    @scrapper = Scrapper.new
  end

  def create
    new_recipe = @view.add_recipe
    @cookbook.add_recipe(Recipe.new(new_recipe))
    list
  end

  def destroy
    list
    index = @view.delete_recipe
    @cookbook.remove_recipe(index)
  end

  def list
    @view.list_recipies(@cookbook.all)
  end

  def web_recipe
    ingredient = @view.item_search_lcf
    difficulty = @view.difficulty_search
    new_recipies = @scrapper.add_lcf(ingredient, difficulty)
    new_recipies.each { |recipe| @cookbook.add_recipe(Recipe.new(recipe)) }
    list
  end

  def mark_as_done
    recipe = @view.mark_as_done(@cookbook)
    @cookbook.all[recipe].mark_as_done
  end
end
