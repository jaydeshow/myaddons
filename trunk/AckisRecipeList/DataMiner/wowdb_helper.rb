require "core"
require "net/http"
=begin rdoc
 Some WoWDB constants
 NPC types:
  1 - Beast
  2 - Dragonkin
  3 - Demon
  4 - Elemental
  5 - Giant
  6 - Undead 
  7 - Humanoid
  8 - Critter
  9 - Mechanical
  10 - Unknown
  11 - Totem
  12 - Non Combat Pet
  13 - Gas Cloud
 Rarity levels:
  5 - Legendary
  4 - Epic
  3 - Rare
  2 - Uncommon
  1 - Common
 NPC Classifications:
  1 - Elite
  3 - Boss
  4 - Rare
 Reaction Types:
  0 - Unknown
  1 - Hated
  2 - Neutral
  3 - Friendly
 Quest Sides:
  1 - Both
  2 - Alliance
  4 - Horde
 Quest Types:
  0 - normal
  62 - Raid
  60 - PVP
  81 - Dungeon
  
  
=end
module WoWDBHelper
  include JsonHelper
  def search_list(search_id)
    response = Net::HTTP.get(URI.parse("http://www.wowdb.com/search.aspx?browse=#{search_id}"))
    unless response
      raise "Data not available for #{search_id}"
    end
    lst = response.scan(/cg_json_1=(.*);/).first
    if lst.nil?
      raise "No search results found"
    end
    data = lst.first
    return from_json(data)
  end
end