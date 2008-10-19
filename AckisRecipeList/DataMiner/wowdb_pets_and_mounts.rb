require "wowdb_helper"

class WoWDBPetsAndMounts
  include JsonHelper
  include WoWDBHelper
  def initialize()
    @@pets = Hash.new
    @@mounts = Hash.new
  end
  def get_mount_list
    if @@mounts.length == 0
      map = search_list("1.15.-1&filters=146=Summons%20and%20dismisses")
      cleanup_list(map,@@mounts)
    end
    return @@mounts
  end
  def get_pet_list
    if @@pets.length == 0
      map = search_list("1&filters=146=Right%20Click%20to%20summon%20and%20dismiss")
      cleanup_list(map,@@pets)
    end
    return @@pets
  end
  def add_item_details(recipe_object)
    data = get_item_data(recipe_object[:id])
    unless data
      raise "No data found for #{recipe_object[:id]}"
    end
    tooltips = data[0]
    tab_data = data[1]
    tabs = data[2]
    if tooltips[recipe_object[:id]]
      tooltip = tooltips[recipe_object[:id]]
      spell_id = tooltip.match(/spell.aspx\?id=(\d+)/)
      if spell_id and spell_id.length > 0
        recipe_object[:spell_id] = spell_id[1].to_i
      end
    end
    # check for type
    recipe_object[:method] = ""
    unless tabs.nil?
      tabs.each do |tab|
        tab[:id].downcase!
        tab[:template].downcase!
        # Trainers
        if tab[:id].eql?("taught-by") and tab[:template].eql?("npcs")
          recipe_object[:method] += "#{tab[:id]},"
          jd = tab_data[tab[:data]]
          unless jd.nil?
            recipe_object[:method_trainers] = jd
          end
        end
        # Receipes
        if (tab[:id].eql?("sold-by") and tab[:template].eql?("npcs"))
          jd = tab_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_vendors] = jd
          # method source now has another array with the actual receipe id for later lookup
        end
        if (tab[:id].eql?("dropped-by") and tab[:template].eql?("npcs")) or (tab[:id].eql?("contained-in-object") and tab[:template].eql?("objects")) or (tab[:id].eql?("contained-in-item") and tab[:template].eql?("items"))
          jd = tab_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_drops] = jd
          # method source now has another array with the actual receipe id for later lookup
        end        
        # Quests
        if tab[:id].eql?("rewardfrom") and (tab[:template].eql?("quest") or tab[:template].eql?("quests"))
          jd = tab_data[tab[:data]]
          recipe_object[:method] += "#{tab[:id]},"
          recipe_object[:method_quests] = jd
          # method source now has another array with the actual receipe id for later lookup
        end
        #if tab[:id].eql?("screenshots") and recipe_object[:method].eql?("redemption,")
        #  jd = tab_data[tab[:data]].first
        #  recipe_object[:method_redemption] = jd[:caption]
        #  if recipe_object[:method_redemption].nil?
        #    recipe_object[:method_redemption] = "Unknown"
        #  end
        #end
        if tab[:id].eql?("createdby") and tab[:template].eql?("spells")
          jd = tab_data[tab[:data]].first
          if jd[:school] and jd[:school] >= 1 or jd[:learned]
            recipe_object[:method] += "crafted,"
            recipe_object[:method_crafted] = jd[:id]
          else
            recipe_object[:method] = "redemption,"
            recipe_object[:method_redemption] = "Unknown"
          end
        end        
      end
      unless recipe_object[:method].nil?
        recipe_object[:method].chop!
      end
    end
  end
  
  private
  def cleanup_list(srcMap,dstMap)
    srcMap.each do |src|
      unless dstMap.has_key?(src[:name])
        dstMap[src[:name]] = src
        dstMap[src[:name]].delete(:name)
      end
    end
  end
end

