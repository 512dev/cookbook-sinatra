# THIS IS THE REPO
require 'csv'


class Cookbook
  def initialize(csv_file_path)
    @filepath = csv_file_path
    @cookbook = []
    @recipe_hash = {}
    CSV.foreach(csv_file_path) do |row|
      @recipe_hash[:name] = row[0]
      @recipe_hash[:description] = row[1]
      p row
      @cookbook << Recipe.new(@recipe_hash)
    end
  end

  def add_recipe(recipe_to_add)
    @cookbook << recipe_to_add
    push_csv
  end

  def remove_recipe(index)
    @cookbook.delete_at(index)
    push_csv
  end

  def all
    @cookbook
  end

  private

  def push_csv
    CSV.open(@filepath, 'wb') do |csv|
      @cookbook.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
