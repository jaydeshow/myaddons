require "core"
require "net/http"
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