-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english

!! Make sure to keep this saved as UTF-8 format !!

]]

--[[>> still needs translating]]

-- FR
if GetLocale() == "frFR" then

-- DE 
elseif GetLocale() == "deDE" then

-- SPANISH
elseif GetLocale() == "esES" then

-- ENGLISH
else	-- standard english version

end

-- simple chinese
if GetLocale() == "zhCN" then

FW.L.SPELL_TIMER = "法术计时条";
FW.L.DISPLAY_MODES = "显示模式";
FW.L.FADING = "渐隐";
FW.L.EXTRA = "扩展";
FW.L.SHOW_HEADER = "显示标题栏";

FW.L.ST_HINT1 = "设置好计时条后可以锁定并隐藏标题栏.";
FW.L.ST_HINT2 = "右键点击计时条图标将会取消对其计时.";

FW.L.ST_BASIC1_TT = "计时条可视.";		
FW.L.ST_BASIC2_TT = "锁定计时条,锁定后计时条忽略点击,因此无法移动或者打开设置窗口.";
FW.L.ST_BASIC3_TT = "显示标题栏对设置计时条很有帮助,但最好还是隐藏了它,它隐藏后依然能够通过拖拽它移动计时条.";

FW.L.NORMAL_TEXT = "一般文字";
FW.L.NORMAL_TEXT_TT = "任何非目标/焦点的目标的计时文字颜色.";
FW.L.TARGET_TEXT = "目标文字";
FW.L.TARGET_TEXT_TT = "你目标的计时文字颜色.";
FW.L.FOCUS_TEXT = "焦点文字";
FW.L.FOCUS_TEXT_TT = "你焦点的计时文字颜色.";
FW.L.COUNTDOWN_TEXT = "冷却文字";
FW.L.COUNTDOWN_TEXT_TT = "";

FW.L.LABEL_FONT = "标签字体";
FW.L.LABEL_FONT_TT = "对象标签的字体. (当开启按对象分类时)";
FW.L.UNIT_SPACING = "对象间距";
FW.L.UNIT_SPACING_TT = "不同对象计时条之间的间距. 只有当设定按对象分类计时条才有效.";
FW.L.UNIT_LABEL_HEIGHT = "对象标签高度";
FW.L.UNIT_LABEL_HEIGHT_TT = "对象标签的高度. (当开启按对象分类时)";
FW.L.COUNTDOWN_WIDTH = "计时文字宽度";
FW.L.COUNTDOWN_WIDTH_TT = "你可以增加计时文字的宽度, 因为有时候计时文字可能显示不完全.";
FW.L.MAXIMIZE_SPACE = "最大名字空间(丑)";
FW.L.MAXIMIZE_SPACE_TT = "对象/法术的空间最大化. 结果是这些文字将不会在计时条中间显示. 当你把计时条设置非常短时有所帮助.";
FW.L.COUNTDOWN_ON_RIGHT = "右侧显示计时";
FW.L.COUNTDOWN_ON_RIGHT_TT = "在计时条左侧或右侧显示计时.";


