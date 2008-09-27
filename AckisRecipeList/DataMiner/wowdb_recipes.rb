require "wowdb_helper"

=begin rdoc
This class handles parsing of WoWdb.com Receipe data from its json info.
see WoWDBHelper for details on constants
:section: Overview
Once you create a WoWDBRecipes object, you want to get a list of items
use one of the list methods. Once you obtain the high level object, you
may want to get exact detils of said object, at that point you should use
add_recipe_details to add the futher details to you object.
=end

=begin rdoc
Base Keys
:section: Base keys
Base keys that are available from after a get_xxx_list

:produces 
  ARRAY - [item id, count]
:skillup 
  ARRAY - [orange level,yellow level ,green level ,gray level]
:rarity 
  INTEGER
:reagents
  ARRAY - [ [item id, count] ...]
:learned 
  INTEGER - skill level required to learn this recipe
:id
  INTEGER - pattern item id
:is_armor
  BOOLEAN
:armor_slot
  STRING slot
:armor_type
  STRING type
:is_weapon
  BOOLEAN
:weapon_slot
  STRING
:weapon_handed
  STRING
:item_binds
  STRING (BOP,BOA,BOE)
:recipe_binds
  STRING
:classes
  STRING if there is a class requiremetn on the produced object
:professions
  STRING if there is a professions requirement, always be sure to see if it has a speciality which indicates a requirmeent
:speciality
  INTEGER profession id, retrieve the name of the speciality from the WoWDBReceipes object
:faction
  STRING
:faction_level
  STRING
=end

=begin rdoc  
Detaled keys
:section: Detailed Keys
Keys that are available after a add_details call

:specialty 
  INTEGER (optional) - Speciality skill required to learn this pattern
:spellid 
  INTEGER - spell id the recipe teaches
:method 
  STRING -list of methods to aquire this recipe, each method corresponds to a sub key for details
  possible methods
    *taugth-by (provides method_trainers) ARRAY
    *sold-by (provides method_vendors) ARRAY
    *contained-in-object (provides method_contained_in_object) ARRAY 
    *dropped-by (provides method_dropped_by) ARRAY 
    *contained-in-item (provides method_contained_in_item) ARRAY 
    *rewardfrom (provides method_quests) ARRAY
=end

=begin rdoc
Quest data format
:section Hash format for a quest

:id quest id
  INTEGER
:coin
  Amount of money for completing the quest
:giveitems
  ARRAY of item ids
:name Quest name
  STRING
:level quest level
  INTEGER
:type quest type
  INTEGER
:side which side
  INTEGER
:daily is this a daily found to be 1 to indicate true
  INTEGER 
:category used for sorting only not intended for use by end users.
  ARRAY
=end

=begin rdoc
NPC data formats
:section: Hash format for an NPC (trainer, vendor)
Trainers and Vendors

:type 
  INTEGER - npc type , see WoWDBHelper
:desc 
  STRING - description of the NPC
:minlevel 
  INTEGER - npc min level
:name 
  STRING - name of the trainer
:id 
  INTEGER - wowhead NPC id
:react 
  ARRAY - [alliance, horde]
=end

=begin rdoc
NPC data formats for drop mobs
:section: Hash format for NPC (drops)
NPC spcifics for drop npcs

:react 
  ARRAY - [alliance,horde]
:type 
  INTEGER - wowdb npc types
:minlevel 
  INTEGER - min level of the mob
:maxlevel 
  INTEGER - max level of the mob
:name 
  STRING - mob name
:lootCount 
  INTEGER - number of times this item was looted from this mob
:totalLootCount 
  INTEGER - total number of times this mob was looted
:id 
  INTEGER - wowdb npc id
:classification 
  INTEGER (Optional)
=end

=begin rdoc
:section: example usage

-- lookup a single item
  recipes = WoWDBRecipes.new
  bs_recipes = recipes.get_blacksmithing_list
  chain = bs_recipes['Steel Weapon Chain']
  recipes.add_recipe_details(chain)
  puts "Weaon chain aquired by #{chain[:method]}"

-- print out all items
  recipes = WoWDBRecipes.new
  bs_recipes = recipes.get_blacksmithing_list
  bs_recipes.each_pair do |name,data|
  puts "#{name} Skill: #{data[:skillups].join(",")}"
end 

