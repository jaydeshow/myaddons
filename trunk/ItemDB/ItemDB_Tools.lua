function ItemDB_baseidFromLink(linktext)
	if linktext then
		local _,_,baseid = string.find(linktext, "^.*item:(%-?%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+.*$");
		return baseid;
	end
	return;
end

function ItemDB_idFromLink(linktext)
	if linktext then
		local _,_,id = string.find(linktext, "^.*item:(%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+).*$");
		return id;
	end
	return;
end