FW.L.DISPLAY_MODES1 = "显示增强buffs";
FW.L.DISPLAY_MODES1_TT = "计时条显示增益buff.";
FW.L.DISPLAY_MODES2 = "显示暗影易伤";
FW.L.DISPLAY_MODES2_TT = "将目标的暗影易伤作为增强buff显示.";
FW.L.DISPLAY_MODES3 = "只对boss显示长法术";
FW.L.DISPLAY_MODES3_TT = "将 CoS/CoE 之类的长法术隐藏,持续时间大于等于120秒的都称为长法术. 重新选择目标后将会重新显示计时条. (开启长时间显示模式)";
FW.L.DISPLAY_MODES4 = "长时间显示";
FW.L.DISPLAY_MODES4_TT = "长时间法术显示时间.";
FW.L.DISPLAY_MODES5 = "显示失败法术";
FW.L.DISPLAY_MODES5_TT = "失败法术仍在计时条显示 (例如抵抗,免疫之类). 很有用.";
FW.L.DISPLAY_MODES6 = "失败法术显示时间";
FW.L.DISPLAY_MODES6_TT = "失败法术在计时条上显示时间.";
FW.L.DISPLAY_MODES7 = "按对象号分类";
FW.L.DISPLAY_MODES7_TT = "将一个对象的计时条排在一起显示.";
FW.L.DISPLAY_MODES8 = "显示对象号";
FW.L.DISPLAY_MODES8_TT = "在每个对象名字前显示其编号. 有助于分辨出同名对象.";
FW.L.DISPLAY_MODES9 = "计时条显示法术名";
FW.L.DISPLAY_MODES9_TT = "计时条将显示法术名而不是目标名. 当按照对象分类选项开启时,对象名将在每个分类条上显示.";
FW.L.DISPLAY_MODES10 = "只显示目标/焦点";
FW.L.DISPLAY_MODES10_TT = "所有的法术在背后仍然被追踪,但是只显示你目标和焦点的法术.";

FW.L.FADING1 = "法术结束前闪烁";
FW.L.FADING1_TT = "启动此选项,计时条结束3秒前闪烁.先慢后快. 颜色不变";
FW.L.FADING2 = "计时条渐隐";
FW.L.FADING2_TT = "开启后计时条平滑消失.";
FW.L.FADING3 = "渐隐消失时间";
FW.L.FADING3_TT = "计时结束,计时条渐隐持续时间";
FW.L.FADING4 = "渐隐时间";
FW.L.FADING4_TT = "计时条渐隐需用时间.";
FW.L.FADING5 = "高亮新释放法术";
FW.L.FADING5_TT = "新释放法术将高亮显示,目的是为了分辨新释放法术.";
FW.L.FADING6 = "没有目标时的透明度";
FW.L.FADING6_TT = "当计时条显示的不是你的目标或者焦点时,可以设置不同的透明度. 很容易分辨出自己的目标.";

FW.L.EXTRA1 = "显示团队图标";
FW.L.EXTRA1_TT = "在对象计时条背景上显示团队图标.";
FW.L.EXTRA2 = "团队图标透明度";
FW.L.EXTRA2_TT = "团队图标透明度.";
FW.L.EXTRA3 = "DOT判读";
FW.L.EXTRA3_TT = "启动此功能,计时条将查看你的战斗记录DOT伤害,来判读移除失效计时条.";
FW.L.EXTRA4 = "队友判读";
FW.L.EXTRA4_TT = "启动此功能,计时条将查看你队友的目标,来帮助判读移除失效计时条.";


FW.L.HIGHLIGHT = "高亮";
FW.L.FAIL = "失败";
FW.L.MAGIC_DOT = "DOT";
FW.L.CURSE = "诅咒";
FW.L.CC = "控制";
FW.L.POWERUP_BUFFS = "增强buffs";

FW.L.ST_CUSTOMIZE_TT = "自定义计时法术/buffs."
FW.L.FAILED_MESSAGE_COLOR = "失败法术信息";
FW.L.SHOW_FAILED = "显示失败法术";
FW.L.SHOW_FAILED_TT = "显示由于抵抗,免疫等释放失败的法术.";

FW.L.SHORT_HIDE = "隐藏";
FW.L.SHORT_FADE = "消失";
FW.L.SHORT_REMOVED = "移除";
FW.L.SHORT_RESISTED = "抵抗";
FW.L.SHORT_IMMUNE = "免疫";
FW.L.SHORT_EVADED = "闪避";
FW.L.SHORT_REFLECTED = "反射";

FW.L.UPDATE_INTERVAL_SPELL_TIMER = "计时条更新间隔";
FW.L.DELAY_TARGET_DEBUFF_CHECK = "目标debuff检查延迟";
FW.L.DELAY_DOT_TICKS_INIT = "DOT初始化延迟";
FW.L.DELAY_DOT_TICKS = "DoT延迟";