=end
class WoWDBRecipes
  include JsonHelper
  include WoWDBHelper
  def initialize()
    @@alchemy = Hash.new
    @@blacksmithing = Hash.new
    @@enchanting = Hash.new
    @@engineering = Hash.new
    @@inscription = Hash.new
    @@jewelcrafting = Hash.new
    @@leatherworking = Hash.new
    @@tailoring = Hash.new
    @@first_aid = Hash.new
    @@mining = Hash.new
    @@specialities = Hash.new
    @@cooking = Hash.new
  end
=begin rdoc
  Get a list of all smelting recipes
  returns
    a Hash keys by receip name
=end
  def get_cooking_list
    if @@cooking.length == 0
      map = search_list("6.9.185")
      cleanup_list(map,@@cooking)
    end
    return @@cooking
  end

=begin rdoc
  Get a list of all smelting recipes
  returns
    a Hash keys by receip name
=end
  def get_mining_list
    if @@mining.length == 0
      map = search_list("6.11.186")
      cleanup_list(map,@@mining)
    end
    return @@mining
  end
=begin rdoc
  Get a list of All first aid recipes
  returns
    a Hash keyed by recipe name
=end
  def get_firstaid_list
    if @@first_aid.length == 0
      map = search_list("6.9.129")
      cleanup_list(map,@@first_aid)
    end
    return @@first_aid    
  end
=begin rdoc
  Get a list of all Alchemy Receipes
  returns 
    a Hash keyed by recipe name
=end
  def get_alchemy_list
    if @@alchemy.length == 0
      map = search_list("6.11.171")
      cleanup_list(map,@@alchemy)
    end
    return @@alchemy
  end
=begin rdoc
  Get a list of all Blacksmithing Receipes
  returns 
    a Hash keyed by recipe name
=end
  def get_blacksmithing_list
    if @@blacksmithing.length == 0
      map = search_list("6.11.164")
      cleanup_list(map,@@blacksmithing)
    end
    return @@blacksmithing
  end
=begin rdoc
  Get a list of all Enchanting Receipes
  returns: a hash keyed by recipe name
=end
  def get_enchanting_list
    if @@enchanting.length == 0
      map = search_list("6.11.333")
      cleanup_map(map,@@enchanting)
    end
    return @@enchanting
  end
=begin rdoc
  Get a list of all Engineering Receipes
  returns: a hash keyed by recipe name
=end  
  def get_engineering_list
    if @@engineering.length == 0
      map = search_list("6.11.202")
      cleanup_list(map,@@engineering)
    end
    return @@engineering
  end
=begin rdoc
  Get a list of all Inscription Receipes
  returns: a hash keyed by recipe name
=end
  def get_inscription_list
    if @@inscription.length == 0
      map = search_list("6.11.773")
      cleanup_list(map,@@inscription)
    end
    return @@inscription
  end
=begin rdoc
  Get a list of all Jewelcrafting Receipes
  returns: a hash keyed by recipe name
=end  
  def get_jewelcrafting_list
    if @@jewelcrafting.length == 0
      map = search_list("6.11.755")
      cleanup_list(map,@@jewelcrafting)
    end
    return @@jewelcrafting
  end
=begin rdoc
  Get a list of all Leatherworking Receipes
  returns: a hash keyed by recipe name
=end  
  def get_leatherworking_list
    if @@leatherworking.length == 0
      map = search_list("6.11.165")
      cleanup_list(map,@@leatherworking)
    end
    return @@leatherworking
  end
=begin rdoc
  Get a list of all Tailoring Receipes
  returns: a hash keyed by recipe name
=end  
  def get_tailoring_list
    if @@tailoring.length == 0
      map = search_list("6.11.197")
      cleanup_list(map,@@tailoring)
    end
    return @@tailoring
  end
=begin rdoc
  Get the name of a speciality for a given profession
  params: 
    skill
        Profession name that has a speciality  [Alchemy,Tailoring,Engineering,Blacksmithing,Leatherworking]
    id
        The speciality spell id, as provided in the recipe object after an add_recipe_details call.
  returns: the speciality skill name
