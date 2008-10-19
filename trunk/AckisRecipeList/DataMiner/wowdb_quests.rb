require "wowdb_helper"

class WoWDBQuests
  include JsonHelper
  include WoWDBHelper
  def initialize()
    @@quests = Hash.new
  end
  def get_quest_info(quest_id)
    if @@quests.has_key?(quest_id)
      return @@quests[quest_id]
    end
    response = Net::HTTP.get(URI.parse("http://www.wowdb.com/quest.aspx?id=#{quest_id}"))
    unless response
      raise "Data not available for quest #{quest_id}"
    end
    lst = response.scan(/<script>addMapLocations\((.*)\)<\/script>/).first
    if lst.nil?
      raise "No quest data for #{quest_id}"
    end
    qDetails = response.scan(/setFormattedText\(\"divQuestDetails\"\,.?\"?(.*?)\);/)
    if qDetails
      qDetails.flatten!
      qDetails = qDetails.first
      qDetails.lstrip!
      qDetails.rstrip!
      qDetails.gsub!(/<.*?>/,'')
      qDetails.gsub!(/\[\/?\w.*?\].*?\[\/?\w.*?\]/,'')
      qDetails.gsub!(/\&lt;/,'<')
      qDetails.gsub!(/\&gt;/,'>')
      qDetails.gsub!(/\\\'/,"'")
    end
    mapdata = from_json(lst.first)
    zone= []
    starting_npc = response.match(/Starting NPC: <a href=\"npc.aspx\?id=(\d+)\">/)
    unless starting_npc.nil? or starting_npc.length == 0
      starting_npc = starting_npc[1].to_i
    else
      starting_npc = 0
    end    
    ending_npc = response.match(/Finishing NPC: <a href=\"npc.aspx\?id=(\d+)\">/)
    unless ending_npc.nil? or ending_npc.length == 0
      ending_npc = ending_npc[1].to_i
    else
      ending_npc = 0
    end
    mapdata.each do |entry|
      entry[:coords].each do |c| c.delete_if {|e| e.is_a?(String) } end
      zone << entry
    end
    @@quests[quest_id] = {:quest_zones => zone, :quest_starter => starting_npc, :quest_finisher=> ending_npc, :quest_details => qDetails}
    return @@quests[quest_id]
  end
end