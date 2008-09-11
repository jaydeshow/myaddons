require "core"
require "wowdb_maps"
require "wowdb_recipes"
require "wowdb_pets_and_mounts"
class Test
  include JsonHelper
  def doit(d)
    from_json(d)
  end
end

$testmaps = false
$testrecipes = true
$testpets = false
$testdbc = false
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
if $testdbc
require "dbc_file"
d = DBCFile.new("/Users/washu/Downloads/WorldMapArea-2.dbc","iiisffffI")
r = d.get_record(40)
puts "#{r[3]} = {#{(r[5].to_f - r[4].to_f).abs},#{(r[7].to_f-r[6].to_f).abs}},"
end
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
thunder = results['Steel Weapon Chain']
puts "PRE"
puts thunder.inspect
#puts "Copper #{results['Copper Bracers']}"
#puts "Runed Copper Pants #{results['Runed Copper Pants']}"
#puts "Shining Silver Breastplate #{results['Shining Silver Breastplate']}"
recipes.add_recipe_details(thunder)
puts "POST"
if thunder[:method].include?("dropped-by")
  dropped = thunder[:method_drops]
  dropped.first.each do |drop|
    puts drop.inspect
  end
end
#puts thunder.inspect

pots = recipes.get_alchemy_list
dream = pots['Transmute: Iron to Gold']
recipes.add_recipe_details(dream)
#puts dream.inspect
end

if $testpets
  list = WoWDBPetsAndMounts.new
  pets = list.get_pet_list
  data = pets['Lifelike Mechanical Toad']
  #pets.each_pair do |name,data|
    list.add_item_details(data)
    puts "Pet: #{data.inspect}"
  #end
  #pdata = pets['Dragon Kite']
  #list.add_item_details(pdata)
  #puts "\nPet: #{pdata.inspect}\n\n"
  mounts = list.get_mount_list
  data = mounts['Reins of the Veridian Netherwing Drake']
  #mounts.each_pair do |name,data|
  list.add_item_details(data)
  puts "Mount: #{data.inspect}"
  questonly = mounts['Black Qiraji Resonating Crystal']
  list.add_item_details(questonly)
  puts "Mount: #{questonly.inspect}"
  #end
end