-- tradition chinese
elseif GetLocale() == "zhTW" then

FW.L.SPELL_TIMER = "法術計時條";
FW.L.DISPLAY_MODES = "顯示模式";
FW.L.FADING = "漸隱";
FW.L.EXTRA = "擴展";
FW.L.SHOW_HEADER = "顯示標題欄";

FW.L.ST_HINT1 = "設置好計時條後可以鎖定並隱藏標題欄.";
FW.L.ST_HINT2 = "右鍵點擊計時條圖示將會取消對其計時.";

FW.L.ST_BASIC1_TT = "計時條可視.";		
FW.L.ST_BASIC2_TT = "鎖定計時條,鎖定後計時條忽略點擊,因此無法移動或者打開設置視窗.";
FW.L.ST_BASIC3_TT = "顯示標題欄對設置計時條很有幫助,但最好還是隱藏了它,它隱藏後依然能夠通過拖拽它移動計時條.";

FW.L.NORMAL_TEXT = "一般文字";
FW.L.NORMAL_TEXT_TT = "任何非目標/焦點的目標的計時文字顏色.";
FW.L.TARGET_TEXT = "目標文字";
FW.L.TARGET_TEXT_TT = "你目標的計時文字顏色.";
FW.L.FOCUS_TEXT = "焦點文字";
FW.L.FOCUS_TEXT_TT = "你焦點的計時文字顏色.";
FW.L.COUNTDOWN_TEXT = "冷卻文字";
FW.L.COUNTDOWN_TEXT_TT = "";

FW.L.LABEL_FONT = "標籤字體";
FW.L.LABEL_FONT_TT = "物件標籤的字體. (當開啟按對象分類時)";
FW.L.UNIT_SPACING = "對象間距";
FW.L.UNIT_SPACING_TT = "不同物件計時條之間的間距. 只有當設定按物件分類計時條才有效.";
FW.L.UNIT_LABEL_HEIGHT = "對象標籤高度";
FW.L.UNIT_LABEL_HEIGHT_TT = "對象標籤的高度. (當開啟按對象分類時)";
FW.L.COUNTDOWN_WIDTH = "計時文字寬度";
FW.L.COUNTDOWN_WIDTH_TT = "你可以增加計時文字的寬度, 因為有時候計時文字可能顯示不完全.";
FW.L.MAXIMIZE_SPACE = "最大名字空間(醜)";
FW.L.MAXIMIZE_SPACE_TT = "物件/法術的空間最大化. 結果是這些文字將不會在計時條中間顯示. 當你把計時條設置非常短時有所幫助.";
FW.L.COUNTDOWN_ON_RIGHT = "右側顯示計時";
FW.L.COUNTDOWN_ON_RIGHT_TT = "在計時條左側或右側顯示計時.";


FW.L.DISPLAY_MODES1 = "顯示增強buffs";
FW.L.DISPLAY_MODES1_TT = "計時條顯示增益buff.";
FW.L.DISPLAY_MODES2 = "顯示暗影易傷";
FW.L.DISPLAY_MODES2_TT = "將目標的暗影易傷作為增強buff顯示.";
FW.L.DISPLAY_MODES3 = "只對boss顯示長法術";
FW.L.DISPLAY_MODES3_TT = "將 CoS/CoE 之類的長法術隱藏,持續時間大於等於120秒的都稱為長法術. 重新選擇目標後將會重新顯示計時條. (開啟長時間顯示模式)";
FW.L.DISPLAY_MODES4 = "長時間顯示";
FW.L.DISPLAY_MODES4_TT = "長時間法術顯示時間.";
FW.L.DISPLAY_MODES5 = "顯示失敗法術";
FW.L.DISPLAY_MODES5_TT = "失敗法術仍在計時條顯示 (例如抵抗,免疫之類). 很有用.";
FW.L.DISPLAY_MODES6 = "失敗法術顯示時間";
FW.L.DISPLAY_MODES6_TT = "失敗法術在計時條上顯示時間.";
FW.L.DISPLAY_MODES7 = "按對象號分類";
FW.L.DISPLAY_MODES7_TT = "將一個物件的計時條排在一起顯示.";
FW.L.DISPLAY_MODES8 = "顯示物件號";
FW.L.DISPLAY_MODES8_TT = "在每個物件名字前顯示其編號. 有助於分辨出同名物件.";
FW.L.DISPLAY_MODES9 = "計時條顯示法術名";
FW.L.DISPLAY_MODES9_TT = "計時條將顯示法術名而不是目標名. 當按照物件分類選項開啟時,物件名將在每個分類條上顯示.";
FW.L.DISPLAY_MODES10 = "只顯示目標/焦點";
FW.L.DISPLAY_MODES10_TT = "所有的法術在背後仍然被追蹤,但是只顯示你目標和焦點的法術.";

