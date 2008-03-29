
function Valuation.events.VARIABLES_LOADED()
	ValuationCfg = ValuationCfg or {
		["style"] = "blizzard",
	};
	
	Valuation["locale"] = Valuation.locale[GetLocale()] or Valuation.locale["enUS"];
	Valuation["styles"][ValuationCfg["style"]].Load();
	
	SlashCmdList["VALUATION"] = function (...) Valuation.OnSlashCmd("valuation", ...) end;
	SLASH_VALUATION1 = "/valuation";
	
	SlashCmdList["VALU"] = function (...) Valuation.OnSlashCmd("valu", ...) end;
	SLASH_VALU1 = "/valu";
end

