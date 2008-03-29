﻿local L = AceLibrary("AceLocale-2.2"):new("Recount")

L:RegisterTranslations("zhCN", function() return {
	["Sync"] = "同步",
	["sync"] = "sync",
	["Toggles sending synchronization messages"] = "开启/关闭发送同步信息",
	["Reset"] = "重置",
	["reset"] = "reset",
	["Resets the data"] = "重置统计数据",
	["VerChk"] = "版本检查",
	["verChk"] = "verChk",
	["Displays the versions of players in the raid"] = "显示团队成员安装的 Recount 版本",
	["Displaying Versions"] = "显示版本",
	["Show"] = "显示",
	["show"] = "show",
	["Shows the main window"] = "显示主窗口",
	["Hide"] = "隐藏",
	["Hides the main window"] = "隐藏主窗口",
	["Toggle"] = "开启/关闭",
	["Toggles the main window"] = "开启/关闭主窗口显示",
	["Report"] = "报告",
	["Allows the data of a window to be reported"] = "发送统计数据的结果报告到指定的频道",
	["Detail"] = "详细",
	["Report the Detail Window Data"] = "发送详细的数据报告",
	["Main"] = "主要",
	["Report the Main Window Data"] = "只发送主窗口中显示的统计数据报告",
	["Config"] = "设置",
	["Shows the config window"] = "显示插件的设置窗口",
	["ResetPos"] = "重置位置",
	["Resets the positions of the detail, graph, and main windows"] = "恢复各个窗口的默认显示位置",
	["Lock"] = "锁定",
	["Toggles windows being locked"] = "开启/关闭窗口的显示位置锁定",
	["|cffff4040Disabled|r"] = "|cffff4040禁用|r",
	["|cff40ff40Enabled|r"] = "|cff40ff40启用|r",
	["Unknown Spells"] = "未知法术",
	["Shows found unknown spells in BabbleSpell"] = "显示 BabbleSpell 库中找到的未知法术",
	["Unknown Spells:"] = "未知法术：",
	["Realtime"] = "实时曲线图",
	["Specialized Realtime Graphs"] = "显示指定单位的实时统计曲线图",
	["FPS"] = "FPS",
	["Starts a realtime window tracking your FPS"] = "开启一个实时监控画面帧数的曲线图",
	["Lag"] = "延时",
	["Starts a realtime window tracking your latency"] = "开启一个实时监控网络延时的曲线图",
	["Upstream Traffic"] = "上行传输",
	["Starts a realtime window tracking your upstream traffic"] = "开启一个实时监控网络上行传输情况的曲线图",
	["Downstream Traffic"] = "下行传输",
	["Starts a realtime window tracking your downstream traffic"] = "开启一个实时监控网络下行传输情况的曲线图",
	["Available Bandwidth"] = "可用带宽",
	["Starts a realtime window tracking amount of available AceComm bandwidth left"] = "开启一个实时监控 AceComm 可用带宽情况的曲线图",
	["Tracks your entire raid"] = "追踪团队整体状况的曲线图",
	["DPS"] = "伤害/秒",
	["Tracks Raid Damage Per Second"] = "开启一个实时监控团队整体每秒伤害输出量的曲线图",
	["DTPS"] ="承受伤害/秒",
	["Tracks Raid Damage Taken Per Second"] ="开启一个实时监控团队整体每秒伤害承受量的曲线图",
	["HPS"] = "治疗/秒",
	["Tracks Raid Healing Per Second"] = "开启一个实时监控团队整体每秒治疗输出量的曲线图",
	["HTPS"] = "接受治疗/秒",
	["Tracks Raid Healing Taken Per Second"] = "开启一个实时监控团队整体每秒治疗承受量的曲线图",
	["Pet"] = "宠物",
	["Mob"] = "怪物",
	["Title"] = "标题",
	["Background"] = "背景",
	["Title Text"] = "标题文本",
	["Bar Text"] = "计量条文本",
	["Show previous main page"] = "显示前一个主要页面",
	["Show next main page"] = "显示下一个主要页面",
	["Display"] = "显示",
	["Damage Done"] = "伤害输出",
	["Friendly Fire"] = "队友误伤",
	["Damage Taken"] = "承受伤害",
	["Healing Done"] = "治疗输出",
	["Healing Taken"] = "获得治疗",
	["Overhealing Done"] = "过量治疗输出",
	["Deaths"] = "死亡",
	["DOT Uptime"] = "DOT持续时间",
	["HOT Uptime"] = "HOT持续时间",
	["Dispels"] = "驱散",
	["Dispelled"] = "被驱散",
	["Interrupts"] = "打断施法",
	["Ressers"] = "复活",
	["CC Breakers"] = "打醒控制",
	["Activity"] = "活跃度",
	["Threat"] = "仇恨",
	["Mana Gained"] = "法力获取",
	["Energy Gained"] = "能量获取",
	["Rage Gained"] = "怒气获取",
	["Network Traffic(by Player)"] = "网络传输(玩家排列)",
	["Network Traffic(by Prefix)"] = "网络传输(前缀排列)",
	["Bar Color Selection"] = "计量条颜色",
	["Class Colors"] = "职业颜色",
	["Reset Colors"] = "重置颜色",
	["Filters"] = "过滤器",
	["Players"] = "玩家",
	["Self"] = "自己",
	["Grouped"] = "已组队",
	["Ungrouped"] = "未组队",
	["Pets"] = "宠物",
	["Mobs"] = "怪物",
	["Trivial"] = "无价值",
	["Non-Trivial"] = "有价值",
	["Bosses"] = "首领",
	["Unknown"] = "未知",
	["Bar Selection"] = "选择样式",
	["Font Selection"] = "选择字体",
	["General Window Options"] = "一般窗口选项",
	["Reset Positions"] = "重置位置",
	["Window Scaling"] = "窗口缩放",
	["Data Deletion"] = "数据删除",
	["Instance Based Deletion"] = "副本相关的删除",
	["Group Based Deletion"] = "组队相关的删除",
	["Global Realtime Windows"] = "全局实时窗口",
	["Network"] = "网络",
	["Latency"] = "延迟",
	["Up Traffic"] = "上传流量",
	["Down Traffic"] = "下载流量",
	["Bandwidth"] = "带宽",
	["Recount Version"] = "Recount版本",
	["Check Versions"] = "检查版本",
	["Data Options"] = "数据选项",
	["Combat Log Range"] = "战斗日志范围",
	["Yds"] = "码",
	["Fix Ambiguous Log Strings"] = "修正模糊日志",
	["Merge Pets w/ Owners"] = "将宠物和主人合并",
	["Main Window Options"] = "主窗口选项",
	["Show Buttons"] = "显示按钮",
	["File"] = "文件",
	["Previous"] = "上一个",
	["Next"] = "下一个",
	["Row Height"] = "行高",
	["Row Spacing"] = "行间距",
	["Autohide On Combat"] = "战斗中隐藏",
	["Show Scrollbar"] = "显示滚动条",
	["Data"] = "数据",
	["Appearance"] = "外观",
	["Color"] = "颜色",
	["Window"] = "窗口",
	["Window Color Selection"] = "窗口颜色选择",
	["Main Window"] = "主窗口",
	["Other Windows"] = "其他窗口",
	["Global Data Collection"] = "全局数据收集",
	["Autoswitch Shown Fight"] = "自动切换为当前战斗",
	["Lock Windows"] = "锁定窗口",
	["Autodelete Time Data"] = "自动删除分时数据",
	["Delete on Entry"] = "进入时删除",
	["New"] = "新建",
	["Confirmation"] = "确认",
	["Delete on New Group"] = "新队伍时删除",
	["Delete on New Raid"] = "新团队时删除",
	["Sync Data"] = "同步数据",
	["Set Combat Log Range"] = "设置战斗日志范围",
	["Detail Window"] = "细节窗口",
	["Death Details for"] = "详细死亡数据：",
	["Health"] = "生命",
	["Recount"] = "Recount",
	["Outgoing"] = "输出",
	["Incoming"] = "承受",
	["Damage Report for"] = "伤害报告：",
	["Damage"] = "伤害",
	["Resisted"] = "被抵抗",
	["Report for"] = "报告：",
	["Glancing"] = "偏斜",
	["Hit"] = "命中",
	["Crushing"] = "碾压",
	["Crit"] = "爆击",
	["Miss"] = "未击中",
	["Dodge"] = "闪避",
	["Parry"] = "招架",
	["Block"] = "格挡",
	["Resist"] = "抵抗",
	["X Gridlines Represent"] = "X轴每格代表",
	["Seconds"] = "秒",
	["Graph Window"] = "图形窗口",
	["Data Name"] = "数据名",
	["Enabled"] = "启用",
	["Fought"] = "对手",
	["Start"] = "开始",
	["End"] = "结束",
	["Normalize"] = "标准化",
	["Integrate"] = "整合",
	["Stack"] = "叠加",
	["Report Data"] = "数据报告",
	["Report To"] = "报告给",
	["Report Top"] = "报告人数",
	["Reset Recount?"] = "重置Recount?",
	["Do you wish to reset the data?"] = "你希望重置数据么？",
	["Yes"] = "是",
	["No"] = "否",
	["Show Details (Left Click)"] = "显示细节(左键点击)",
	["Show Graph (Shift Click)"] = "显示图表(Shift点击)",
	["Add to Current Graph (Alt Click)"] = "添加到当前图表(Alt点击)",
	["Show Realtime Graph (Ctrl Click)"] = "显示实时图表(Ctrl点击)",
	["Delete Combatant (Ctrl-Alt Click)"] = "删除战斗人员(Ctrl-Alt点击)",
	["Overall Data"] = "所有数据",
	["Current Fight"] = "当前战斗",
	["Fight"] = "战斗",
	["Top Color"] = "顶端颜色",
	["Bottom Color"] = "底端颜色",
	["Ability Name"] = "技能名称",
	["Type"] = "类型",
	["Min"] = "最小",
	["Avg"] = "平均",
	["Max"] = "最大",
	["Count"] = "次数",
	["Player/Mob Name"] = "玩家/怪物名",
	["Attack Name"] = "攻击名称",
	["Time (s)"] = "时间",
	["Heal Name"] = "治疗名称",
	["Heal"] = "治疗",
	["Healed"] = "已治疗",
	["Overheal"] = "过量治疗",
	["Ability"] = "技能",
	["DOT Time"] = "DOT时间",
	["Ticked on"] = "每跳于",
	["Duration"] = "持续时间",
	["HOT Time"] = "HOT时间",
	["Interrupted Who"] = "打断了谁",
	["Interrupted"] = "被打断",
	["Ressed Who"] = "复活了谁",
	["Times"] = "次数",
	["Who"] = "谁",
	["Broke"] = "打醒",
	["Broke On"] = "打醒",
	["Gained"] = "获得",
	["From"] = "来自",
	["Prefix"] = "前缀",
	["Messages"] = "信息",
	["Distribution"] = "分布",
	["Bytes"] = "字节",
	["'s Hostile Attacks"] = "的敌对攻击",
	["Damaged Who"] = "伤害了谁",
	["'s Partial Resists"] = "的部分抵抗",
	["'s Time Spent Attacking"] = "攻击花费的时间",
	["'s Friendly Fire"] = "的队友误伤",
	["Friendly Fired On"] = "误伤于",
	["Took Damage From"] = "承受伤害自",
	["'s Effective Healing"] = "的有效治疗",
	["Healed Who"] = "治疗了谁",
	["'s Overhealing"] = "的过量治疗",
	["'s Time Spent Healing"] = "治疗花费的时间",
	["was Healed by"] = "被治疗自",
	["'s DOT Uptime"] = "的DOT持续时间",
	["'s HOT Uptime"] = "的HOT持续时间",
	["'s Interrupts"] = "的打断次数",
	["'s Resses"] = "的复活次数",
	["'s Dispels"] = "的驱散次数",
	["was Dispelled by"] = "被驱散自",
	["'s Time Spent"] = "的时间花费",
	["CC Breaking"] = "打醒控制",
	["'s Mana Gained"] = "的法力获取",
	["'s Mana Gained From"] = "的法力获取自",
	["'s Energy Gained"] = "的能量获取",
	["'s Energy Gained From"] = "的能量获取自",
	["'s Rage Gained"] = "的怒气获取",
	["'s Rage Gained From"] = "的怒气获取自",
	["'s Network Traffic"] = "的网络流量",
	["Top 3"] = "排行前三的",
	["Damage Abilties"] = "伤害技能",
	["Attacked"] = "攻击目标",
	["Pet Damage Abilties"] = "宠物伤害技能",
	["Pet Attacked"] = "宠物攻击目标",
	["Click for more Details"] = "点击显示更多细节",
	["Friendly Attacks"] = "误伤次数",
	["Attacked by"] = "攻击来自",
	["Heals"] = "治疗",
	["Healed By"] = "治疗来自",
	["Over Heals"] = "过量治疗",
	["DOTs"] = "持续伤害",
	["HOTs"] = "持续治疗",
	["Dispelled By"] = "驱散来自",
	["Attacked/Healed"] = "攻击/治疗",
	["Time Damaging"] = "伤害时间",
	["Time Healing"] = "治疗时间",
	["Mana Abilities"] = "法力技能",
	["Mana Sources"] = "法力来源",
	["Energy Abilities"] = "能量技能",
	["Energy Sources"] = "能量来源",
	["Rage Abilities"] = "怒气技能",
	["Rage Sources"] = "怒气来源",
	["CC's Broken"] = "打醒控制",
	["Ressed"] = "已复活",
	["Network Traffic"] = "网络流量",
	["'s DPS"] = "的每秒伤害",
	["'s DTPS"] = "的每秒承受伤害",
	["'s HPS"] = "的每秒治疗",
	["'s HTPS"] = "的每秒接受治疗",
	["'s TPS"] = "的每秒仇恨",
	["Threat on"] = "仇恨于",
	["Name of Ability"] = "技能的名称",
	["Time"] = "时间",
	["Killed By"] = "被谁杀",
	["Combat Messages"] = "战斗信息",
	["Misc"] = "其它",
	["Show Graph"] = "显示图表",
	["Config Recount"] = "配置Recount",
	["Death Graph"] = "死亡图表",
	["Melee"] = "肉搏",
	["Physical"] = "物理",
	["Arcane"] = "奥术",
	["Fire"] = "火焰",
	["Frost"] = "冰霜",
	["Holy"] = "神圣",
	["Nature"] = "自然",
	["Shadow"] = "暗影",
	["Total"] = "总和",
	["Taken"] = "承受",
	["Damage Focus"] = "伤害比重",
	["Avg. DOTs Up"] = "平均DOT持续",
	["Pet Damage"] = "宠物伤害",
	["No Pet"] = "无宠物",
	["Pet Time"] = "宠物时间",
	["Pet Focus"] = "宠物伤害比重",
	["Healing"] = "治疗",
	["Overhealing"] = "过量治疗",
	["Heal Focus"] = "治疗比重",
	["Avg. HOTs Up"] = "平均治疗持续",
	["Attack Summary Outgoing (Click for Incoming)"] = "伤害输出统计（点击切换为承受）",
	["Attack Summary Incoming (Click for Outgoing)"] = "伤害承受统计（点击切换为输出）",
	["Summary Report for"] = "综合报表：",
	["Say"] = "说",
	["Party"] = "队伍",
	["Raid"] = "团队",
	["Guild"] = "公会",
	["Officer"] = "官员",
	["Whisper"] = "密语",
	["Whisper Target"] = "密语目标"
}end)
