#include-once
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>
#include <File.au3>
#include <WinAPI.au3>

Local $ConversionTable[908][2] = [ _
[" Whisper", " Whisper"], _ ;未译
[" duration: %d", " duration: %d"], _ ;未译
[" to specify an hexadecimal number", " 指定一16位进制的数字"], _ 
["! All", "! 地区频道"], _ 
["# Group", "# 队伍频道"], _ 
["$ Trade", "$ 交易频道"], _ 
["% Alliance", "% 同盟频道"], _ 
["%.0f milliseconds", "%.0f 毫秒"], _ 
["%d %s ago", "%d %s 前"], _ 
["%d Soul Tormentors", "%d 魂拷问者"], _ 
["%d foes in casting range", "施法范围内有 %d 名敌人"], _ 
["%d foes in compass range", "雷达范围内有 %d 名敌人"], _ 
["%d foes in spirit range", "灵距内有 %d 名敌人"], _ 
["%s - %s###header%d", "%s - %s###header%d"], _ ;未译
["%s [%s]###header%u", "%s [%s]###header%u"], _ ;未译
["%s not found!", "%s 失寻!"], _ 
["%s###build%d", "%s###build%d"], _ ;未译
["%s###herobuild%d", "%s###herobuild%d"], _ ;未译
["%s_active", "%s_active"], _ ;未译
["%s_threshold", "%s_threshold"], _ ;未译
["%s_visible", "%s_visible"], _ ;未译
["(Each line is a separate keyword. Not case sensitive.)", "(Each line is a separate keyword. Not case sensitive.)"], _ ;未译
["(Up to date)", "(Up to date)"], _ ;未译
["- CTRL+A or double-click to select all\n", "- CTRL+A or double-click to select all\n"], _ ;未译
["- CTRL+Left/Right to word jump\n", "- CTRL+Left/Right to word jump\n"], _ ;未译
["- CTRL+X,CTRL+C,CTRL+V clipboard\n", "- CTRL+X,CTRL+C,CTRL+V clipboard\n"], _ ;未译
["- CTRL+Z,CTRL+Y undo/redo\n", "- CTRL+Z,CTRL+Y undo/redo\n"], _ ;未译
["- ESCAPE to revert\n", "- ESCAPE to revert\n"], _ ;未译
["- Hold SHIFT or use mouse to select text\n", "- Hold SHIFT or use mouse to select text\n"], _ ;未译
["- You can apply arithmetic operators +,*,/ on numerical values. Use +- to subtract.\n", "- You can apply arithmetic operators +,*,/ on numerical values. Use +- to subtract.\n"], _ ;未译
["/ Commands", "/ Commands"], _ ;未译
["10 Bolts of Cloth", "10 布料"], _
["10 Bones", "10 骨头"], _
["10 Chitin Fragments", "10 外壳"], _
["10 Feathers", "10 羽毛"], _
["10 Granite Slabs", "10 花岗岩石板"], _
["10 Iron Ingots", "10 铁矿石"], _
["10 Piles of Glittering Dust", "10 闪烁之土"], _
["10 Plant Fibers", "10 植物纤维"], _
["10 Scales", "10 鳞片"], _
["10 Tanned Hide Squares", "10 褐色兽皮"], _
["10 Wood Planks", "10 木材"], _
["4...Itchy...Tasty...", "4...Itchy...Tasty..."], _ ;未译
["<None>", "<None>"], _ ;未译
["<a=1>%s</a>: <c=#f96677><quote>%s", "<a=1>%s</a>: <c=#f96677><quote>%s"], _ ;未译
["<not found>", "<not found>"], _ ;未译
["@ Guild", "@ 公会频道"], _ 
["A simple in-game text editor", "一简易的嵌入式便笺"], _ 
["AS modifier", "AS modifier"], _ ;未译
["AS of Weapon", "AS of Weapon"], _ ;未译
["Abaddon will feast on your eyes!", "Abaddon will feast on your eyes!"], _ ;未译
["Abaddon's Gate", "亚霸顿之门"], _
["Abaddon's Mouth", "地狱隘口"], _
["Abaddon's sword has been drawn. He sends me back to you with tokens of renewed power!", "Abaddon's sword has been drawn. He sends me back to you with tokens of renewed power!"], _ ;未译
["Accept quest reward", "接受任务奖励"], _ 
["Acolyte Jin", "侍从静"], _
["Acolyte Sousuke", "侍从萨苏克"], _
["Action", "Action"], _ ;未译
["Action###combo", "Action###combo"], _ ;未译
["ActionID", "ActionID"], _ ;未译
["Add Build", "Add Build"], _ ;未译
["Add Teambuild", "Add Teambuild"], _ ;未译
["Add another player build row", "Add another player build row"], _ ;未译
["Addr", "内存地址"], _ 
["Advanced##target", "Advanced##target"], _ ;未译
["After using a pcon, toolbox will not use it again for this amount of time.\n", "After using a pcon, toolbox will not use it again for this amount of time.\n"], _ ;未译
["Agent ID is unique for each agent in the instance,\nIt's generated on spawn and will change in different instances.", "Agent ID is unique for each agent in the instance,\nIt's generated on spawn and will change in different instances."], _ ;未译
["Agent ID##player", "Agent ID##player"], _ ;未译
["Agent ID##target", "Agent ID##target"], _ ;未译
["Alcohol", "Alcohol"], _ ;未译
["Alerts", "Alerts"], _ ;未译
["All is well. I'm not insane.", "All is well. I'm not insane."], _ ;未译
["Allegiance", "Allegiance"], _ ;未译
["Altrumm Ruins", "奥楚兰废墟"], _
["Amatz Basin", "亚马兹盆地"], _
["Amber Chunk", "琥珀"], _
["American District 1", "北美一区"], _ 
["American", "北美洲"], _ 
["Amnoon Oasis, The", "安奴绿洲"], _
["An alternative to the default compass", "An alternative to the default compass"], _ ;未译
["And this is where I met the Lich. He told me to burn things.", "And this is where I met the Lich. He told me to burn things."], _ ;未译
["Anton", "安托"], _
["Arborstone", "亭石"], _
["Are you sure?\nThis operation cannot be undone.\n\n", "Are you sure?\nThis operation cannot be undone.\n\n"], _ ;未译
["Are you sure?\nThis operation cannot be undone\n\n", "Are you sure?\nThis operation cannot be undone\n\n"], _ ;未译
["Are you the Keymaster?", "Are you the Keymaster?"], _ ;未译
["Armor of Salvation", "救赎防具"], _ 
["Armor of Salvation\nIron and Bones", "救赎防具\n铁矿石 及 骨头"], _
["As a boy I spent much time in these lands.", "As a boy I spent much time in these lands."], _ ;未译
["Ascalon City", "阿斯卡隆城"], _
["Ashford Abbey", "灰色浅滩修道院"], _
["Asia Chinese", "亚洲 中文"], _ 
["Asia Japanese", "亚洲 日文"], _ 
["Asian Korean", "亚洲 朝文"], _ 
["Aspenwood Gate (Kurzick)", "杨木大门 (库兹柯)"], _
["Aspenwood Gate (Luxon)", "杨木大门 (勒克森)"], _
["Astralarium, The", "亚斯特拉利姆"], _
["Augury Rock", "占卜之石"], _
["Aurios Mines, The", "奥里欧斯矿坑"], _
["Aurora Glade", "欧若拉林地"], _
["Automatically manage gold", "Automatically manage gold"], _ ;未译
["BE GONE!", "BE GONE!"], _ ;未译
["Bad hero index '%d' for build '%s'", "Bad hero index '%d' for build '%s'"], _ ;未译
["Bai Paasu Reach", "拜巴苏区域"], _
["Basalt Grotto", "玄武岩石穴"], _
["Beacon's Perch", "毕肯高地"], _
["Beetletun", "甲虫镇"], _
["Beknur Harbor", "别克诺港"], _
["Bergen Hot Springs", "卑尔根温泉"], _
["Birthday Cupcake", "生日杯子蛋糕"], _ 
["Blacktide Den", "黑潮之穴"], _
["Bloodstone Fen", "血石沼泽"], _
["Blue Rock Candy", "蓝冰糖"], _ 
["Bolt of Damask", "缎布"], _
["Bolt of Linen", "亚麻布"], _
["Bolt of Silk", "丝绸"], _
["Bonds", "Bonds"], _ ;未译
["Bone Palace", "白骨宫殿"], _
["Boreal Station", "北极驻地"], _
["Boreas Seabed", "风神海床"], _
["Borlis Pass", "柏里斯通道"], _
["Bowl of Skalefin Soup", "鳞怪鳍汤"], _ 
["Brauer Academy", "巴尔学院"], _
["Breaker Hollow", "断崖谷"], _
["Build Name", "样本名"], _ 
["Build", "样本"], _ 
["BuildIndex", "样本索引号"], _ ;候选词： 样本索引
["Builds", "样本"], _ 
["Burning Forest", "孟席斯的奴隶们"], _ ;候选词： 燃烧森林，
["Buttons in the main window.", "Buttons in the main window."], _ ;未译
["Buy##armor", "买##armor"], _ ;候选词： 购买
["Buy##common", "买##common"], _ ;候选词： 购买
["Buy##essence", "买##essence"], _ ;候选词： 购买
["Buy##grail", "买##grail"], _ ;候选词： 购买
["Buy##pstone", "买##pstone"], _ ;候选词： 购买
["Buy##rare", "买##rare"], _ ;候选词： 购买
["Buy##resscroll", "买##resscroll"], _ ;候选词： 购买
["CTRL+Click or Double Click on a slider or drag box to input text.", "CTRL+Click or Double Click on a slider or drag box to input text."], _ ;未译
["CTRL+Mouse Wheel to zoom window contents.", "CTRL+Mouse Wheel to zoom window contents."], _ ;未译
["Camp Hojanu", "何加努营地"], _
["Camp Rankor", "蓝口营地"], _
["Cancel the current queue of operations", "Cancel the current queue of operations"], _ ;未译
["Cancel", "取消"], _ 
["Cancelled", "已取消"], _ 
["Candy Apple", "糖苹果"], _ 
["Candy Corn", "粟米糖"], _ 
["Cannot find %s", "%s 失寻"], _ 
["Cannot find %s, please refill or disable", "%s 失寻, please refill or disable"], _ ;未译
["Cavalon", "卡瓦隆"], _
["Central Transfer Chamber", "中央转送室"], _
["Chahbek Village", "夏贝克村庄"], _
["Chamber", "Chamber"], _ ;未译
["Champion's Dawn", "勇士曙光"], _
["Channel", "频道"], _ 
["Chantry of Secrets", "隐秘教堂"], _
["Chat Commands", "对话框指令"], _ 
["Chat command '/hide <name>' to hide a window or widget.", "对话框指令 '/hide <相关部件名>': 收起 窗口 或 配件."], _ ;候选词： 隐藏 (欠佳)
["Chat command '/show <name>' to show a window or widget.", "对话框指令 '/show <相关部件名>': 展开 窗口 或 配件."], _ ;候选词： 显示 (欠佳)
["Chat command '/tb <name>' to toggle a window or widget.", "对话框指令 '/tb <相关部件名>': 收展 窗口 或 配件."], _ ;候选词： 开关 (欠佳)
["Checkboxes in the Info window.", "Checkboxes in the Info window."], _ ;未译
["Checkboxes on the right of each setting header below.", "Checkboxes on the right of each setting header below."], _ ;未译
["Choose Hero", "选择英雄"], _ 
["City speedboost", "城内加速品"], _ 
["City", "City"], _ ;未译
["Clear", "Clear"], _ ;未译
["Click and drag on any empty space to move a window.", "Click and drag on any empty space to move a window."], _ ;未译
["Click and drag on the lower right corner to resize a window.", "Click and drag on the lower right corner to resize a window."], _ ;未译
["Click to change hotkey", "击此以重配快键"], _ 
["Click to load builds to heroes and player", "击此以替英雄及角色装填技能样本"], _ 
["Click to reconnect", "击此以重新连网"], _ 
["Click to send teambuild to chat", "击此以发送整团的技能样本"], _ 
["Clicker is %s", "Clicker is %s"], _ ;未译
["Clicker", "Clicker"], _ ;未译
["Clock", "Clock"], _ ;未译
["Close on travel", "Close on travel"], _ ;未译
["Close other windows when opening a new one", "Close other windows when opening a new one"], _ ;未译
["Close this window", "关闭此窗口"], _ 
["Close", "关闭"], _ 
["Codex Arena", "Codex 竞技场"], _
["Coin Drop", "Coin Drop"], _ ;未译
["Coin dropper is %s", "Coin dropper is %s"], _ ;未译
["Common 4", "Common 4"], _ ;未译
["Connected (not resigned)", "Connected (尚未发退出令)"], _ ;未译
["Connected", "Connected"], _ ;未译
["Connecting...", "正在连接..."], _ 
["Consulate Docks", "领事馆码头"], _
["Copperhammer Mines", "铜锤矿坑"], _
["Couldn't connect to the host '%s'", "Couldn't connect to the host '%s'"], _ ;未译
["Craft fow armor", "(灾难内)打造黑曜石盔甲"], _ ;候选词： 锻造
["Create Hotkey", "添加快键"], _ 
["Create Hotkey...", "添加快键..."], _ ;候选词： 指定快键
["Cross over, children. All are welcome. All welcome. Go into the light. There is peace and serenity in the light.", "Cross over, children. All are welcome. All welcome. Go into the light. There is peace and serenity in the light."], _ ;未译
["Current District", "现有区域"], _ ;候选词： 现有区
["Current drunk level: %d", "现醉酒程度: %d 级"], _ 
["Custom", "Custom"], _ ;未译
["D'Alessio Seaboard", "达雷西海滨"], _
["Dajkah Inlet", "达卡港"], _
["Damage", "Damage"], _ ;未译
["Dasha Vestibule", "达沙走廊"], _
["Decrease the value if you have good ping and you die a lot.", "Decrease the value if you have good ping and you die a lot."], _ ;未译
["Deep", "深处"], _ 
["Deep, The", "深处"], _
["Defend", "保护战争圣殿"], _  ;或需复原
["Deldrimor Steel Ingot", "戴尔狄摩钢铁矿石"], _
["Deldrimor War Camp", "戴尔狄摩兵营"], _
["Delete Hotkey?", "删除快键?"], _ 
["Delete Teambuild?", "删除整团的技能样本?"], _ 
["Delete build", "Delete build"], _ ;未译
["Delete the hotkey", "删除快键"], _ ;候选词： 取消快键
["Delete the teambuild", "Delete the teambuild"], _ ;未译
["Delete", "删除"], _ 
["Demon Assassin", "恶魔暗杀者"], _
["Destiny's Gorge", "命运峡谷"], _
["Dhuum", "多姆"], _ 
["Dialog #%d", "Dialog #%d"], _ ;未译
["Dialog %s", "Dialog %s"], _ ;未译
["Dialog ID", "Dialog ID"], _ ;未译
["Dialog Name", "Dialog Name"], _ ;未译
["Dialog", "Dialog"], _ ;未译
["DialogID", "DialogID"], _ ;未译
["DialogName", "DialogName"], _ ;未译
["Dialogs", "令码"], _ ;候选词： 暗码，关码，通令...
["Diamond", "金刚石"], _
["Disable when not found", "失寻时关闭"], _ 
["Disabled###pconstoggle", "已关闭###pconstoggle"], _ 
["Displays the distance to your target.\n1010 = Earshot / Aggro\n1248 = Cast range\n2500 = Spirit range\n5000 = Radar range", "Displays the distance to your target.\n1010 = Earshot / Aggro\n1248 = Cast range\n2500 = Spirit range\n5000 = Radar range"], _ ;未译
["Displays the health of the target.\nMax health is only computed and refreshed when you directly damage or heal your target", "Displays the health of the target.\nMax health is only computed and refreshed when you directly damage or heal your target"], _ ;未译
["Displays the system time (hour : minutes)", "Displays the system time (hour : minutes)"], _ ;未译
["Distance", "距离"], _ 
["Divinity Coast", "神圣海岸"], _
["Do you like my fish balloon? Can you hear it singing to you...?", "Do you like my fish balloon? Can you hear it singing to you...?"], _ ;未译
["DoA - City", "四门 - 托加之城"], _ 
["DoA - Foundry 1: Foundry Of Failed Creations", "四门 - 铸造厂 1: 失败事物铸造厂"], _ 
["DoA - Foundry 2: Foundry Breakout", "四门 - 铸造厂 2: 逃出铸造厂"], _
["DoA - Gloom 1: Deathbringer Company", "四门 - 夺心暗域 1: 死亡召唤大队"], _
["DoA - Gloom 2: The Rifts Between Us", "四门 - 夺心暗域 2: 异世界的裂缝"], _
["DoA - Gloom 3: To The Rescue!", "四门 - 夺心暗域 3: 前往救援!"], _ 
["DoA - Veil 1: Breaching Stygian Veil", "四门 - 冥狱之幕 1: 突破冥狱之幕"], _
["DoA - Veil 2: Brood Wars", "四门 - 冥狱之幕 2: 一网打尽"], _
["Docks -> Kaineng @ Mhenlo", "领事馆码头 -> 凯宁中心 @ 涵洛"], _ 
["Docks -> LA Gate @ Mhenlo", "领事馆码头 -> 狮门 @ 涵洛"], _ 
["Don't change", "Don't change"], _ ;未译
["Doomlore Shrine", "末日传说神殿"], _
["Double-click on the title bar to collapse a window.", "Double-click on the title bar to collapse a window."], _ ;未译
["Down", "Down"], _ ;未译
["Dragon's Lair, The", "龙穴"], _
["Dragon's Throat", "龙喉"], _
["Drake Kabob", "烤龙兽肉"], _ 
["Droknar's Forge", "卓克纳熔炉"], _
["Drop Gold Coin", "Drop Gold Coin"], _ ;未译
["Drop or Use Buff", "Drop or Use Buff"], _ ;未译
["Drop/Use %s", "Drop/Use %s"], _ ;未译
["DropUseBuff", "DropUseBuff"], _ ;未译
["Druid's Overlook", "德鲁伊高地"], _
["Dunes of Despair", "绝望沙丘"], _
["Dunkoro", "唐克罗"], _
["Durheim Archives", "杜汉姆卷藏室"], _
["Dzagonur Bastion", "萨岗诺棱堡"], _
["Edit", "修改"], _ ;候选词： 编辑 (欠佳)
["Effects", "Effects"], _ ;未译
["Effects##player", "Effects##player"], _ ;未译
["Elona Reach", "伊洛那流域"], _
["Elonian Leather Square", "伊洛那皮革"], _
["Embark Beach", "Embark Beach"], _ ;未译
["Embark", "Embark"], _ ;未译
["Ember Light Camp", "残火营地"], _
["Enable/Disable button", "启动/关闭 按钮"], _ 
["Enabled###pconstoggle", "已启动###pconstoggle"], _ 
["Enabled-Background", "Enabled-Background"], _ ;未译
["Enabling or disabling pcons will also Tick or Untick in party list", "Enabling or disabling pcons will also Tick or Untick in party list"], _ ;未译
["Enemy count", "(敌)个数统计"], _ ;候选词： 敌人总数，敌总数，敌数?统计
["Enter Challenge", "进入挑战任务"], _ 
["Enter DoA, FoW, or UW to begin", "启动前提： 角色已入悲难之门(四门)，灾难裂痕，或地下世界."], _ 
["Eredon Terrace", "尔雷登平地"], _
["Escort", "Escort"], _ ;未译
["Essence of Celerity", "敏捷精华"], _ 
["Essence of Celerity\nFeathers and Dust", "敏捷精华\n羽毛 及 闪烁之土"], _
["Eternal Grove, The", "永恒之林"], _
["Europe English", "欧洲 英语"], _ 
["Europe French", "欧洲 法语"], _ 
["Europe German", "欧洲 德语"], _ 
["Europe Italian", "欧洲 意大利语"], _ 
["Europe Polish", "欧洲 波兰语"], _ 
["Europe Russian", "欧洲 俄罗斯语"], _ 
["Europe Spanish", "欧洲 西班牙语"], _ 
["Execute a single task such as opening chests\nor reapplying lightbringer title", "Execute a single task such as opening chests\nor reapplying lightbringer title"], _ ;未译
["Execute the hotkey now", "即刻触发快键"], _ ;候选词： 激活，动用
["Execute...", "执行..."], _ ;候选词： ?
["Explorable", "探索区域"], _ 
["ExtraType", "ExtraType"], _ ;未译
["Eye of the North", "极地之眼"], _
["Faction mission outpost", "二章任务城"], _ 
["Fav%d", "Fav%d"], _ ;未译
["Favorites", "Favorites"], _ ;未译
["First item in inventory", "背包左上格内之物"], _ 
["Fishermen's Haven", "渔人避风港"], _
["FoW - Army Of Darkness", "灾难 - 黑暗的军队"], _
["FoW - Defend", "灾难 - 保护战争圣殿"], _ 
["FoW - Forgemaster", "灾难 - 永生的锻造大师"], _ 
["FoW - Griffons", "灾难 - 狮鹫兽礼物"], _ 
["FoW - Hunt", "灾难 - 猎杀碎片狼"], _ 
["FoW - Khobay", "灾难 - 背叛者库贝"], _ 
["FoW - Restore", "灾难 - 恢复圣殿"], _ 
["FoW - Slaves", "灾难 - 孟席斯的奴隶们"], _ 
["FoW - Toc", "灾难 - 勇气之塔"], _ 
["FoW - Tos", "灾难 - 力量之塔"], _ 
["FoW - WailingLord", "灾难 - 悲鸣领主"], _ 
["Foible's Fair", "佛伊伯市集"], _
["Forge", "永生的锻造大师"], _  ;或需复原
["Fort Aspenwood (Kurzick)", "杨木要塞 (库兹柯)"], _
["Fort Aspenwood (Luxon)", "杨木要塞 (勒克森)"], _
["Fort Ranik", "瑞尼克要塞"], _
["Foundry Reward", "铸造厂奖励2"], _ 
["Foundry", "Foundry"], _ ;未译
["Four Horseman", "多姆四骑士"], _ 
["Frontier Gate", "边境关所"], _
["Frost Gate, The", "寒霜之门"], _
["Full Conset Price: %g k", "三件套总价: %g k"], _ 
["Full Conset Price: (Material not available)", "三件套总价: (Material not available)"], _ ;未译
["Full Conset Price: -", "三件套总价: -"], _ 
["Functionality:", "功能:"], _ 
["Fur Square", "毛皮"], _
["GWToolbox++ version %s by Has and KAOS", "Has/KAOS 激战助手++ %s 版"], _ 
["Gadd's Encampment", "盖德营地"], _
["Gadd's", "Gadd's"], _ ;未译
["Gate of Anguish", "悲难之门"], _
["Gate of Desolation", "荒芜之地入口"], _
["Gate of Fear", "恐惧之门"], _
["Gate of Madness", "疯狂之门"], _
["Gate of Pain", "惩罚之门"], _
["Gate of Secrets", "奥秘之门"], _
["Gate of Torment", "苦痛之门"], _
["Gate of the Nightfallen Lands", "夜蚀暗殒领地之门"], _
["Gates of Kryta", "科瑞塔关所"], _
["General Interface", "General 界面"], _ ;未译
["General Morgahn", "摩根将军"], _
["General:", "General:"], _ ;未译
["Get away from my baby!", "Get away from my baby!"], _ ;未译
["Glob of Ectoplasm", "心灵之玉"], _
["Gloom", "Gloom"], _ ;未译
["Go, banana!", "Go, banana!"], _ ;未译
["Golden Egg", "金鸡蛋"], _ 
["Goren", "高恩"], _
["Gracious me, was I raving? Please forgive me. I'm mad.", "Gracious me, was I raving? Please forgive me. I'm mad."], _ ;未译
["Grail of Might", "力量圣杯"], _ 
["Grail of Might\nIron and Dust", "力量圣杯\n铁矿石 及 闪烁之土"], _ 
["Grand Court of Sebelkeh", "希贝克大公廷"], _
["Granite Citadel, The", "花岗岩堡垒"], _
["Great Northern Wall, The", "北方长城"], _
["Great Temple of Balthazar", "巴萨泽圣殿"], _
["Green Rock Candy", "绿冰糖"], _ 
["Grendich Courthouse", "葛兰迪法院"], _
["Griffons", "狮鹫兽礼物"], _ ;或需复原
["Gunnar's Hold", "甘拿的占领地"], _
["Gwen", "关"], _
["Gyala Hatchery", "盖拉孵化所"], _
["H#%d", "H#%d"], _ ;未译
["Hard Mode", "困难模式"], _ 
["Harvest Temple", "丰收神殿"], _
["Hayda", "海妲"], _
["Health", "体力"], _ 
["Height", "高度"], _ 
["Hell's Precipice", "地狱悬崖"], _
["Help", "说明"], _ 
["Henge of Denravi", "丹拉维圣地"], _
["Hero Build Name", "Hero Build Name"], _ ;未译
["Hero Builds", "英雄技能样本"], _ ;未译
["HeroTeamBuild", "HeroTeamBuild"], _ ;未译
["Heroes' Ascent", "英雄之路"], _
["Heroes' Audience", "英雄之痕"], _
["Hide Spiritual Possession and Lucky Aura", "Hide Spiritual Possession and Lucky Aura"], _ ;未译
["His blood has returned me to my mortal body.", "His blood has returned me to my mortal body."], _ ;未译
["Holy Veil", "神圣遮罩"], _ 
["Honur Hill", "霍奴尔丘陵"], _
["Hotkey: %s", "快键: %s"], _ 
["Hotkeys", "快键"], _ 
["House zu Heltzer", "凤荷议院"], _
["Human sacrifice. Dogs and cats living together. Mass hysteria!", "Human sacrifice. Dogs and cats living together. Mass hysteria!"], _ ;未译
["I have returned!", "I have returned!"], _ ;未译
["I like how they've decorated this place. The talking lights are a nice touch.", "I like how they've decorated this place. The talking lights are a nice touch."], _ ;未译
["I see dead people.", "I see dead people."], _ ;未译
["ID: 0x%X", "ID: 0x%X"], _ ;未译
["Ice Caves of Sorrow", "悲伤冰谷"], _
["Ice Tooth Cave", "冰牙洞穴"], _
["Imperial Sanctum", "帝国圣所"], _
["Important:\n", "警告:\n"], _ 
["In the commands above, <name> is the title of the window as shown in the title bar. For example, try '/hide settings' and '/show settings'.", "In the commands above, <name> is the title of the window as shown in the title bar. For example, try '/hide settings' and '/show settings'."], _ ;未译
["Info", "数据"], _ 
["Interface:", "Interface:"], _ ;未译
["International", "国际区"], _ ;未译
["Invalid argument '%ls', please use /pcons [|on|off]", "Invalid argument '%ls', please use /pcons [|on|off]"], _ ;未译
["Invalid dialog number '%s'", "无效令码 '%s'"], _ 
["Iron Mines of Moladune", "莫拉登矿山"], _
["It is needed to prevent toolbox from using a pcon twice, before it activates.\n", "It is needed to prevent toolbox from using a pcon twice, before it activates.\n"], _ ;未译
["It will automaticly withdraw and deposit gold while buying materials", "It will automaticly withdraw and deposit gold while buying materials"], _ ;未译
["It's a trick. Get an axe.", "It's a trick. Get an axe."], _ ;未译
["Item #%d not found!", "Item #%d not found!"], _ ;未译
["Item ID", "Item ID"], _ ;未译
["Item Name", "Item Name"], _ ;未译
["Item", "Item"], _ ;未译
["ItemID", "ItemID"], _ ;未译
["ItemId", "ItemId"], _ ;未译
["ItemName", "ItemName"], _ ;未译
["Items per row", "Items per row"], _ ;未译
["Jade Flats (Kurzick)", "翡翠浅滩 (库兹柯)"], _
["Jade Flats (Luxon)", "翡翠浅滩 (勒克森)"], _
["Jade Quarry (Kurzick), The", "翡翠矿场 (库兹柯)"], _
["Jade Quarry (Luxon), The", "翡翠矿场 (勒克森)"], _
["Jadeite Shard", "硬玉"], _
["Jennur's Horde", "征钠群落"], _
["Jokanur Diggings", "卓坎诺挖掘点"], _
["Jora", "乔拉"], _
["Just used the last %s", "Just used the last %s"], _ ;未译
["Kahmu", "卡慕"], _
["Kaineng Center", "凯宁中心"], _
["Kama -> Docks @ Hahnna", "卡玛丹 -> 领事馆码头 @ Hahnna"], _ ;未译
["Kamadan", "卡玛丹"], _ 
["Kamadan, Jewel of Istan", "卡玛丹，艾斯坦之钻"], _
["Keep away. The sow is mine.", "Keep away. The sow is mine."], _ ;未译
["Keiran Thackeray", "Keiran Thackeray"], _ ;未译
["Khobay", "Khobay"], _ ;未译
["Klaatu...barada...necktie?", "Klaatu...barada...necktie?"], _ ;未译
["Kodash Bazaar, The", "库丹西市集广场"], _
["Kodlonu Hamlet", "克拓奴，哈姆雷特"], _
["Kodonur Crossroads", "科登诺路口"], _
["Koss", "寇斯"], _
["LA Gate -> LA @ Neiro", "狮门 -> 狮子拱门 @ Neiro"], _ ;未译
["Lair of the Forgotten", "被遗忘者的巢穴"], _
["Last Dialog", "前一令码"], _ ;候选词： 暂无
["Leather Square", "皮革"], _
["Left", "Left"], _ ;未译
["Level = %d, tint = %d\n", "Level = %d, tint = %d\n"], _ ;未译
["Level", "Level"], _ ;未译
["Leviathan Pits", "利拜亚森矿场"], _
["Lion's Arch", "狮子拱门"], _
["Livia", "莉薇亚"], _
["Load Build on Hero", "Load Build on Hero"], _ ;未译
["Load Build on Player", "Load Build on Player"], _ ;未译
["Load Hero Team Build", "Load Hero Team Build"], _ ;未译
["Load Now", "即刻装填"], _ 
["Load Team Hero Build '%s'", "Load Team Hero Build '%s'"], _ ;未译
["Load a team hero build from the Hero Build Panel", "Load a team hero build from the Hero Build Panel"], _ ;未译
["Load build on your character", "为角色装填技能样本"], _ 
["Load", "装填"], _ 
["Loading\0\0\0", "正在读图\0\0\0"], _ ;候选词： 正在装载
["LoginNumber", "LoginNumber"], _ ;未译
["Longeye's Ledge", "长眼岩脉"], _
["Low on %s, please refill or disable", "%s 即将耗尽, please refill or disable"], _ ;未译
["Lump of Charcoal", "结块的木炭"], _
["Lunar Fortunes", "命运锦囊"], _ 
["Lunars and Alcohol", "Lunars and Alcohol"], _ ;未译
["Lunars delay", "Lunars delay"], _ ;未译
["Lutgardis Conservatory", "路嘉帝斯温室"], _
["Maatu Keep", "麻都堡垒"], _
["Maguuma Stade", "梅古玛丛林"], _
["Map ID is unique for each area", "每处皆有一独特的地图号"], _ 
["Map ID", "Map ID"], _ ;未译
["Map Type", "Map Type"], _ ;未译
["Map file is unique for each pathing map (e.g. used by minimap).\nMany different maps use the same map file", "Map file is unique for each pathing map (e.g. used by minimap).\nMany different maps use the same map file"], _ ;未译
["Map file", "Map file"], _ ;未译
["Margrid The Sly", "狡猾者玛格丽特 (狡诈者玛格丽)"], _
["Marhan's Grotto", "马翰洞穴"], _
["Marker: (%.0f, %.0f)", "指向针: (%.0f, %.0f)"], _ ;候选词： 路标，指示牌，指路针 (此处或该有个'相关任务'的概念)
["Marketplace, The", "市集"], _
["Master Of Whispers", "唤言大师"], _
["Materials", "材料"], _ 
["Melonni", "梅隆妮"], _
["Menzies", "黑暗的军队"], _ ;或需复原 ;候选词： 孟席斯的奴隶们
["Mercenary Hero 1", "佣兵 1"], _ 
["Mercenary Hero 2", "佣兵 2"], _ 
["Mercenary Hero 3", "佣兵 3"], _ 
["Mercenary Hero 4", "佣兵 4"], _ 
["Mercenary Hero 5", "佣兵 5"], _ 
["Mercenary Hero 6", "佣兵 6"], _ 
["Mercenary Hero 7", "佣兵 7"], _ 
["Mercenary Hero 8", "佣兵 8"], _ 
["Message", "Message"], _ ;未译
["Mihanu Township", "米哈努小镇"], _
["Miku", "Miku"], _ ;未译
["Minimap", "Minimap"], _ ;未译
["Minister Cho's Estate", "周大臣庄园"], _
["Mnts", "Mnts"], _ ;未译
["Moddok Crevice", "摩多克裂缝"], _
["Mode", "Mode"], _ ;未译
["Model ID is unique for each kind of agent.\nIt is static and shared by the same agents.\nWhen targeting players, this is Player ID instead, unique for each player in the instance.\nFor the purpose of targeting hotkeys and commands, use this value", "Model ID is unique for each kind of agent.\nIt is static and shared by the same agents.\nWhen targeting players, this is Player ID instead, unique for each player in the instance.\nFor the purpose of targeting hotkeys and commands, use this value"], _ ;未译
["Model ID##target", "Model ID##target"], _ ;未译
["ModelID", "ModelID"], _ ;未译
["ModelState", "ModelState"], _ ;未译
["Mommy? Where are you? I can't find you. I can't. I'm afraid of the light, mommy. I'm afraid of the light.", "Mommy? Where are you? I can't find you. I can't. I'm afraid of the light, mommy. I'm afraid of the light."], _ ;未译
["Monstrous Claw", "巨大的爪"], _
["Monstrous Eye", "巨大的眼"], _
["Monstrous Fang", "巨大尖牙"], _
["Mountains", "双头龙山"], _ 
["Mouse Wheel to scroll.", "Mouse Wheel to scroll."], _ ;未译
["Mouth of Torment, The", "苦痛之地隘口"], _
["Move Down", "Move Down"], _ ;未译
["Move Up", "Move Up"], _ ;未译
["Move the hotkey down in the list", "Move the hotkey down in the list"], _ ;未译
["Move the hotkey up in the list", "Move the hotkey up in the list"], _ ;未译
["Move the teambuild down in the list", "Move the teambuild down in the list"], _ ;未译
["Move the teambuild up in the list", "Move the teambuild up in the list"], _ ;未译
["Move to %s", "前往 %s"], _ 
["Move to (%.0f, %.0f)", "前往坐标 (%.0f, %.0f)"], _ 
["Move to a specific (x,y) coordinate", "前往既定坐标 (x,y)"], _ 
["Move to", "前往"], _ 
["Move", "Move"], _ ;未译
["Moving to %s", "正在前往 %s"], _ 
["Moving to (%.0f, %.0f)", "正在前往坐标 (%.0f, %.0f)"], _ 
["My cat's breath smells like cat food.", "My cat's breath smells like cat food."], _ ;未译
["My cat's name is Mittens.", "My cat's name is Mittens."], _ ;未译
["Nahpui Quarter", "纳普区"], _
["Name", "Name"], _ ;未译
["NameProperties", "NameProperties"], _ ;未译
["Nightfall mission outpost", "三章任务城"], _ 
["No Hero", "No Hero"], _ ;未译
["No one can stop me, let alone you puny mortals!", "No one can stop me, let alone you puny mortals!"], _ ;未译
["Nolani Academy", "若拉尼学院"], _
["Norgu", "诺古"], _
["Normal Mode", "普通模式"], _ 
["Not connected", "已失联/已断网"], _ 
["Note: the names of the widgets without a visible title bar are the same as in the setting headers below.", "Note: the names of the 配件 without a visible title bar are the same as in the setting headers below."], _ ;未译
["Notepad", "便笺"], _ 
["Number of favorites", "Number of favorites"], _ ;未译
["Nundu Bay", "纳度湾"], _
["Objective Timer", "Objective Timer"], _ ;未译
["Obsidian Shard", "黑曜石碎片"], _
["Ogden", "Ogden"], _ ;未译
["Oh boy, sleep! That's where I'm a Luxon.", "Oh boy, sleep! That's where I'm a Luxon."], _ ;未译
["Olafstead", "欧拉夫之地"], _
["Olias", "奥里亚斯"], _
["Only affects windows (with a title bar), not widgets", "Only affects windows (with a title bar), not 配件"], _ ;未译
["Only in Domain of Anguish, within 1400 range", "Only in 悲难领地, within 1400 range"], _
["Only show messages containing:", "Only show messages containing:"], _ ;未译
["Onyx Gemstone", "玛瑙宝石"], _
["Open GWToolbox++ Website", "打开 激战助手++ 网站"], _ 
["Open Locked Chest", "打开锁住的宝箱"], _ 
["Open Settings Folder", "打开设置夹"], _ 
["Open Xunlai Chest", "打开桑莱保险箱"], _ 
["Opening and closing windows", "Opening and closing windows"], _ ;未译
["Outpost\0\0\0", "城镇\0\0\0"], _ 
["Owner", "Owner"], _ ;未译
["Pahnai Salad", "伊波枷沙拉"], _ 
["Pcon Size", "Pcon Size"], _ ;未译
["Pcons %s", "Pcons %s"], _ ;未译
["Pcons delay", "Pcons delay"], _ ;未译
["Pcons", "补品"], _ 
["Piken Square", "派肯广场"], _
["Ping Build", "Ping Build"], _ ;未译
["Ping a build from the Build Panel", "Ping a build from the Build Panel"], _ ;未译
["Ping build '%s'", "Ping build '%s'"], _ ;未译
["PingBuild", "PingBuild"], _ ;未译
["Pits", "骷髅墓穴"], _ 
["Planes", "混沌平原"], _ 
["Player ID is unique for each human player in the instance.", "Player ID is unique for each human player in the instance."], _ ;未译
["Player ID##player", "Player ID##player"], _ ;未译
["Player", "Player"], _ ;未译
["PlayerNumber", "PlayerNumber"], _ ;未译
["Pogahn Passage", "波甘驿站"], _
["Pools", "孵化池"], _ 
["Port Sledge", "雪橇港"], _
["Powered by https://kamadan.decltype.org", "广告网(文字版) https://kamadan.github.io"], _ 
["Powerstone of Courage\nGranite and Dust", "勇气粉石\n花岗岩石板 及 闪烁之土"], _ 
["Press key", "按键"], _ 
["Price Check##armor", "估价##armor"], _ ;候选词： 验价，鉴价
["Price Check##essence", "估价##essence"], _ ;候选词： 验价，鉴价
["Price Check##grail", "估价##grail"], _ ;候选词： 验价，鉴价
["Price Check##pstone", "估价##pstone"], _ ;候选词： 验价，鉴价
["Price Check##resscroll", "估价##resscroll"], _ ;候选词： 验价，鉴价
["Price:  -", "Price:  -"], _ ;未译
["Price: %g k", "Price: %g k"], _ ;未译
["Price: (Material not available)", "Price: (Material not available)"], _ ;未译
["Price: Computing (in queue)", "Price: Computing (in queue)"], _ ;未译
["Price: Computing (request sent)", "Price: Computing (request sent)"], _ ;未译
["Primary Prof", "主职业"], _ 
["Prof Change - Assassin", "职业更换 - 暗杀"], _ 
["Prof Change - Dervish", "职业更换 - 神唤"], _ 
["Prof Change - Elementalist", "职业更换 - 元素"], _ 
["Prof Change - Mesmer", "职业更换 - 幻术"], _ 
["Prof Change - Monk", "职业更换 - 僧侣"], _ 
["Prof Change - Necro", "职业更换 - 死灵"], _ 
["Prof Change - Paragon", "职业更换 - 圣言"], _ 
["Prof Change - Ranger", "职业更换 - 游侠"], _ 
["Prof Change - Ritualist", "职业更换 - 祭祀"], _ 
["Prof Change - Warrior", "职业更换 - 战士"], _ 
["Pyre Fierceshot", "烈之击炎焰"], _
["Quarrel Falls", "怨言瀑布"], _
["Quest", "Quest"], _ ;未译
["Quest%d", "Quest%d"], _ ;未译
["Raisu Palace", "莱苏皇宫"], _
["Ran Musu Gardens", "岚穆苏花园"], _
["Random Arenas", "随机竞技场"], _
["Range", "Range"], _ ;未译
["Rata Sum", "洛达顶点"], _
["Razah", "雷萨"], _
["Ready", "Ready"], _ ;未译
["Reapply appropriate Title", "重新展示相关头衔"], _ 
["Recall", "回归"], _ 
["Recall\0Unyielding Aura\0Holy Veil\0Other", "回归\0坚毅灵气\0神圣遮罩\0其他"], _ 
["Received price %d for %d (item %d)\n", "Received price %d for %d (item %d)\n"], _ ;未译
["Red Rock Candy", "红冰糖"], _ 
["Remains of Sahlahja", "萨拉迦遗址"], _
["Resign Log", "退出令统计"], _ 
["Resigned", "已发退出令"], _ 
["Restore", "Restore"], _ ;未译
["Reward", "奖励"], _ 
["Rilohn Refuge", "里欧恩难民营"], _
["Ring of Fire", "火环群岛"], _
["Riverside Province", "河畔地带"], _
["Roll of Parchment", "羊皮纸卷"], _
["Roll of Vellum", "牛皮纸卷"], _
["Rotation", "面向"], _ 
["Ruby", "红宝石"], _
["Ruins of Morah", "摩拉废墟"], _
["Ruins of Surmia", "苏米亚废墟"], _
["Saint Anjeka's Shrine", "圣者安捷卡的祭坛"], _
["Sanctum Cay", "神圣沙滩"], _
["Sapphire", "蓝宝石"], _
["Sardelac Sanitarium", "萨德拉克疗养院"], _
["Save Now", "即刻存档"], _ 
["Scroll of Resurrection\nFibers and Bones", "复活卷轴\n植物纤维 及 骨头"], _
["Seafarer's Rest", "航海者休憩处"], _
["Search", "Search"], _ ;未译
["Secondary Prof", "副职业"], _ 
["Seeker's Passage", "探索者通道"], _
["Seitung Harbor", "青函港"], _
["Select Hotkey", "选择快键"], _ 
["Select a favorite", "Select a favorite"], _ ;未译
["Sell##common", "卖##common"], _ 
["Sell##rare", "卖##rare"], _ 
["Send Chat hotkey to enter one of the commands above.", "Send Chat hotkey to enter one of the commands above."], _ ;未译
["Send Chat", "Send Chat"], _ ;未译
["Send Kamadan ad1 trade chat to your trade chat", "把卡玛丹1区的广告导入角色的交易频道"], _ 
["Send a Dialog", "发送令码"], _ 
["Send a message or command to chat", "Send a message or command to chat"], _ ;未译
["Send chat '%c%s'", "Send chat '%c%s'"], _ ;未译
["Send to team chat", "往队伍频道发送"], _ 
["Send", "发送"], _ 
["Send##1", "发送##1"], _ 
["Send##2", "发送##2"], _ 
["SendChat", "SendChat"], _ ;未译
["Senji's Corner", "山吉之街"], _
["Sent dialog %s (%d)", "已发令码 %s (%d)"], _ 
["Serenity Temple", "宁静神殿"], _
["Settings", "设置"], _ 
["Shadow Nexus, The", "阴郁核心"], _
["Shing Jea Arena", "星岬竞技场"], _
["Shing Jea Monastery", "星岬寺"], _
["Show 'Active' checkbox in header", "Show 'Active' checkbox in header"], _ ;未译
["Show 'End' column", "Show 'End' column"], _ ;未译
["Show 'Open Xunlai Chest' button", "Show 'Open Xunlai Chest' button"], _ ;未译
["Show 'Run' button in header", "Show 'Run' button in header"], _ ;未译
["Show 'Start' column", "Show 'Start' column"], _ ;未译
["Show 'Time' column", "Show 'Time' column"], _ ;未译
["Show Dialog", "Show Dialog"], _ ;未译
["Show Enemy Count", "Show Enemy Count"], _ ;未译
["Show Item", "Show Item"], _ ;未译
["Show Map", "Show Map"], _ ;未译
["Show Player", "Show Player"], _ ;未译
["Show Quest", "Show Quest"], _ ;未译
["Show Resign Log", "Show 退出令统计"], _ ;未译
["Show Target", "Show Target"], _ ;未译
["Show numbers", "Show numbers"], _ ;未译
["Show second decimal", "Show second decimal"], _ ;未译
["Show the bonds maintained by you.\nOnly works on human players", "Show the bonds maintained by you.\nOnly works on human players"], _ ;未译
["Show the damage done by each player in your party.\nOnly works on the damage done within your radar range.", "Show the damage done by each player in your party.\nOnly works on the damage done within your radar range."], _ ;未译
["Show widget toggles", "Show 配件开关"], _ ;未译
["Show:", "Show:"], _ ;未译
["Shows a countdown timer for alcohol", "Shows a countdown timer for alcohol"], _ ;未译
["Sifhalla", "袭哈拉"], _
["Size of each Pcon icon in the interface", "Size of each Pcon icon in the interface"], _ ;未译
["Skill ID", "Skill ID"], _ ;未译
["Skill", "Skill"], _ ;未译
["Skill#%d", "Skill#%d"], _ ;未译
["SkillID", "技能号"], _ 
["Slice of Pumpkin Pie", "南瓜派"], _ 
["Soon you will all be crushed.", "Soon you will all be crushed."], _ ;未译
["Speed##player", "Speed##player"], _ ;未译
["Speed##target", "Speed##target"], _ ;未译
["Spiritwood Plank", "心灵之板"], _
["Start", "开始"], _ 
["Steel Ingot", "钢铁矿石"], _ 
["Such fools to think you can attack me here. Come closer so you can see the face of your doom!", "Such fools to think you can attack me here. Come closer so you can see the face of your doom!"], _ ;未译
["Sunjiang District", "孙江行政区"], _
["Sunspear Arena", "日戟竞技场"], _
["Sunspear Great Hall", "日戟大会堂"], _
["Sunspear Sanctuary", "日戟避难所"], _
["Suppress drunk emotes", "Suppress drunk emotes"], _ ;未译
["Suppress lunar and drunk post-processing effects", "Suppress lunar and drunk post-processing effects"], _ ;未译
["Suppress lunar and drunk text", "Suppress lunar and drunk text"], _ ;未译
["TAB or SHIFT+TAB to cycle through keyboard editable fields.", "TAB or SHIFT+TAB to cycle through keyboard editable fields."], _ ;未译
["Tahlkora", "塔蔻菈"], _
["Tahnnakai Temple", "谭纳凯神殿"], _
["Take me now, subcreature.", "Take me now, subcreature."], _ ;未译
["Take quest in Mountains", "接双头龙山的任务"], _ 
["Take quest in Planes", "接混沌平原的任务"], _ 
["Take quest", "接任务"], _ 
["Take", "接"], _ 
["Tanglewood Copse", "谭格梧树林"], _
["Target #%d", "Target #%d"], _ ;未译
["Target %s", "Target %s"], _ ;未译
["Target ID", "Target ID"], _ ;未译
["Target a game entity by its ID", "Target a game entity by its ID"], _ ;未译
["Target", "Target"], _ ;未译
["TargetID", "TargetID"], _ ;未译
["TargetName", "TargetName"], _ ;未译
["Tarnished Haven", "灰暗避难所"], _
["TeamId", "TeamId"], _ ;未译
["Teleport Lab", "传送至 地下世界 迷宫"], _ 
["Teleport Mountains\nThis is NOT the mountains quest", "传送至 地下世界 双头龙山\n此 [非] 龙山 任务"], _ 
["Teleport Pits", "传送至 地下世界 骷髅墓穴"], _ 
["Teleport Planes", "传送至 地下世界 混沌平原"], _ 
["Teleport Pools", "传送至 地下世界 孵化池"], _ 
["Teleport Vale", "传送至 地下世界 遗忘谷"], _ 
["Telport Wastes", "传送至 地下世界 荒凉冰地"], _ 
["Tempered Glass Vial", "调合后的玻璃瓶"], _
["Template", "Template"], _ ;未译
["Temple of the Ages", "世纪神殿"], _
["The Barradin Estate", "巴拉丁庄园"], _
["The Hunt", "猎杀碎片狼"], _
["The connection to kamadan.decltype.com has timed out.", "对 kamadan.github.io 广告网的连接请求已超时."], _ 
["The hotkey can trigger only when selected", "The hotkey can trigger only when selected"], _ ;未译
["The hotkey will only trigger in this map.\nUse 0 for any map.", "The hotkey will only trigger in this map.\nUse 0 for any map."], _ ;未译
["The hotkey will only trigger within this range.\nUse 0 for no limit.", "The hotkey will only trigger within this range.\nUse 0 for no limit."], _ ;未译
["Then the healer told me that BOTH my eyes were lazy. And that's why it was the best summer ever!", "Then the healer told me that BOTH my eyes were lazy. And that's why it was the best summer ever!"], _ ;未译
["There are several ways to open and close toolbox windows and widgets:", "There are several ways to open and close 助手窗口及配件:"], _ ;未译
["There's a reason there's a festival ticket in my ear. I'm trying to lure the evil spirits out of my head.", "There's a reason there's a festival ticket in my ear. I'm trying to lure the evil spirits out of my head."], _ ;未译
["Thirsty River", "干枯河流"], _
["This feature is experimental and might crash your game.\n", "This feature is experimental and might crash your game.\n"], _ ;未译
["This house has many hearts.", "This house has many hearts."], _ ;未译
["This house is clean.", "This house is clean."], _ ;未译
["This will prevent kneel, bored, moan, flex, fistshake and roar.\n", "This will prevent kneel, bored, moan, flex, fistshake and roar.\n"], _ ;未译
["Thresholds", "Thresholds"], _ ;未译
["Thunderhead Keep", "雷云要塞"], _
["Tick with pcons", "Tick with pcons"], _ ;未译
["Tihark Orchard", "提亚克林地"], _
["Time the instance has been active", "Time the instance has been active"], _ ;未译
["Time", "Time"], _ ;未译
["Timer", "Timer"], _ ;未译
["Toggle %s", "Toggle %s"], _ ;未译
["Toggle a GWToolbox++ functionality such as clicker", "Toggle 激战助手++ 功能 such as clicker"], _ ;未译
["Toggle", "Toggle"], _ ;未译
["Toggle###combo", "Toggle###combo"], _ ;未译
["Toggle...", "Toggle..."], _ ;未译
["ToggleID", "ToggleID"], _ ;未译
["Tomb of the Primeval Kings", "先王之墓"], _
["Toolbox normally loads settings on launch.\nClick to re-load from disk now.", "Toolbox normally loads settings on launch.\n点击以即可重装."], _ ;未译 ;候选词： 缺 ('重装' 欠佳)
["Toolbox normally saves settings on exit.\nClick to save to disk now.", "Toolbox normally saves settings on exit.\n点击以即刻存档."], _ ;未译
["Toolbox will disable a pcon if it is not found in the inventory", "Toolbox will disable a pcon if it is not found in the inventory"], _ ;未译
["Toolbox", "Toolbox"], _ ;未译
["Tower of Strength", "力量之塔"], _
["Trade Alerts", "买卖提示"], _ 
["Trade", "Trade"], _ ;未译
["Travel To...", "前往..."], _ 
["Travel", "直达"], _ ;候选词： 位移
["Tsumei Village", "苏梅村"], _
["Type", "Type"], _ ;未译
["UW - Chamber", "地下 - 清除密室的障碍"], _ 
["UW - Escort", "地下 - 护送灵魂"], _ 
["UW - Mnt", "地下 - 恶魔暗杀者"], _ 
["UW - Pits", "地下 - 被拘禁的亡魂"], _ 
["UW - Planes", "地下 - 多姆四骑士"], _ 
["UW - Pools", "地下 - 恐惧蛛化精灵女王"], _ 
["UW - Restore", "地下 - 恢复古兰斯圣像"], _ 
["UW - UWG", "地下 - 不速之客"], _ 
["UW - Vale", "地下 - 愤怒的灵魂"], _ 
["UW - Wastes", "地下 - 古兰斯的使者"], _ 
["UW Teles", "地下传送"], _ 
["Umbral Grotto", "阴影石穴"], _
["Unknown", "不明"], _ 
["Unwaking Waters (Kurzick)", "沉睡之水 (库兹柯)"], _
["Unwaking Waters (Luxon)", "沉睡之水 (勒克森)"], _
["Urgoz", "尔果"], _ 
["Urgoz's Warren", "尔果的养殖场"], _
["Use #%d", "Use #%d"], _ ;未译
["Use %s", "Use %s"], _ ;未译
["Use Item", "Use Item"], _ ;未译
["Use an item from your inventory", "Use an item from your inventory"], _ ;未译
["Use or cancel a skill such as Recall or UA", "Use or cancel a skill such as Recall or UA"], _ ;未译
["UseItem", "UseItem"], _ ;未译
["Using level 1 alcohol instead of this is recommended for preventing drunk emotes.\n", "Using level 1 alcohol instead of this is recommended for preventing drunk emotes.\n"], _ ;未译
["Lab", "迷宫"], _ 
["Vale", "遗忘谷"], _ 
["Vasburg Armory", "维思伯兵营"], _
["Veil", "Veil"], _ ;未译
["Vekk", "维克"], _
["Venta Cemetery", "凡特墓地"], _
["Ventari's Refuge", "凡特里庇护所"], _
["Version %s is available!", "%s 版助手已发行!"], _ 
["Vial of Ink", "小瓶墨水"], _ 
["Visibility", "Visibility"], _ ;未译
["Vizunah Square (Foreign)", "薇茹广场 (外地)"], _
["Vizunah Square (Local)", "薇茹广场 (本地)"], _
["Vlox's Falls", "弗洛克斯瀑布"], _
["Vlox's", "Vlox's"], _ ;未译
["WSAStartup Failed.\n", "WSAStartup 失败.\n"], _ ;未译
["Wailing Lord", "Wailing Lord"], _ ;未译
["War Supplies", "战承物资"], _ 
["Waste", "Waste"], _ ;未译
["Wastes", "荒凉冰地"], _ 
["We must prepare for the coming of Banjo the Clown, God of Puppets.", "We must prepare for the coming of Banjo the Clown, God of Puppets."], _ ;未译
["WeaponType", "WeaponType"], _ ;未译
["Wehhan Terraces", "薇恩平台"], _
["When I grow up, I want to be a principal or a caterpillar.", "When I grow up, I want to be a principal or a caterpillar."], _ ;未译
["When you have less than this amount:\n-The number in the interface becomes yellow.\n-Warning message is displayed when zoning into outpost.", "When you have less than this amount:\n-The number in the interface becomes yellow.\n-Warning message is displayed when zoning into outpost."], _ ;未译
["While editing text:\n", "While editing text:\n"], _ ;未译
["Widgets:", "配件:"], _ 
["Width", "宽度"], _ 
["Wilds, The", "荒原"], _
["Will actually disable any *change*, so make sure you're not drunk already when enabling this!", "Will actually disable any *change*, so make sure you're not drunk already when enabling this!"], _ ;未译
["Will close the travel window when clicking on a travel destination", "Will close the travel window when clicking on a travel destination"], _ ;未译
["Will hide drunk and lunars messages on top of your and other characters", "Will hide drunk and lunars messages on top of your and other characters"], _ ;未译
["Will hide the skills in your effect monitor", "Will hide the skills in your effect monitor"], _ ;未译
["Windows:", "Windows:"], _ ;未译
["Working", "Working"], _ ;未译
["X pos##player", "X 坐标##player"], _ ;候选词： X向/轴 位/方位/定位
["X pos##target", "X 坐标##target"], _ ;候选词： X向/轴 位/方位/定位
["Xandra", "珊卓亚"], _
["Y pos##player", "Y 坐标##player"], _ ;候选词： X向/轴 位/方位/定位
["Y pos##target", "Y 坐标##target"], _ ;候选词： X向/轴 位/方位/定位
["Yahnur Market", "雅诺尔市集"], _
["Yak's Bend", "牦牛村"], _
["Yohlon Haven", "犹朗避难所"], _
["You are messing with affairs that are beyond your comprehension. Leave now and I may let you live!", "You are messing with affairs that are beyond your comprehension. Leave now and I may let you live!"], _ ;未译
["You are no match for my almighty power.", "You are no match for my almighty power."], _ ;未译
["You can prefix the number by \", "You can prefix the number by \"], _ ;未译
["You're disgusting, but I love you!", "You're disgusting, but I love you!"], _ ;未译
["Zaishen Challenge", "战承挑战赛"], _
["Zaishen Elite", "战承精英"], _
["Zaishen Menagerie", "战承动物园"], _
["Zei Ri", "Zei Ri"], _ ;未译
["Zen Daijun", "祯台郡"], _
["Zenmai", "刃玛伊"], _
["Zhed Shadowhoof", "影爪杰德"], _
["Zin Ku Corridor", "辛库走廊"], _
["Zos Shivros Channel", "佐席洛斯水道"], _
["[%s] ~ Start: %s ~ End: %s ~ Time: %s", "[%s] ~ 开始: %s ~ 结束: %s ~ 耗时: %s"], _ 
["active", "active"], _ ;未译 ;候选词： 现行
["alcohol", "酒水"], _ 
["apple", "糖苹果"], _ 
["armor", "救赎防具"], _ 
["blocked skill %d\n", "blocked skill %d\n"], _ ;未译
["bluerock", "蓝冰糖"], _ 
["buildname", "buildname"], _ ;未译
["builds", "builds"], _ ;未译
["builds%03d", "builds%03d"], _ ;未译
["channel", "频道"], _ 
["city", "city"], _ ;未译
["corn", "粟米糖"], _ 
["count", "个数统计"], _ 
["cupcake", "生日杯子蛋糕"], _ 
["days", "天"], _ 
["disabled", "已关闭"], _ 
["distance", "距离"], _ 
["enabled", "已启动"], _ 
["essence", "敏捷精华"], _ 
["fav_count", "fav_count"], _ ;未译
["grail", "力量圣杯"], _ 
["greenrock", "绿冰糖"], _ 
["header", "header"], _ ;未译
["heroindex%d", "heroindex%d"], _ ;未译
["hotkey-", "hotkey-"], _ ;未译
["hotkey-%03d:%s", "hotkey-%03d:%s"], _ ;未译
["hour", "小时"], _ 
["hours", "小时"], _ 
["https://kamadan.decltype.org", "https://kamadan.github.io"], _ 
["id: %d", "id: %d"], _ ;未译
["img/icons", "img/icons"], _ ;未译
["img/materials", "img/materials"], _ ;未译
["img/pcons", "img/pcons"], _ ;未译
["kabob", "烤龙兽肉"], _ 
["lunars", "命运锦囊"], _ 
["mapid", "地图号"], _ 
["message", "message"], _ ;未译
["minute", "分钟"], _ 
["minutes", "分钟"], _ 
["mode", "模式"], _ 
["name", "name"], _ ;未译
["name%d", "name%d"], _ ;未译
["num_results", "num_results"], _ ;未译
["offset", "差位"], _ 
["open", "打开"], _ 
["pcons", "pcons"], _ ;未译
["pconsize", "pconsize"], _ ;未译
["plane", "plane"], _ ;未译
["query", "query"], _ ;未译
["redrock", "红冰糖"], _ 
["resignlog", "resignlog"], _ ;未译
["results", "results"], _ ;未译
["salad", "伊波枷沙拉"], _ 
["second", "秒"], _ 
["seconds", "秒"], _ 
["selling", "selling"], _ ;未译
["sending purchase request for %d (price=%d)\n", "sending purchase request for %d (price=%d)\n"], _ ;未译
["sending sell request for %d (price=%d)\n", "sending sell request for %d (price=%d)\n"], _ ;未译
["showNumbers", "showNumbers"], _ ;未译
["show_active_in_header", "show_active_in_header"], _ ;未译
["show_run_in_header", "show_run_in_header"], _ ;未译
["soup", "鳞怪鳍汤"], _ 
["start string", "start string"], _ ;未译
["sugest", "sugest"], _ ;未译
["suggest", "suggest"], _ ;未译
["template%d", "template%d"], _ ;未译
["timestamp", "timestamp"], _ ;未译 ;候选词： 时戳
["title", "title"], _ ;未译
["trade_scroll", "trade_scroll"], _ ;未译
["travelto", "travelto"], _ ;未译
["typeMap", "typeMap"], _ ;未译
["warsupply", "warsupply"] _ ;未译
]

;记录文件夹及其子夹内的所有.cpp文件名
Local $fileNames=_FileListToArrayRec(@ScriptDir, "*.cpp", $FLTAR_FILES,  $FLTAR_RECUR)
;除去记录文件数目的首项
_ArrayDelete($fileNames, 0)

;记录文件夹及其子夹内的所有.h文件名
Local $fileNames1=_FileListToArrayRec(@ScriptDir, "*.h", $FLTAR_FILES,  $FLTAR_RECUR)
;除去记录文件数目的首项
_ArrayDelete($fileNames1, 0)

;拼凑以上结果
_ArrayConcatenate($fileNames, $fileNames1)

;在首部插入统计文件总数的项
_ArrayInsert ($fileNames, 0, UBound($fileNames))

for $i=1 to $fileNames[0]

	Local $rFileOpen = FileOpen($fileNames[$i])
	Local $fileRead =FileRead($rFileOpen)
	FileClose($rFileOpen)

	$fileRead = Convert($fileRead)

	Local $wFileOpen = FileOpen($fileNames[$i], 130)
	FileWrite ($wFileOpen, $fileRead)
	FileClose($wFileOpen)
Next

msgbox(0,"提示", "替换完毕")

Func Convert($lData)

	Local $original = $lData

	For $i = 0 To Ubound($ConversionTable) - 1
        if $ConversionTable[$i][0] <> $ConversionTable[$i][1] then
            $lData = StringReplace($lData, chr(34) & $ConversionTable[$i][0] & chr(34), chr(34) & $ConversionTable[$i][1]  & chr(34), 0, $STR_CASESENSE)
            ;替换过程中，以下指令会罔顾字条两端要有双引号的要求。或该用 stringregexpreplace 并 设定 词界        
            ;$lData = StringReplace($lData, '"' & $ConversionTable[$i][0] & '"', '"' & $ConversionTable[$i][1]  & '"', 0, $STR_CASESENSE)
        endif            
	Next

	return $lData
    
EndFunc