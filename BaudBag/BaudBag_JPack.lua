--if not IsAddOnLoaded("JPack") then return end

function BaudBag_JPack_Click()
	if JPackFrame_Slash then
		JPackFrame_Slash("")
	elseif pack then
		pack()
	else
		if not IsAddOnLoaded("JPack") then 
			UIErrorsFrame:AddMessage("|cff7fff7fBagnon_Ex|r: JPack未加载")
		else
			UIErrorsFrame:AddMessage("|cff7fff7fBagnon_Ex|r: JPack可能已被修改。")
		end
	end
end
