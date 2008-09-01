require "core"
require "wowdb_maps"
require "wowdb_recipes"

class Test
  include JsonHelper
  def doit(d)
    from_json(d)
  end
end

$testmaps = true
$testrecipes = false
d = Test.new()


if $testmaps
# Azermist isle mape data
f = File::open("wowdb-mapdata.txt")
m = f.read()
tbl = d.doit(m)
puts tbl[0][:mapLabel]
end

# Elixir of wisdom
if $testrecipes
r = File.open("recipe-list.txt")
n = r.read()
mbl = d.doit(n)
puts "#{mbl[20].inspect}"
end
# For RIGHT NOW not adding the dbc parser till can be discussed.
# require "dbc_file"
# test DBCFile and generate width,height for Silithus
# NOTE: test requires you to adjust the path to the dbc file, as this is copyright blizz and not
# able to check it into src control
#d = DBCFile.new("/Users/washu/WorldMapArea.dbc","iiisffffII")
#r = d.get_record(40)
#puts "#{r[3]} = {#{(r[5].to_f - r[4].to_f).abs},#{(r[7].to_f-r[6].to_f).abs}},"

# test wowdb map base class, handles herbs, minerals, pickable chest, normla containers, fish schools
# as list of name ot wowdb ID
if $testmaps
nodes = WoWDBMaps.new
results = nodes.get_map_locations(1617)
puts results["Westfall"].inspect
end

if $testrecipes
recipes = WoWDBRecipes.new
results = recipes.get_blacksmithing_list
thunder = results['Thunder']
recipes.add_recipe_details(thunder)

pots = recipes.get_alchemy_list
dream = pots['Transmute: Iron to Gold']
recipes.add_recipe_details(dream)
puts dream.inspect
end