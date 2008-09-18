require "core"
require "wowdb_maps"
require "wowdb_recipes"
require "wowdb_pets_and_mounts"
require "wowdb_factions"

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
$test_factions = false
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
thunder = results['Light Earthforged Blade']
recipes.add_recipe_details(thunder)
puts "Light Earthforged Blade: #{recipes.get_speciality('Blacksmithing',thunder[:specialty])} #{thunder[:profession]} #{thunder[:is_weapon]}"

pots = recipes.get_alchemy_list
dream = pots['Flask of Supreme Power']
recipes.add_recipe_details(dream)
puts "Flask of Supreme Power rarity: #{dream[:rarity]} #{dream[:is_armor]}"

eng = recipes.get_tailoring_list
goggles = eng['Swiftheal Mantle']
recipes.add_recipe_details(goggles)
puts "Mantle: #{goggles[:profession]} #{goggles[:is_armor]} #{goggles[:armor_slot]} #{goggles[:armor_type]}"

bandaids = recipes.get_firstaid_list
v = bandaids['Heavy Silk Bandage']
#bandaids.each_pair do |k,v|
  recipes.add_recipe_details(v)
  puts "Heavy Silk Bandage = #{v[:method]} #{v[:is_armor]} #{v[:armor_slot]} #{v[:armor_type]}"
#end
linen = bandaids['Heavy Mageweave Bandage']
recipes.add_recipe_details(linen)
puts "Heavy Mageweave Bandage: #{linen[:method]}"
mining = recipes.get_mining_list
#mining.each_pair do |k,v|
#  puts "Skill #{k}"
#end


cooking = recipes.get_cooking_list
puts "Cooking #{cooking.size}"
#bandaids.each_pair do |k,v|
#  recipes.add_recipe_details(v)
#  puts "First aid skill: #{k} = #{v.inspect}"
#end
jc = recipes.get_jewelcrafting_list
hear = jc['Ornate Tigerseye Necklace']
recipes.add_recipe_details(hear)
puts "Ornate Tigerseye Necklace #{hear.inspect}"

engl = recipes.get_engineering_list
cgoogle = engl['Deathblow X11 Goggles']
recipes.add_recipe_details(cgoogle)
puts "Deathblow X11 Goggles: #{cgoogle.inspect}"

philstone = pots['Alchemist\'s Stone']
recipes.add_recipe_details(philstone)
puts "Philo stone #{philstone.inspect}"


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
if $test_factions
  # Get the list of reputations 	 
  	factions = WoWDBFactions.new 
  	reputations = factions.get_faction_list   	  
    reputations.keys.sort_by {|k|reputations[k] = reputations[k][:id];reputations[k]}.each do |k|
      puts "Faction: (#{reputations[k]}) #{k}"  
    end
end