=end
  def get_speciality(skill,id)
    if skill.eql?("Alchemy")
      get_alchemy_list
    elsif skill.eql?("Tailoring")
      get_tailoring_list
    elsif skill.eql?("Engineering")
      get_engineering_list
    elsif skill.eql?("Blacksmithing")
      get_blacksmithing_list
    elsif skill.eql?("Leatherworking")
      get_leatherworking_list
    else
      raise "Alchemy,Tailoring,Engineering,Blacksmithing,Leatherworking are the only Professions with a Speciality"
    end
    return @@specialities[id]
  end
  private
  def get_data_for_recipe_object(recipe_object)
    response = Net::HTTP.get(URI.parse("http://www.wowdb.com/item.aspx?id=#{recipe_object[:id]}"))      
    # we didnt have the spell in a trainer, so we are processing the drop recipe
    
  end
  public
=begin rdoc
  Add details to a recipe you retrieved from the list
  params:
    recipe_object
          Hash object retrieved via a list method
    is_item
          Wether this is a spell or item (defaults to false) normally not supplied by end user, used for recursive lookups
  returns: none
=end
  def process_tooltip(tooltip, recipe_object,is_item = false)
    mastery = tooltip.match(/Requires <a href=\\"spell\.aspx\?id=(\d+)\\"/)
    unless mastery.nil? or mastery.length == 0
      mastery_id = mastery[1].to_i
      recipe_object[:specialty] = mastery_id
    end
    bop = tooltip.match(/>Binds.*?picked.*?</)
    boa = tooltip.match(/>Binds.*?account.*></)
    boe = tooltip.match(/>Binds.*?equip.*></)
    if !bop.nil?
      recipe_object[:item_binds] = 'BOP'
    elsif !boa.nil?
      recipe_object[:item_binds] = 'BOA'
    elsif !boe.nil?
      recipe_object[:item_binds] = 'BOE'
    else
      recipe_object[:item_binds] = 'BOE'
    end
    unless is_item
      recipe_object[:recipe_binds] = recipe_object[:item_binds]
    end
    # heck for classes
    classes = tooltip.match(/<br>Classes:(.*?)</)
    unless classes.nil? or classes.length == 0
      klasses = classes[1]
      klasses.rstrip!
      klasses.lstrip!
      recipe_object[:classes] = klasses
    end
    skills = tooltip.match(/Requires.<a href=\# class=r1>(.*?)<\/a/)
    unless skills.nil? or skills.length == 0
      prof = skills[1]
      prof.lstrip!
      prof.rstrip!
      recipe_object[:profession] = prof
    end
    faction = tooltip.match(/<br>Requires.*faction.*?>(.*?)<..>.-.(.*?)</)
    unless faction.nil? or faction.length == 0
      fact = faction[1]
      amount = faction[2]
      recipe_object[:faction] = fact
      recipe_object[:faction_level] = amount
    end
    isArmor = tooltip.match(/Armor|Ring|Trinket|Relic|Cloak|Totem|Libram|Off.Hand|Amulet/)
    isWeapon = tooltip.match(/damage per second/)
    hasEquip = tooltip.match(/Equip:/)
    if !isArmor.nil? or !hasEquip.nil?
      recipe_object[:is_armor] = true
      armor_slot = tooltip.match(/>(Chest|Legs|Feet|Hands|Wrist|Shoulder|Back|Waist|Head|Neck|Finger|Trinket|Relic|Off.Hand)</)
      unless armor_slot.nil?
        recipe_object[:armor_slot] = armor_slot[1]
      else
        recipe_object[:armor_slot] = "Trinket"
      end
      armor_type = tooltip.match(/>(Cloth|Plate|Mail|Leather|Idol|Totem|Libram|Trinket|Amulet|Cloak|Shield|Ring)</)
      unless armor_type.nil?
        recipe_object[:armor_type] = armor_type[1]
      else
        recipe_object[:armor_type] = "Trinket"
      end
    end
    unless isWeapon.nil?
      recipe_object[:is_weapon] = true
      # what type of weapon?
      weapon_slot = tooltip.match(/(Sword|Axe|Bow|Gun|Mace|Polearm|Staff|Fist|Dagger|Thrown|Crossbow|Wand|Misc|Fishing.Pole|Ammo)/)
      unless weapon_slot.nil?
        recipe_object[:weapon_slot] = weapon_slot[1]
      end
      weapon_hands = tooltip.match(/(One-Hand|Two-Hand)/)
      unless weapon_hands.nil?
        recipe_object[:weapon_handed] = weapon_hands[1]
      end
    end
    
  end
  def add_recipe_details(recipe_object, is_item = false)
    if is_item
      response = Net::HTTP.get(URI.parse("http://www.wowdb.com/item.aspx?id=#{recipe_object[:id]}"))      
    else
      if recipe_object[:spellid].nil?
        recipe_object[:spellid] = recipe_object[:id]
      end
      response = Net::HTTP.get(URI.parse("http://www.wowdb.com/spell.aspx?id=#{recipe_object[:id]}"))
    end
    unless response
      raise "No recipe data found for #{recipe_object[:id]}"
    end
    response.gsub!(/\[\,/,"[")
    data_line = response.scan(/cg_items.addData\((.*)\);/).first
    cgData = {}
    unless data_line.nil?
      data_line = from_json(data_line.first)
      # check for specialities
      data_line.each do |line|
        #puts "Processing line #{line.inspect}"
        if line.has_key?(:id) and line.has_key?(:tooltip)
          cgData[line[:id]] = line[:tooltip]
        end
        if line.has_key?(:tooltip)
          process_tooltip(line[:tooltip],recipe_object,is_item)
        end
      end
    end
    # check for type
    recipe_object[:method] = ""
    json_data = Hash.new
    if response.include?("cg_json_1")
      json_data["cg_json_1"] = from_json(response.scan(/cg_json_1=(.*);/).first.first)
    end
    if response.include?("cg_json_2")
      json_data["cg_json_2"] = from_json(response.scan(/cg_json_2=(.*);/).first.first)
    end
    if response.include?("cg_json_3")
      json_data["cg_json_3"] = from_json(response.scan(/cg_json_3=(.*);/).first.first)
    end
    if response.include?("cg_json_4")
      json_data["cg_json_4"] = from_json(response.scan(/cg_json_4=(.*);/).first.first)
    end
    if response.include?("cg_json_5")
      json_data["cg_json_5"] = from_json(response.scan(/cg_json_5=(.*);/).first.first)
    end
    if response.include?("cg_json_6")
      json_data["cg_json_6"] = from_json(response.scan(/cg_json_6=(.*);/).first.first)
    end
    if response.include?("cg_json_7")
      json_data["cg_json_7"] = from_json(response.scan(/cg_json_7=(.*);/).first.first)
    end
    if response.include?("cg_json_8")
      json_data["cg_json_8"] = from_json(response.scan(/cg_json_8=(.*);/).first.first)
    end
    response.gsub!(/;/,";\n")
    tabs = response.scan(/DataGrid\((.*)\);/)
    unless tabs.nil?
      tabs.each do |tabd|
        tab = tabd.first
        tab.gsub!(/cg_primaryTabGroup/,"'cg_primaryTabGroup'")
        tab.gsub!(/Curse.DataGrid.Utility.processCounts/,"'preprocess'")
        tab.gsub!(/cg_json_(.)/,'\'cg_json_\1\'')
        tab.gsub!(/cg_comments(.)/,'\'cg_comments\'\1')
        tab.gsub!(/cg_screenshots(.)/,'\'cg_screenshots\'\1')
        tab.gsub!(/\[\,/,"[")
        tab = from_json(tab)
        tab[:id].downcase!
        tab[:template].downcase!
        if tab[:id].eql?("teaches-spell") and tab[:template].eql?("spells")
          jd = json_data[tab[:data]]
          unless jd.nil? and !recipe_object[:produces].nil?
            jd = jd.first
            unless cgData[recipe_object[:produces][0]].nil?
              process_tooltip(cgData[recipe_object[:id]],recipe_object,false)
              process_tooltip(cgData[recipe_object[:produces][0]],recipe_object,true)
            end
          end
        end
        # Trainers
        if tab[:id].eql?("taught-by") and tab[:template].eql?("npcs")
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:rarity] = 1
          recipe_object[:recipe_binds] = 'BOP'
          jd = json_data[tab[:data]]
          unless jd.nil?
            #jd.each do |h| h.delete(:locs) end
            # method_source will have an array of hashs of each trainer info
            recipe_object[:method_trainers] = jd
          end
        end
        # Receipes
        if (tab[:id].eql?("sold-by") and tab[:template].eql?("npcs"))
          jd = json_data[tab[:data]]
          #unless jd.nil?
          #  jd.each do |h| h.delete(:locs) end
          #end
          if recipe_object[:recipe_binds].nil?
            recipe_object[:recipe_binds] = 'BOE'
          end
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_vendors] = jd
          # method source now has another array with the actual receipe id for later lookup
        end

        if (tab[:id].eql?("dropped-by") and tab[:template].eql?("npcs")) 
          jd = json_data[tab[:data]]
          #unless jd.nil?
          #  jd.each do |h| h.delete(:locs) end
          #end
          if recipe_object[:recipe_binds].nil?
            recipe_object[:recipe_binds] = 'BOE'
          end
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_dropped_by] = jd
          # method source now has another array with the actual receipe id for later lookup
        end        
        if (tab[:id].eql?("contained-in-object") and tab[:template].eql?("objects")) 
          jd = json_data[tab[:data]]
          #unless jd.nil?
          #  jd.each do |h| h.delete(:locs) end
          #end
          if recipe_object[:recipe_binds].nil?
            recipe_object[:recipe_binds] = 'BOE'
          end
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_contained_in_objects] = jd
          # method source now has another array with the actual receipe id for later lookup
        end        
        
        if (tab[:id].eql?("contained-in-item") and tab[:template].eql?("items"))
          jd = json_data[tab[:data]]
          #unless jd.nil?
          #  jd.each do |h| h.delete(:locs) end
          #end
          if recipe_object[:recipe_binds].nil?
            recipe_object[:recipe_binds] = 'BOE'
          end
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_contained_in_items] = jd
          # method source now has another array with the actual receipe id for later lookup
        end        
        # Quests
        if tab[:id].eql?("rewardfrom") and tab[:template].eql?("quests")
          jd = json_data[tab[:data]]
          #unless jd.nil?
          #  jd.each do |h| h.delete(:locs) end
          #end
          if recipe_object[:recipe_binds].nil?
            recipe_object[:recipe_binds] = 'BOP'
          end
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_quests] = jd
          # method source now has another array with the actual receipe id for later lookup
        end
        if (tab[:id].eql?("enchantment") and tab[:template].eql?("items")) and recipe_object[:method].length == 0
          # possible from trainer, vendor or drop
          jd = json_data[tab[:data]].first
          unless jd.nil?
            #jd.each do |h| h.delete(:locs) end
            rid = jd[:id]
            recipe_object[:spellid] = recipe_object[:id]
            recipe_object[:id] = rid
            if jd[:rarity]
              recipe_object[:rarity] = jd[:rarity]
            end
            if !recipe_object[:item_binds].nil?
              recipe_object[:recipe_binds] = recipe_object[:item_binds]
            end
            recipe_object[:item_binds] = nil
            # recuse the lookup to get details
            add_recipe_details(recipe_object,true)
          end
        end
      end
      unless recipe_object[:method].nil?
        if recipe_object[:method].rindex(",") == recipe_object[:method].length-1
          recipe_object[:method].chop!
        end
      end  
      if recipe_object[:method].length == 0
        recipe_object[:method] = "taught-by"
        recipe_object[:recipe_binds] = 'BOP'
        recipe_object[:method_trainers] = [{:desc=>"Unknown", :type=>7, :minlevel=>0, :name=>"Unknown", :react=>[2, 2], :id=>0}]    
      end
      # Special Cases for certain types of objects
      if recipe_object[:profession].eql?("First Aid") or recipe_object[:profession].eql?("Enchanting")
        recipe_object[:item_binds] = "BOE"
      end      
    end
  end
  
  private
  def cleanup_map(srcMap,dstMap)
    srcMap.each do |src|
      src.delete(:category)
      src.delete(:skill)
      src.delete(:school)
      if not src[:skillup].nil? and not src[:reagents].nil?
        dstMap[src[:name]] = src
        dstMap[src[:name]].delete(:name)
      end
    end
  end
  def cleanup_list(srcMap,dstMap)
    srcMap.each do |src|
      src.delete(:category)
      src.delete(:skill)
      src.delete(:school)
      if not src[:produces].nil?
        dstMap[src[:name]] = src
        dstMap[src[:name]].delete(:name)
      end
      # matseries are added ID = Mastery
      if src[:rank].nil? and src[:produces].nil? and src[:skillup].nil?
        @@specialities[src[:id]] = src[:name]
      end
    end
  end
end