FW.L.FADING1 = "法術結束前閃爍";
FW.L.FADING1_TT = "啟動此選項,計時條結束3秒前閃爍.先慢後快. 顏色不變";
FW.L.FADING2 = "計時條漸隱";
FW.L.FADING2_TT = "開啟後計時條平滑消失.";
FW.L.FADING3 = "漸隱消失時間";
FW.L.FADING3_TT = "計時結束,計時條漸隱持續時間";
FW.L.FADING4 = "漸隱時間";
FW.L.FADING4_TT = "計時條漸隱需用時間.";
FW.L.FADING5 = "高亮新釋放法術";
FW.L.FADING5_TT = "新釋放法術將高亮顯示,目的是為了分辨新釋放法術.";
FW.L.FADING6 = "沒有目標時的透明度";
FW.L.FADING6_TT = "當計時條顯示的不是你的目標或者焦點時,可以設置不同的透明度. 很容易分辨出自己的目標.";

FW.L.EXTRA1 = "顯示團隊圖示";
FW.L.EXTRA1_TT = "在物件計時條背景上顯示團隊圖示.";
FW.L.EXTRA2 = "團隊圖示透明度";
FW.L.EXTRA2_TT = "團隊圖示透明度.";
FW.L.EXTRA3 = "DOT判讀";
FW.L.EXTRA3_TT = "啟動此功能,計時條將查看你的戰鬥記錄DOT傷害,來判讀移除失效計時條.";
FW.L.EXTRA4 = "隊友判讀";
FW.L.EXTRA4_TT = "啟動此功能,計時條將查看你隊友的目標,來幫助判讀移除失效計時條.";


FW.L.HIGHLIGHT = "高亮";
FW.L.FAIL = "失敗";
FW.L.MAGIC_DOT = "DOT";
FW.L.CURSE = "詛咒";
FW.L.CC = "控制";
FW.L.POWERUP_BUFFS = "增強buffs";

FW.L.ST_CUSTOMIZE_TT = "自定義計時法術/buffs."
FW.L.FAILED_MESSAGE_COLOR = "失敗法術資訊";
FW.L.SHOW_FAILED = "顯示失敗法術";
FW.L.SHOW_FAILED_TT = "顯示由於抵抗,免疫等釋放失敗的法術.";

FW.L.SHORT_HIDE = "隱藏";
FW.L.SHORT_FADE = "消失";
FW.L.SHORT_REMOVED = "移除";
FW.L.SHORT_RESISTED = "抵抗";
FW.L.SHORT_IMMUNE = "免疫";
FW.L.SHORT_EVADED = "閃避";
FW.L.SHORT_REFLECTED = "反射";

FW.L.UPDATE_INTERVAL_SPELL_TIMER = "計時條更新間隔";
FW.L.DELAY_TARGET_DEBUFF_CHECK = "目標debuff檢查延遲";
FW.L.DELAY_DOT_TICKS_INIT = "DOT初始化延遲";
FW.L.DELAY_DOT_TICKS = "DoT延遲";

