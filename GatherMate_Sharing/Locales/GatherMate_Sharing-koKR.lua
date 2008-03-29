local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate_Sharing","koKR")
if not L then return end

-- Addon name
L["Gathermate_Sharing"] = "데이터 공유"
L["MODULE_DESC"] = "데이터 공유란? 현재 캐릭터가 포함되어 있는 길드의 다른 플레이어와 GatherMate의 데이터를 공유하는 것입니다. 이 때에는 자동으로 추가/삭제를 자동으로 하게 됩니다."

-- Configuration
L["Enable GatherMate_Sharing"] = "데이터 공유 가능"
L["Enable or disable syncing of GatherMate data with other players."] = "다른 플레이어와의 데이터를 공유합니다."
L["Gathermate_Sharing Options"] = "데이터 공유 설정"
L["Sync node additions"] = "노드 추가 공유"
L["When other players add nodes to their GatherMate, automatically add the same node to your database too."] = "다른 플레이어의 노드가 추가 됐을 경우 자동으로 내 데이터에도 추가횝니다."
L["Sync node deletions"] = "노드 삭제 공유"
L["When other players delete nodes from their GatherMate, automatically delete the same node from your database too."] = "다른 플레이어의 노드가 삭제 됐을 경우 자동으로 내 데이터도 삭제됩니다."
