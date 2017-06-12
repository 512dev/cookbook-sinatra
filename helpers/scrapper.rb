require 'nokogiri'
require 'open-uri'

class Scrapper

  def add_lcf(ingredient, diff = 0)
    array = []
    if diff.zero?
      html_file = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}")
    else
      html_file = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}&dif=#{diff}")
    end
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.m_contenu_resultat').each do |element|
      recipe = {}
      element.search('.m_titre_resultat').each { |name| recipe[:name] = name.text.strip }
      element.search('.m_detail_recette').each { |item| recipe[:description] = item.text.strip }
      element.search('.m_detail_time').each { |time| recipe[:time] = time.text.scan(/(\d+)/).flatten }
      array << recipe
    end
    array
  end
end