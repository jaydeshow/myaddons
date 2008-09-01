require "wowdb_helper"

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
    @@specialities = Hash.new
  end
  
  def get_alchemy_list
    if @@alchemy.length == 0
      map = search_list("6.11.171")
      cleanup_list(map,@@alchemy)
    end
    return @@alchemy
  end
  def get_blacksmithing_list
    if @@blacksmithing.length == 0
      map = search_list("6.11.164")
      cleanup_list(map,@@blacksmithing)
    end
    return @@blacksmithing
  end
  def get_enchanting_list
    if @@enchanting.length == 0
      map = search_list("6.11.333")
      cleanup_list(map,@@enchanting)
    end
    return @@enchanting
  end
  def get_engineering_list
    if @@engineering.length == 0
      map = search_list("6.11.202")
      cleanup_list(map,@@engineering)
    end
    return @@engineering
  end
  def get_inscription_list
    if @@inscription.length == 0
      map = search_list("6.11.773")
      cleanup_list(map,@@inscription)
    end
    return @@inscription
  end
  
  def get_jewelcrafting_list
    if @@jewelcrafting.length == 0
      map = search_list("6.11.755")
      cleanup_list(map,@@jewelcrafting)
    end
    return @@jewelcrafting
  end
  
  def get_leatherworking_list
    if @@leatherworking.length == 0
      map = search_list("6.11.165")
      cleanup_list(map,@@leatherworking)
    end
    return @@leatherworking
  end
  
  def get_tailoring_list
    if @@tailoring.length == 0
      map = search_list("6.11.197")
      cleanup_list(map,@@tailoring)
    end
    return @@tailoring
  end
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
  
  # This method
  def add_recipe_details(recipe_object, is_item = false)
    if is_item
      response = Net::HTTP.get(URI.parse("http://www.wowdb.com/item.aspx?id=#{recipe_object[:id]}"))      
    else
      response = Net::HTTP.get(URI.parse("http://www.wowdb.com/spell.aspx?id=#{recipe_object[:id]}"))
    end
    unless response
      raise "No recipe data found for #{recipe_object[:id]}"
    end
    data_line = response.scan(/cg_items.addData\((.*)\);/).first
    unless data_line.nil?
      data_line = from_json(data_line.first)
      # check for specialities
      data_line.each do |line|
        if line.has_key?(:tooltip)
          mastery = line[:tooltip].scan(/Requires <a href=\\"spell\.aspx\?id=(\d+)\\"/).first
          unless mastery.nil? or mastery.length == 0
            mastery_id = mastery.first.to_i
            recipe_object[:specialty] = mastery_id
          end
        end
      end
    end
    # check for type
    recipe_object[:method] = ""
    recipe_object[:method_drops] = Array.new
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
    response.gsub!(/;/,";\n")
    tabs = response.scan(/DataGrid\((.*)\);/)
    unless tabs.nil?
      tabs.each do |tabd|
        tab = tabd.first
        tab.gsub!(/cg_primaryTabGroup/,"'cg_primaryTabGroup'")
        tab.gsub!(/Curse.DataGrid.Utility.processCounts/,"'preprocess'")
        tab.gsub!(/cg_json_(.)/,'\'cg_json_\1\'')
        tab = from_json(tab)
        # Trainers
        if tab[:id].eql?("taught-by") and tab[:template].eql?("npcs")
          recipe_object[:method] += "#{tab[:id]},"
          jd = json_data[tab[:data]]
          unless jd.nil?
            # method_source will have an array of hashs of each trainer info
            recipe_object[:method_trainers] = jd
          end
        end
        # Receipes
        if (tab[:id].eql?("sold-by") and tab[:template].eql?("npcs"))
          jd = json_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_vendors] = jd
          # method source now has another array with the actual receipe id for later lookup
        end
        if (tab[:id].eql?("dropped-by") and tab[:template].eql?("npcs")) or (tab[:id].eql?("contained-in-object") and tab[:template].eql?("objects")) or (tab[:id].eql?("contained-in-item") and tab[:template].eql?("items"))
          jd = json_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_drops] << jd
          # method source now has another array with the actual receipe id for later lookup
        end        
        # Quests
        if tab[:id].eql?("rewardFrom") and tab[:template].eql?("quest")
          jd = json_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_quests] = jd
          # method source now has another array with the actual receipe id for later lookup
        end
        if (tab[:id].eql?("enchantment") and tab[:template].eql?("items")) and recipe_object[:method].length == 0
          # possible from trainer, vendor or drop
          puts "possible recurse"
          jd = json_data[tab[:data]].first
          unless jd.nil?
            rid = jd[:id]
            recipe_object[:id] = rid
            # recuse the lookup to get details
            add_recipe_details(recipe_object,true)
          end
        end
      end
    end
  end
  
  private
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