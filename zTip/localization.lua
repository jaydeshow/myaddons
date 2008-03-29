local locale = GetLocale()

-- Localization
function zTip:Localize()
	if locale == "zhCN" then
		self.locStr = {
			Rare			= "稀有",
			Targeting	= "目标",
			YOU			= ">> 你 <<",
			Self			= "自己",
			NotSpecified	= "未指定",
			Specified	= "神秘物种",
			Talent			= "天赋: ",
			TargetedBy		= "关注",
		}
	elseif locale == "zhTW" then
		self.locStr = {
			Rare			= "稀有",
			Targeting	= "目標",
			YOU			= ">> 你 <<",
			Self			= "自己",
			NotSpecified	= "未指定", -- 也許不正確？
			Specified	= "神秘物種",
			Talent			= "天賦: ",
			TargetedBy		= "關註",
		}
	else
		self.locStr = {
			Rare			= "Rare",
			Targeting	= "Targeting",
			YOU			= ">> U <<",
			Self			= "Self",
			NotSpecified	= "Not specified", -- maybe not correct
			Specified	= "Mystery",
			Talent			= "Taient: ",
			TargetedBy		= "TargetedBy",
		}
	end
end

function zTipOption:Localize()
	if locale == "zhCN" then
		self.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "锚点位置",
			["Offsets"] = "偏移值",
			["Original Position Offsets"] = "原始位置偏移",
			["Target"] = "目标",
			["Fade"] = "渐隐",
			["PVPName"] = "军衔",
			["Reputation"] = "声望",
			["RealmName"] = "服务器名",
			["IsPlayer"] = "标识(玩家)",
			["ClassIcon"] = "职业图标",
			["VividMask"] = "立体化",
			["ShowTalent"] = "天赋",
			["TargetedBy"] = "关注目标",
			["Scale"] = "缩放",
			["FollowCursor"] = "鼠标右下",
			["RootOnTop"] = "屏幕上方",
			["OnCursorTop"] = "鼠标上方",
			["RightBottom"] = "右下角",
			["OffsetX"] = "水平偏移",
			["OffsetY"] = "垂直偏移",
			["OrigPosX"] = "默认水平偏移",
			["OrigPosY"] = "默认垂直偏移",
		}
	elseif locale == "zhTW" then
		self.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "錨點設定",
			["Offsets"] = "偏移設定",
			["Original Position Offsets"] = "原始偏移設定",
			["Target"] = "目標",
			["Fade"] = "淡出",
			["PVPName"] = "官階",
			["Reputation"] = "聲望",
			["RealmName"] = "伺服器名",
			["IsPlayer"] = "標示(玩家)",
			["ClassIcon"] = "職業圖示",
			["VividMask"] = "立體化",
			["ShowTalent"] = "天賦",
			["TargetedBy"] = "關註目標",
			["Scale"] = "縮放",
			["FollowCursor"] = "游標右下",
			["RootOnTop"] = "屏幕上方",
			["OnCursorTop"] = "游標正上",
			["RightBottom"] = "右下角",
			["OffsetX"] = "水平偏移",
			["OffsetY"] = "垂直偏移",
			["OrigPosX"] = "原始水平偏移",
			["OrigPosY"] = "原始垂直偏移",
		}
	else
		self.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "Positions",
			["Offsets"] = "Offsets",
			["Original Position Offsets"] = "Original Position Offsets",
			["Target"] = "Target",
			["Fade"] = "Fade",
			["PVPName"] = "PVPName",
			["Reputation"] = "Reputation",
			["RealmName"] = "RealmName",
			["IsPlayer"] = "Mark(Player)",
			["ClassIcon"] = "ClassIcon",
			["VividMask"] = "VividMask",
			["ShowTalent"] = "ShowTalent",
			["TargetedBy"] = "TargetedBy",
			["Scale"] = "Scale",
			["FollowCursor"] = "FollowCursor",
			["RootOnTop"] = "RootOnTop",
			["OnCursorTop"] = "OnCursorTop",
			["RightBottom"] = "RightBottom",
			["OffsetX"] = "OffsetX",
			["OffsetY"] = "OffsetY",
			["OrigPosX"] = "OrigPosX",
			["OrigPosY"] = "OrigPosY",
		}
	end
end