-- ENGLISH
else	-- standard english version

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SPELL_TIMER = "Spell Timer";
FW.L.DISPLAY_MODES = "Display Modes";
FW.L.FADING = "Fading";
FW.L.EXTRA = "Extra";
FW.L.SHOW_HEADER = "Show header";

FW.L.ST_HINT1 = "Once you have set up the timer, you can lock it and hide its header.";
FW.L.ST_HINT2 = "Right-clicking a debuff icon will remove this debuff from the timer.";

FW.L.ST_BASIC1_TT = "Visually enable the spell timer.";		
FW.L.ST_BASIC2_TT = "Lock the spell timer. When the timer is locked you will click through it, so you can no longer accidently move it or open the options from it.";
FW.L.ST_BASIC3_TT = "Showing the header can be usefull for setting up the timer, but there's no reason not to hide it. You can still drag the timer from the header spot if the header itself is hidden.";

FW.L.NORMAL_TEXT = "Normal text";
FW.L.NORMAL_TEXT_TT = "The color used for the texts belonging to any non-target/focus unit.";
FW.L.TARGET_TEXT = "Target text";
FW.L.TARGET_TEXT_TT = "The color used for the texts belonging to your target.";
FW.L.FOCUS_TEXT = "Focus text";
FW.L.FOCUS_TEXT_TT = "The color used for the texts belonging to your focus.";
FW.L.COUNTDOWN_TEXT = "Countdown text";
FW.L.COUNTDOWN_TEXT_TT = "";

FW.L.LABEL_FONT = "Label Font";
FW.L.LABEL_FONT_TT = "The font to use for the unit labels in between the bars. (if enabled)";
FW.L.UNIT_SPACING = "Unit spacing";
FW.L.UNIT_SPACING_TT = "The spacing between bar groups belonging to different units. Only applies when grouping by unit #.";
FW.L.UNIT_LABEL_HEIGHT = "Unit label height";
FW.L.UNIT_LABEL_HEIGHT_TT = "The height of the unit labels in between the bars. (if enabled)";
FW.L.COUNTDOWN_WIDTH = "Countdown text width";
FW.L.COUNTDOWN_WIDTH_TT = "You can increase the width your countdown text takes up, in case the text doesnt always fit for some reason.";
FW.L.MAXIMIZE_SPACE = "Maximize name space (ugly)";
FW.L.MAXIMIZE_SPACE_TT = "Maximizes the space used for the unit/spell texts. As a result, these texts will no longer be displayed in the exact center of the bars. This can be usefull if you have very short bars.";
FW.L.COUNTDOWN_ON_RIGHT = "Count down on right";
FW.L.COUNTDOWN_ON_RIGHT_TT = "You can display the countdown text on the right or on the left of the timer bars.";

FW.L.DISPLAY_MODES1 = "Show powerup buffs";
FW.L.DISPLAY_MODES1_TT = "The timer will also display beneficial powerup buffs.";
FW.L.DISPLAY_MODES2 = "Shadow Vulnerability";
FW.L.DISPLAY_MODES2_TT = "Show the Improved Shadowbolt debuff on your target as a powerup.";
FW.L.DISPLAY_MODES3 = "Long spells only on bosses";
FW.L.DISPLAY_MODES3_TT = "Hides long spells like CoS/CoE on trash mobs. Spells with a duration equal to or longer than 120 seconds will be considered 'long'. Reselecting a unit will again show its hidden timers. (for the 'long display time')";
FW.L.DISPLAY_MODES4 = "Long spells display time";
FW.L.DISPLAY_MODES4_TT = "The time a 'long' spell is diplayed before fading away.";
FW.L.DISPLAY_MODES5 = "Show failed spells";
FW.L.DISPLAY_MODES5_TT = "Also show failed spells on the timer (due to resist, immune etc). Very usefull visual aid.";
FW.L.DISPLAY_MODES6 = "Failed display time";
FW.L.DISPLAY_MODES6_TT = "The time a spell that failed is diplayed before fading away.";
FW.L.DISPLAY_MODES7 = "Group by unit #";
FW.L.DISPLAY_MODES7_TT = "Groups timers belonging to the same units together.";
FW.L.DISPLAY_MODES8 = "Show unit #";
FW.L.DISPLAY_MODES8_TT = "Shows the 'id' number of each unit in front of its name. This way you can distinguish between units with the same name.";
FW.L.DISPLAY_MODES9 = "Spells with unit label";
FW.L.DISPLAY_MODES9_TT = "This will display the names of your spells on the timer bars, instead of the target name. With the 'group my unit #' option on, unit name tags will appear for each bar group.";
FW.L.DISPLAY_MODES10 = "Only show target/focus";
FW.L.DISPLAY_MODES10_TT = "All spells will still be tracked in the background, but you will only see those on your target or focus.";

