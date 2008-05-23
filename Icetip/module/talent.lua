local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i

--天赋着色
function Icetip_talentColor(point, maxValue, order)
	local r, g, b
	local minp, maxp = 0, maxValue
	point = max(0, min(point, maxValue))
	if ((maxp - minp) > 0) then
		point = (point - minp)/(maxp - minp)
	else
		point = 0
	end
	if (point > 0.5) then
		r = 0.1 + (((1-point)*2) * (1-0.1))
		g = 0.9
	else
		r = 1.0
		g = (0.9) - (0.5-point)* 2 * (0.9)
	end
	r = strformat("%2x", r*255)
	if (#r == 1) then r = "0"..r; end
	g = strformat("%2x", g * 255)
	if (#g == 1) then g = "0"..g; end
	b = "18"
	if order then
		return "|cff"..r..g..b.."%s|r"
	else
		return "|cff"..g..r..b.."%s|r"
	end
end

--天赋名称
function getTalentSpecName(names, nums, colors)
	if nums[1]==0 and nums[2]==0 and nums[3]== 0 then
		return  _G.NONE, _G.NONE
	else
		local first, second, third, name, text, point
		if (nums[1] >= nums[2]) then
			if nums[1] >= nums[3] then
				first = 1
				if nums[2] >= nums[3] then 
					second = 2; third=3;	
				else
					second = 3; third = 2; 
				end
			else
				first = 3; second = 1; third = 2
			end
		else
			if nums[2] >= nums[3] then
				first = 2;
				if nums[1] >= nums[3] then
					second = 1; third = 3;
				else
					second = 3; third = 1;
				end
			else
				first = 3; second = 2; third = 1
			end
		end
		local first_num = nums[first]
		local second_num = nums[second]
		if (first_num * 3/4) <= second_num then
			if (first_num * 3/4) < nums[third] then
				name = colors[first]:format(names[first]).."/"..colors[second]:format(names[second]).."/"..colors[third]:format(names[third])
				text = names[first].."/"..names[second].."/"..names[third]
			else
				name = colors[first]:format(names[first]).."/"..colors[second]:format(names[second])
				text = names[first].."/"..names[second]
			end
		else
			name = colors[first]:format(names[first])
			text = names[first]
		end
		point = (" |cc8c8c8c8(%s|cc8c8c8c8/%s|cc8c8c8c8/%s|cc8c8c8c8)"):format(colors[1]:format(nums[1]), colors[2]:format(nums[2]), colors[3]:format(nums[3]))
		return name..point, text..(" (%s/%s/%s)"):format(nums[1], nums[2], nums[3])
	end
end