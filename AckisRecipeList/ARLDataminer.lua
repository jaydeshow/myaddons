$LOAD_PATH << './DataMiner'
require "core.rb"
require "wowdb_maps.rb"
require "wowdb_recipes.rb"

class Test
  include JsonHelper
  def doit(d)
    from_json(d)
  end
end


recipes = WoWDBRecipes.new

alchemy = recipes.get_alchemy_list

#dream = alchemy['Transmute: Iron to Gold']
#recipes.add_recipe_details(dream)

alchemy.each do |info|
	puts info
	foo = alchemy[info[:name]]
	puts foo
	recipes.add_recipe_details(foo)
end


# data = {:method_vendors=>[{:price=>[8000, 0, 0], :type=>7, :locs=>[440], :react=>[1, 1],
#      :desc=>"Alchemy Supplies", :name=>"Alchemist Pestlezugg", :minlevel=>45, :id=>5594}],
#   :learned=>200, :produces=>[3577], :skillup=>[200, 240, 260, 280], :method_drops=>[],
#   :rarity=>2, :method=>"sold-by,", :reagents=>[[3575, 1]], :id=>9304}
 
 
# Assuming the containing structure is an array...
 
new_data = foo.map do |data|
   source, trainerflag = "Unknown", "nil"
   source, trainerflag = 'L["Trainer"]', 1 unless data[:method_vendors].nil?
   %Q|self:addTradeSkillSpell(#{data[:id]}, #{data[:skillup].first}, #{source}, #{trainerflag})|
end
 
p new_data.join("\n")
