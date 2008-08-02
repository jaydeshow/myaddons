#!/usr/bin/env ruby -w

require 'net/http'

# Javascript data obejct to ruby
def javascript_to_ruby(d)
	  return eval(d.gsub(/\w+:\S/) { |key| k,v = key.split(/:/);k.lstrip!;k.rstrip!;key = ":#{k}=>#{v}";})
end

## http://www.wowdb.com/search.aspx?browse=6.11.171#spells:0+500
$professions = {
  "Alchemy" => "6.11.171",
  "Blacksmithing" => "6.11.164",
  "Enchanting" => " 6.11.333",
  "Engineering" => "6.11.202",
  "Inscription" => "6.11.773",
  "Jewelcrafting" => "6.11.755",
  "Leatherworking" => "6.11.165",
  "Tailoring" => "6.11.197"
}

# Recipe data format
# Recipe
#      skill,type,[indegrediants],rare?,specialization?
#  where 
#   method = Vendor|Trainer|Drop
#   rare = 1,2,3,4 (normal color markers)
#   specialization = special skill needed

def getRecipeList(profession)
  profID = $professions[profession]
  line = URI.parse("http://www.wowdb.com/search.aspx?browse=#{profID}#spells:0+500")
  #puts "#{line}"
  response = Net::HTTP.get(line)
  unless response
    raise "No spells found for profession #{profession}"
  end
  #puts "#{response}"
  lst = response.scan(/cg_json_1=(\[.*\])\;/)[0]
  if lst.nil?
    raise "No recipe data for #{profession}"
  end
  data = lst[0]
  lst = javascript_to_ruby(data)
  # filter out non-recipes
  # Speciality and Master skills IDs
  masteries = Hash.new
  lst.delete_if do |recipe|
      if recipe[:produces].nil?
        if recipe[:rank].nil?
          masteries[recipe[:id]] = recipe[:name]
        end
      end
      recipe[:produces].nil?
  end
  # remove the extra stuff we dont need for receipes
  lst.each do |k|
    k.delete(:category)
    k.delete(:skill)
    k.delete(:school)
  end
  lst << {:name => 'Specialities', :ids => masteries }
  # what we have in each element or the list:
  # name=xx,skillips=[x,x,x,x],produces=[item,count],reagents=[[item,count],xxx],learned=skilllevel,id=receipe_id,rarity=x
  return lst
end

def getRecipeDetails(recipe,masteries)
  # http://www.wowdb.com/spell.aspx?id=35580
  response = Net::HTTP.get(URI.parse("http://www.wowdb.com/spell.aspx?id=#{recipe[:id]}"))
  unless response
    raise "No recipe data found for #{recipeID}"
  end
  # First link in the cg data is the item mouse over
  links = response.scan(/>Requires <a href=\\"spell\.aspx\?id=(\d+)\\"/)[0]
  unless links.nil?
    l = links[0].to_i
    if masteries.has_key?(l)
      puts "Requires #{masteries[l]}"
      recipe[:speciality] = masteries[l]
    end
  end
  #if response.include?("Training Cost")
  #    recipe[:method] = "Trainer"
  #end
  # now time to gather the info ...
  recipe[:method] = ""
  tab1 = response.scan(/cg_json_1=(\[.*\])\;/)[0]
  if tab1[0].include?("Trainer")
    recipe[:method] = "Trainer,"
    # grab all the trainier ids
    trainers = javascript_to_ruby(tab1[0])
    trainers.each do |t|
      if t[:type] == 7
        puts "Trainer #{t[:name]}"
      end
    end
  end
  tab2 = response.scan(/cg_json_2=(\[.*\])\;/)[0]
  tab3 = response.scan(/cg_json_3=(\[.*\])\;/)[0]
  if !tab3.nil? and tab3[0].include?("Recipe")
      recipe[:method] = ""
      tb = javascript_to_ruby(tab3[0])
      if tb[0][:source].include?(2)
        recipe[:method] += "Vendor,"
      end
      if tb[0][:source].include?(1)
        recipe[:method] += "Drop,"
      end
      if tb[0][:source].include?(3)
        recipe[:method] += "Quest,"
      end
  end
  article = response.scan(/addArticle\((.*)\);/)[0]
  if recipe[:method] == ""
    if article[0].include?("quest")
      recipe[:method] = "Quest,"
    elsif article[0].include?("loot")
      recipe[:method] = "Drop,"
    end
  end
  recipe[:method].chop!
  puts recipe.inspect
end

# example part of grabbing all receipes for alchemy
alchemy = Hash.new
data = getRecipeList("Alchemy")
data.each do |d|
  recipe = d[:name]
  alchemy[recipe] = d
end
puts alchemy["Specialities"].inspect
puts data.size
getRecipeDetails(alchemy['Minor Rejuvenation Potion'],alchemy["Specialities"][:ids])