FW.L.FADING1 = "Blink expiring bars";
FW.L.FADING1_TT = "When enabled, bars expiring in 3 seconds will start to blink. First slow, fast in the end. A nice indication of expiring bars, without changing the actual color.";
FW.L.FADING2 = "Fade out bars";
FW.L.FADING2_TT = "When enabled, your timer bars will smoothly fade out.";
FW.L.FADING3 = "Standard fade delay";
FW.L.FADING3_TT = "The delay before a timer bar that already expired, starts fading out. Also known as 'ghost time'.";
FW.L.FADING4 = "Fade time";
FW.L.FADING4_TT = "The time it takes for the bars to fade out.";
FW.L.FADING5 = "Highlight new casts";
FW.L.FADING5_TT = "Newly cast spells will start out bright and change to their normal color in half a second. An extra aid to see where your newly cast spell appeared on the timer.";
FW.L.FADING6 = "Non-target alpha";
FW.L.FADING6_TT = "Timers that do not belong to your target or focus, can be displayed with a different transparency. This makes it very easy to see what unit you have currently selected.";

FW.L.EXTRA1 = "Show Raid Target Icons";
FW.L.EXTRA1_TT = "Show the raid target icon of each unit in the bar background.";
FW.L.EXTRA2 = "Raid Target Icons Alpha";
FW.L.EXTRA2_TT = "The alpha (transparency) of the raid target icons.";
FW.L.EXTRA3 = "Improve: Use dot ticks";
FW.L.EXTRA3_TT = "When enabled, the timer will watch your combat log for dot damage to help remove bars that no longer apply.";
FW.L.EXTRA4 = "Improve: Use party/raid targets";
FW.L.EXTRA4_TT = "When enabled, the timer will watch party/raid member targets to help remove bars that no longer apply.";

FW.L.HIGHLIGHT = "Highlight";
FW.L.FAIL = "Fail";
FW.L.MAGIC_DOT = "Magic dot";
FW.L.CURSE = "Curse";
FW.L.CC = "Crowd control";
FW.L.POWERUP_BUFFS = "Powerup buffs";

FW.L.ST_CUSTOMIZE_TT = "Customize each of your spells or buffs."
FW.L.FAILED_MESSAGE_COLOR = "Failed spell messages";
FW.L.SHOW_FAILED = "Show failed spells";
FW.L.SHOW_FAILED_TT = "Show spells that failed due to resist, immune etc.";

FW.L.SHORT_HIDE = "hide";
FW.L.SHORT_FADE = "fade";
FW.L.SHORT_REMOVED = "remo";
FW.L.SHORT_RESISTED = "resi";
FW.L.SHORT_IMMUNE = "immu";
FW.L.SHORT_EVADED = "evad";
FW.L.SHORT_REFLECTED = "refl";

FW.L.UPDATE_INTERVAL_SPELL_TIMER = "Update interval spell timer";
FW.L.DELAY_TARGET_DEBUFF_CHECK = "Delay target debuff check";
FW.L.DELAY_DOT_TICKS_INIT = "Delay dot ticks init";
FW.L.DELAY_DOT_TICKS = "Delay dot ticks";

end