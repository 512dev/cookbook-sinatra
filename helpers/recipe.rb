# THIS IS THE MODEL

class Recipe
  attr_reader :name, :description, :time, :done
  def initialize(attributes = { done: false })
    @name = attributes[:name]
    @description = attributes[:description]
    @time = attributes[:time]
    @done = attributes[:done]
    @difficulty = attributes[:difficulty]
  end

  def done?
    @done
  end

  def mark_as_done
    @done = true
  end

  def to_s
    "#{@name}:  #{@description}, Prep Time: #{@time[0]}min"
  end
end
