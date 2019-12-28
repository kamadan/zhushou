#include-once
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>
#include <File.au3>
#include <WinAPI.au3>

Local $ConversionTable[1911][2] = [ _
['" (%s ago)"', '"00000"'], _
['" + folder + L"', '"00000"'], _
['" + map_string + prof_string + L"', '"00000"'], _
['" // enter something like "', '"00000"'], _
['" 0x%X"', '"00000"'], _
['" Whisper"', '"00000"'], _
['" duration: %d"', '"00000"'], _
['" to specify an hexadecimal number"', '"00000"'], _
['" || arg1 == L"', '"00000"'], _
['" || s == L"', '"00000"'], _
['" || town == L"', '"00000"'], _
['"! All"', '"00000"'], _
['"# Group"', '"00000"'], _
['"###active"', '"00000"'], _
['"###armorqty"', '"00000"'], _
['"###code"', '"00000"'], _
['"###dialogcombo"', '"00000"'], _
['"###dialoginput"', '"00000"'], _
['"###district"', '"00000"'], _
['"###essenceqty"', '"00000"'], _
['"###grailqty"', '"00000"'], _
['"###heroid"', '"00000"'], _
['"###name"', '"00000"'], _
['"###pstoneqty"', '"00000"'], _
['"###resscrollqty"', '"00000"'], _
['"##alertfilter"', '"00000"'], _
['"##awaydelay"', '"00000"'], _
['"##byauthorfilter"', '"00000"'], _
['"##bycontentfilter"', '"00000"'], _
['"##bycontentfilter_regex"', '"00000"'], _
['"##check"', '"00000"'], _
['"##color_active"', '"00000"'], _
['"##commoncombo"', '"00000"'], _
['"##commonqty"', '"00000"'], _
['"##end"', '"00000"'], _
['"##map"', '"00000"'], _
['"##name"', '"00000"'], _
['"##params"', '"00000"'], _
['"##rarecombo"', '"00000"'], _
['"##rareqty"', '"00000"'], _
['"##shape_active"', '"00000"'], _
['"##size"', '"00000"'], _
['"##size_active"', '"00000"'], _
['"##source"', '"00000"'], _
['"##start"', '"00000"'], _
['"##time"', '"00000"'], _
['"##type"', '"00000"'], _
['"##visible"', '"00000"'], _
['"##visible2"', '"00000"'], _
['"##x1"', '"00000"'], _
['"##x2"', '"00000"'], _
['"##y1"', '"00000"'], _
['"##y2"', '"00000"'], _
['"#%2d ~ %3.2f %% ~ %ls/%ls %ls ~ %d"', '"00000"'], _
['"$ Trade"', '"00000"'], _
['"% Alliance"', '"00000"'], _
['"%.0f %s"', '"00000"'], _
['"%.0f / %d"', '"00000"'], _
['"%.0f milliseconds"', '"00000"'], _
['"%.0f"', '"00000"'], _
['"%.1f %%"', '"00000"'], _
['"%.1f k"', '"00000"'], _
['"%.1f"', '"00000"'], _
['"%.2f k"', '"00000"'], _
['"%.2f m"', '"00000"'], _
['"%.2f"', '"00000"'], _
['"%.3f"', '"00000"'], _
['"%02d:%02d"', '"00000"'], _
['"%02d:%02d.%1d"', '"00000"'], _
['"%02u:%02u:%02u"', '"00000"'], _
['"%1ld:%02ld"', '"00000"'], _
['"%2.0f %s"', '"00000"'], _
['"%H:%M:%S"', '"00000"'], _
['"%S (%S) has just logged out."', '"00000"'], _
['"%X\n"', '"00000"'], _
['"%d %s ago"', '"00000"'], _
['"%d Soul Tormentors"', '"00000"'], _
['"%d foes in casting range"', '"00000"'], _
['"%d foes in compass range"', '"00000"'], _
['"%d foes in spirit range"', '"00000"'], _
['"%d. %S - %s"', '"00000"'], _
['"%d. %s - %S"', '"00000"'], _
['"%d:%02d %s"', '"00000"'], _
['"%d:%02d:%02d"', '"00000"'], _
['"%ls (%s)"', '"00000"'], _
['"%ls [%ls]"', '"00000"'], _
['"%lu %s"', '"00000"'], _
['"%lu %ss"', '"00000"'], _
['"%s %d"', '"00000"'], _
['"%s %s %d"', '"00000"'], _
['"%s - %s###header%d"', '"00000"'], _
['"%s [%d / %d]"', '"00000"'], _
['"%s [%s]###header%u"', '"00000"'], _
['"%s not found!"', '"00000"'], _
['"%s###build%d"', '"00000"'], _
['"%s###herobuild%d"', '"00000"'], _
['"%s%s%s%s"', '"00000"'], _
['"%s\\%s"', '"00000"'], _
['"%s\\*"', '"00000"'], _
['"%s_active"', '"00000"'], _
['"%s_color_message"', '"00000"'], _
['"%s_color_sender"', '"00000"'], _
['"%s_threshold"', '"00000"'], _
['"%s_visible"', '"00000"'], _
['"%u / %u"', '"00000"'], _
['"(Each in a separate line)"', '"00000"'], _
['"(Each in a separate line. Not case sensitive)"', '"00000"'], _
['"(Each line is a separate keyword. Not case sensitive.)"', '"00000"'], _
['"(Left-click on a color to edit it)"', '"00000"'], _
['"(Not implemented)"', '"00000"'], _
['"(Up to date)"', '"00000"'], _
['") && wcscmp(path, L"', '"00000"'], _
['") : "', '"00000"'], _
['"*Unknown item*"', '"00000"'], _
['", &i[0], 1.0f, 0, 255, "', '"00000"'], _
['", &i[1], 1.0f, 0, 255, "', '"00000"'], _
['", &i[2], 1.0f, 0, 255, "', '"00000"'], _
['", &i[3], 1.0f, 0, 255, "', '"00000"'], _
['", &marker.pos.x, 1.0f, 0.0f, 0.0f, "', '"00000"'], _
['", &marker.pos.y, 1.0f, 0.0f, 0.0f, "', '"00000"'], _
['", ..."', '"00000"'], _
['", argc > 1 ? argv[1] : L"', '"00000"'], _
['", guild "', '"00000"'], _
['"- %s"', '"00000"'], _
['"- CTRL+A or double-click to select all\n"', '"00000"'], _
['"- CTRL+Left/Right to word jump\n"', '"00000"'], _
['"- CTRL+X,CTRL+C,CTRL+V clipboard\n"', '"00000"'], _
['"- CTRL+Z,CTRL+Y undo/redo\n"', '"00000"'], _
['"- ESCAPE to revert\n"', '"00000"'], _
['"- Hold SHIFT or use mouse to select text\n"', '"00000"'], _
['"- You can apply arithmetic operators +,*,/ on numerical values. Use +- to subtract.\n"', '"00000"'], _
['"--:--"', '"00000"'], _
['".old"', '"00000"'], _
['".txt"', '"00000"'], _
['"/ Commands"', '"00000"'], _
['"/GUILD WARS/Templates/Skills/"', '"00000"'], _
['"/afk message"', '"00000"'], _
['"/flag 5 -2913.41 3004.78"', '"00000"'], _
['"/flag 5 clear"', '"00000"'], _
['"/flag 5"', '"00000"'], _
['"/flag all -2913.41 3004.78"', '"00000"'], _
['"/flag all"', '"00000"'], _
['"/flag clear"', '"00000"'], _
['"/flag"', '"00000"'], _
['"0x%X "', '"00000"'], _
['"0x%X"', '"00000"'], _
['"10 Bolts of Cloth"', '"00000"'], _
['"10 Bones"', '"00000"'], _
['"10 Chitin Fragments"', '"00000"'], _
['"10 Feathers"', '"00000"'], _
['"10 Granite Slabs"', '"00000"'], _
['"10 Iron Ingots"', '"00000"'], _
['"10 Piles of Glittering Dust"', '"00000"'], _
['"10 Plant Fibers"', '"00000"'], _
['"10 Scales"', '"00000"'], _
['"10 Tanned Hide Squares"', '"00000"'], _
['"10 Wood Planks"', '"00000"'], _
['"2.29"', '"00000"'], _
['"4...Itchy...Tasty..."', '"00000"'], _
['"9 Rings messages"', '"00000"'], _
['"<A Hero>"', '"00000"'], _
['"<None>"', '"00000"'], _
['"<a=1>%S</a> (%S) has just logged in.</c>"', '"00000"'], _
['"<a=1>%s</a>: <c=#f96677><quote>%s"', '"00000"'], _
['"<c=#00ccff>GWToolbox++</c>: %s"', '"00000"'], _
['"<name>"', '"00000"'], _
['"<not found>"', '"00000"'], _
['"<town> can be any of: doa, kamadan/kama, embark, vlox, gadds, urgoz, deep, gtob, fav1, fav2, fav3.\n"', '"00000"'], _
['"@ Guild"', '"00000"'], _
['"A common item drops for an ally"', '"00000"'], _
['"A common item drops for you"', '"00000"'], _
['"A name to help you remember what this is. Optional."', '"00000"'], _
['"A rare item drops for an ally"', '"00000"'], _
['"A rare item drops for you"', '"00000"'], _
['"A simple in-game text editor"', '"00000"'], _
['"A:%3.0f"', '"00000"'], _
['"AS modifier"', '"00000"'], _
['"AS of Weapon"', '"00000"'], _
['"Abaddon will feast on your eyes!"', '"00000"'], _
['"Accept quest reward"', '"00000"'], _
['"Acolyte Jin"', '"00000"'], _
['"Acolyte Sousuke"', '"00000"'], _
['"Action"', '"00000"'], _
['"Action###combo"', '"00000"'], _
['"ActionID"', '"00000"'], _
['"Activity update failed with error %d\n"', '"00000"'], _
['"Add Agent Custom Color"', '"00000"'], _
['"Add Build"', '"00000"'], _
['"Add Line"', '"00000"'], _
['"Add Marker"', '"00000"'], _
['"Add Teambuild"', '"00000"'], _
['"Add another player build row"', '"00000"'], _
['"Additional pings on the same agents will increase the duration of the existing ping, rather than create a new one."', '"00000"'], _
['"Addr"', '"00000"'], _
['"Advanced##target"', '"00000"'], _
['"Afk message must be under 80 characters. (Yours is %zu)"', '"00000"'], _
['"Afk message set to \"', '"00000"'], _
['"After this amount of time, each player recent damage (blue bar) will be reset"', '"00000"'], _
['"After using a pcon, toolbox will not use it again for this amount of time.\n"', '"00000"'], _
['"Agent Colors"', '"00000"'], _
['"Agent ID##player"', '"00000"'], _
['"Agent ID##target"', '"00000"'], _
['"Agent Sizes"', '"00000"'], _
['"Agent damaged modifier"', '"00000"'], _
['"Agent modifier"', '"00000"'], _
['"AgentRenderer Lock() error: %d\n"', '"00000"'], _
['"AgentRenderer initialize error: %d\n"', '"00000"'], _
['"Aggro range"', '"00000"'], _
['"Alcohol"', '"00000"'], _
['"Alerts"', '"00000"'], _
['"Alignment"', '"00000"'], _
['"Allegiance"', '"00000"'], _
['"Alliance"', '"00000"'], _
['"Allow mouse click-through in outposts"', '"00000"'], _
['"Allow mouse click-through"', '"00000"'], _
['"Allow window restore"', '"00000"'], _
['"Ally (NPC)"', '"00000"'], _
['"Ally (dead)"', '"00000"'], _
['"Ally (minion)"', '"00000"'], _
['"Ally (player)"', '"00000"'], _
['"Ally (spirit)"', '"00000"'], _
['"Alpha channel (0 - 255)\n0 is transparent, 255 is solid color"', '"00000"'], _
['"Alt + "', '"00000"'], _
['"Alt + Click on minimap to move"', '"00000"'], _
['"Altrumm Ruins"', '"00000"'], _
['"Amatz Basin"', '"00000"'], _
['"Amber Chunk"', '"00000"'], _
['"Ambiguous prefix because of %s"', '"00000"'], _
['"America"', '"00000"'], _
['"American District 1"', '"00000"'], _
['"American"', '"00000"'], _
['"Amnoon Oasis, The"', '"00000"'], _
['"An ally picks up a common item"', '"00000"'], _
['"An ally picks up a rare item"', '"00000"'], _
['"An alternative to the default compass"', '"00000"'], _
['"And messages matching regular expressions:"', '"00000"'], _
['"And this is where I met the Lich. He told me to burn things."', '"00000"'], _
['"Announcements"', '"00000"'], _
['"Anton"', '"00000"'], _
['"Applications"', '"00000"'], _
['"Arborstone"', '"00000"'], _
['"Are you sure?\nThis operation cannot be undone.\n\n"', '"00000"'], _
['"Are you sure?\nThis operation cannot be undone\n\n"', '"00000"'], _
['"Are you sure?\nThis will reset all agent colors to the default values.\nThis operation cannot be undone.\n\n"', '"00000"'], _
['"Are you the Keymaster?"', '"00000"'], _
['"Armor of Salvation"', '"00000"'], _
['"Armor of Salvation\nIron and Bones"', '"00000"'], _
['"As a boy I spent much time in these lands."', '"00000"'], _
['"Ascalon City"', '"00000"'], _
['"Ascalon"', '"00000"'], _
['"Ashford Abbey"', '"00000"'], _
['"Asia Chinese"', '"00000"'], _
['"Asia Japan"', '"00000"'], _
['"Asia Japanese"', '"00000"'], _
['"Asia Korea"', '"00000"'], _
['"Asian Korean"', '"00000"'], _
['"Aspenwood Gate (Kurzick)"', '"00000"'], _
['"Aspenwood Gate (Luxon)"', '"00000"'], _
['"Assassin"', '"00000"'], _
['"Astralarium, The"', '"00000"'], _
['"Attach to minimap"', '"00000"'], _
['"Attn"', '"00000"'], _
['"Augury Rock"', '"00000"'], _
['"Aurios Mines, The"', '"00000"'], _
['"Aurora Glade"', '"00000"'], _
['"Automatic message: \"', '"00000"'], _
['"Automatically change urls into build templates."', '"00000"'], _
['"Automatically manage gold"', '"00000"'], _
['"Automatically skip cinematics"', '"00000"'], _
['"B:%3.0f"', '"00000"'], _
['"BE GONE!"', '"00000"'], _
['"Background"', '"00000"'], _
['"Backspace"', '"00000"'], _
['"Bai Paasu Reach"', '"00000"'], _
['"Bars towards the left"', '"00000"'], _
['"Basalt Grotto"', '"00000"'], _
['"Battle Isles"', '"00000"'], _
['"Battle of Jahai"', '"00000"'], _
['"Beetletun"', '"00000"'], _
['"Beknur Harbor"', '"00000"'], _
['"Below, <xyz> denotes an argument, use an appropriate value without the quotes.\n"', '"00000"'], _
['"Bergen Hot Springs"', '"00000"'], _
['"Big Circle"', '"00000"'], _
['"Birthday Cupcake"', '"00000"'], _
['"Blacktide Den"', '"00000"'], _
['"Bloodstone Fen"', '"00000"'], _
['"Blue Rock Candy"', '"00000"'], _
['"Blue channel (0 - 255)"', '"00000"'], _
['"Bolt of Damask"', '"00000"'], _
['"Bolt of Linen"', '"00000"'], _
['"Bolt of Silk"', '"00000"'], _
['"Bond order is based on your build. Check this to flip them left <-> right"', '"00000"'], _
['"Bonds"', '"00000"'], _
['"Bone Palace"', '"00000"'], _
['"Boreal Station"', '"00000"'], _
['"Boreas Seabed"', '"00000"'], _
['"Borlis Pass"', '"00000"'], _
['"Boss Size"', '"00000"'], _
['"Bowl of Skalefin Soup"', '"00000"'], _
['"Brauer Academy"', '"00000"'], _
['"Breaker Hollow"', '"00000"'], _
['"Browser Back"', '"00000"'], _
['"Browser Favorites"', '"00000"'], _
['"Browser Forward"', '"00000"'], _
['"Browser Home"', '"00000"'], _
['"Browser Refresh"', '"00000"'], _
['"Browser Search"', '"00000"'], _
['"Browser Stop"', '"00000"'], _
['"Buffer size too small, file size is %d"', '"00000"'], _
['"Build Name"', '"00000"'], _
['"Build"', '"00000"'], _
['"BuildIndex"', '"00000"'], _
['"Builds"', '"00000"'], _
['"Burning Forest"', '"00000"'], _
['"Button Text Align"', '"00000"'], _
['"ButtonTextAlignX"', '"00000"'], _
['"ButtonTextAlignY"', '"00000"'], _
['"Buttons in the main window."', '"00000"'], _
['"Buy##armor"', '"00000"'], _
['"Buy##common"', '"00000"'], _
['"Buy##essence"', '"00000"'], _
['"Buy##grail"', '"00000"'], _
['"Buy##pstone"', '"00000"'], _
['"Buy##rare"', '"00000"'], _
['"Buy##resscroll"', '"00000"'], _
['"Bye!"', '"00000"'], _
['"CONOUT$"', '"00000"'], _
['"CTRL+Click or Double Click on a slider or drag box to input text."', '"00000"'], _
['"CTRL+Mouse Wheel to zoom window contents."', '"00000"'], _
['"Camera speed is now %f"', '"00000"'], _
['"Camera speed"', '"00000"'], _
['"Camp Hojanu"', '"00000"'], _
['"Camp Rankor"', '"00000"'], _
['"Cancel the current queue of operations"', '"00000"'], _
['"Cancel"', '"00000"'], _
['"Cancelled"', '"00000"'], _
['"Candy Apple"', '"00000"'], _
['"Candy Corn"', '"00000"'], _
['"Cannot find %s"', '"00000"'], _
['"Cannot find %s, please refill or disable"', '"00000"'], _
['"Cannot load font!"', '"00000"'], _
['"Caps Lock"', '"00000"'], _
['"Cast range"', '"00000"'], _
['"Cavalon"', '"00000"'], _
['"Central Transfer Chamber"', '"00000"'], _
['"Chahbek Village"', '"00000"'], _
['"Chamber"', '"00000"'], _
['"Changes:"', '"00000"'], _
['"Channel"', '"00000"'], _
['"Chantry of Secrets"', '"00000"'], _
['"Charr Homelands"', '"00000"'], _
['"Chat Colors"', '"00000"'], _
['"Chat Command"', '"00000"'], _
['"Chat Commands"', '"00000"'], _
['"Chat Filter"', '"00000"'], _
['"Check and ask before updating"', '"00000"'], _
['"Check and automatically update"', '"00000"'], _
['"Check and display a message"', '"00000"'], _
['"Checkboxes in the Info window."', '"00000"'], _
['"Checkboxes on the right of each setting header below."', '"00000"'], _
['"Choose Hero"', '"00000"'], _
['"Circle"', '"00000"'], _
['"City speedboost"', '"00000"'], _
['"City"', '"00000"'], _
['"Clear"', '"00000"'], _
['"Click and drag on any empty space to move a window."', '"00000"'], _
['"Click and drag on the lower right corner to resize a window."', '"00000"'], _
['"Click to cancel bond"', '"00000"'], _
['"Click to cast bond"', '"00000"'], _
['"Click to change hotkey"', '"00000"'], _
['"Click to load builds to heroes and player"', '"00000"'], _
['"Click to reconnect"', '"00000"'], _
['"Click to send teambuild to chat"', '"00000"'], _
['"Clicker is %s"', '"00000"'], _
['"Clicker"', '"00000"'], _
['"Clicking on template that has a URL as name will open that URL in your browser"', '"00000"'], _
['"Clock"', '"00000"'], _
['"Close on travel"', '"00000"'], _
['"Close other windows when opening a new one"', '"00000"'], _
['"Close this window"', '"00000"'], _
['"Close"', '"00000"'], _
['"Closed - %d"', '"00000"'], _
['"Closing log/console, bye!\n"', '"00000"'], _
['"Codex Arena"', '"00000"'], _
['"Coin Drop"', '"00000"'], _
['"Coin dropper is %s"', '"00000"'], _
['"Color"', '"00000"'], _
['"Color:"', '"00000"'], _
['"Color:\n0x%02X%02X%02X%02X"', '"00000"'], _
['"Colors"', '"00000"'], _
['"Common 4"', '"00000"'], _
['"Compass range"', '"00000"'], _
['"Connect"', '"00000"'], _
['"Connected (not resigned)"', '"00000"'], _
['"Connected"', '"00000"'], _
['"Connecting..."', '"00000"'], _
['"Consulate Docks"', '"00000"'], _
['"Control + "', '"00000"'], _
['"Control"', '"00000"'], _
['"Control-break"', '"00000"'], _
['"Copperhammer Mines"', '"00000"'], _
['"CrSel"', '"00000"'], _
['"Craft fow armor"', '"00000"'], _
['"Create Hotkey"', '"00000"'], _
['"Create Hotkey..."', '"00000"'], _
['"CreateMutexW failed (%lu)"', '"00000"'], _
['"Creating Modules\n"', '"00000"'], _
['"Creating Toolbox\n"', '"00000"'], _
['"Creating toolbox thread\n"', '"00000"'], _
['"Cross over, children. All are welcome. All welcome. Go into the light. There is peace and serenity in the light."', '"00000"'], _
['"Crystal Desert"', '"00000"'], _
['"Ctrl+Click to print target health"', '"00000"'], _
['"Ctrl+Click to print time"', '"00000"'], _
['"Current District"', '"00000"'], _
['"Current drunk level: %d"', '"00000"'], _
['"Cursor Fix not installed, message devs about this!"', '"00000"'], _
['"Custom Agents"', '"00000"'], _
['"Custom Markers"', '"00000"'], _
['"Custom"', '"00000"'], _
['"DISCORD_INSTANCE_ID"', '"00000"'], _
['"Dajkah Inlet"', '"00000"'], _
['"Damage"', '"00000"'], _
['"Dasha Vestibule"', '"00000"'], _
['"Decimal"', '"00000"'], _
['"Decrease the value if you have good ping and you die a lot."', '"00000"'], _
['"Deep"', '"00000"'], _
['"Deep, The"', '"00000"'], _
['"Default Size"', '"00000"'], _
['"Defend"', '"00000"'], _
['"Deldrimor Steel Ingot"', '"00000"'], _
['"Deldrimor War Camp"', '"00000"'], _
['"Delete Color?"', '"00000"'], _
['"Delete Hotkey?"', '"00000"'], _
['"Delete Teambuild?"', '"00000"'], _
['"Delete build"', '"00000"'], _
['"Delete the color"', '"00000"'], _
['"Delete the hotkey"', '"00000"'], _
['"Delete the teambuild"', '"00000"'], _
['"Delete"', '"00000"'], _
['"Demon Assassin"', '"00000"'], _
['"Depletion: %d"', '"00000"'], _
['"Dervish"', '"00000"'], _
['"Destroying API\n"', '"00000"'], _
['"Dev Region"', '"00000"'], _
['"Dhuum"', '"00000"'], _
['"Dialog #%d"', '"00000"'], _
['"Dialog %s"', '"00000"'], _
['"Dialog ID"', '"00000"'], _
['"Dialog Name"', '"00000"'], _
['"Dialog"', '"00000"'], _
['"DialogID"', '"00000"'], _
['"DialogName"', '"00000"'], _
['"Dialogs"', '"00000"'], _
['"Diamond"', '"00000"'], _
['"Disable Gold/Green items confirmation"', '"00000"'], _
['"Disable the confirmation request when\n"', '"00000"'], _
['"Disable when not found"', '"00000"'], _
['"Disabled###pconstoggle"', '"00000"'], _
['"Disconnect"', '"00000"'], _
['"Discord Integration"', '"00000"'], _
['"Discord connection already owned by an other GWToolboxpp"', '"00000"'], _
['"DiscordCreate"', '"00000"'], _
['"Displays the distance to your target.\n1010 = Earshot / Aggro\n1248 = Cast range\n2500 = Spirit range\n5000 = Radar range"', '"00000"'], _
['"Displays the health of the target.\nMax health is only computed and refreshed when you directly damage or heal your target"', '"00000"'], _
['"Displays the system time (hour : minutes)"', '"00000"'], _
['"Distance"', '"00000"'], _
['"Divide"', '"00000"'], _
['"Divinity Coast"', '"00000"'], _
['"Do not check for updates"', '"00000"'], _
['"Do you like my fish balloon? Can you hear it singing to you...?"', '"00000"'], _
['"Do you want to update?"', '"00000"'], _
['"DoA - City"', '"00000"'], _
['"DoA - Foundry 1: Foundry Of Failed Creations"', '"00000"'], _
['"DoA - Foundry 2: Foundry Breakout"', '"00000"'], _
['"DoA - Gloom 1: Deathbringer Company"', '"00000"'], _
['"DoA - Gloom 2: The Rifts Between Us"', '"00000"'], _
['"DoA - Gloom 3: To The Rescue"', '"00000"'], _
['"DoA - Veil 1: Breaching Stygian Veil"', '"00000"'], _
['"DoA - Veil 2: Brood Wars"', '"00000"'], _
['"Docks -> Kaineng @ Mhenlo"', '"00000"'], _
['"Docks -> LA Gate @ Mhenlo"', '"00000"'], _
['"Doomlore Shrine"', '"00000"'], _
['"Double-click on the title bar to collapse a window."', '"00000"'], _
['"Down"', '"00000"'], _
['"Downloading %s\n"', '"00000"'], _
['"Downloading update..."', '"00000"'], _
['"Drake Kabob"', '"00000"'], _
['"Drawings"', '"00000"'], _
['"Drop Gold Coin"', '"00000"'], _
['"Drop or Use Buff"', '"00000"'], _
['"Drop/Use %s"', '"00000"'], _
['"DropUseBuff"', '"00000"'], _
['"Drops"', '"00000"'], _
['"Dunes of Despair"', '"00000"'], _
['"Dunkoro"', '"00000"'], _
['"Durheim Archives"', '"00000"'], _
['"Dzagonur Bastion"', '"00000"'], _
['"Each agent has this value removed on the border and added at the center\nZero makes agents have solid color, while a high number makes them appear more shaded."', '"00000"'], _
['"Each hostile agent has this value subtracted from it when under 90% HP."', '"00000"'], _
['"Each symbol has this value removed on the border and added at the center\nZero makes them have solid color, while a high number makes them appear more shaded."', '"00000"'], _
['"Earning skill points"', '"00000"'], _
['"Edit"', '"00000"'], _
['"Effects"', '"00000"'], _
['"Effects##player"', '"00000"'], _
['"Elementalist"', '"00000"'], _
['"Elona Reach"', '"00000"'], _
['"Elonian Leather Square"', '"00000"'], _
['"Embark Beach"', '"00000"'], _
['"Embark"', '"00000"'], _
['"Ember Light Camp"', '"00000"'], _
['"Enable the following features:"', '"00000"'], _
['"Enable/Disable button"', '"00000"'], _
['"Enabled###pconstoggle"', '"00000"'], _
['"Enabled-Background"', '"00000"'], _
['"Enabling or disabling pcons will also Tick or Untick in party list"', '"00000"'], _
['"Enemy count"', '"00000"'], _
['"English"', '"00000"'], _
['"Enter Challenge"', '"00000"'], _
['"Enter DoA, FoW, or UW to begin"', '"00000"'], _
['"Enter"', '"00000"'], _
['"Erase EOF"', '"00000"'], _
['"Eredon Terrace"', '"00000"'], _
['"Error checking for updates"', '"00000"'], _
['"Error creating the dump file\n"', '"00000"'], _
['"Error downloading %s\n"', '"00000"'], _
['"Error setting up CustomRenderer vertex buffer: %d\n"', '"00000"'], _
['"Error setting up PingsLinesRenderer vertex buffer: %d\n"', '"00000"'], _
['"Error writing file %s - Error is %lu"', '"00000"'], _
['"Error"', '"00000"'], _
['"Escort"', '"00000"'], _
['"Essence of Celerity"', '"00000"'], _
['"Essence of Celerity\nFeathers and Dust"', '"00000"'], _
['"Eternal Grove, The"', '"00000"'], _
['"Europe English"', '"00000"'], _
['"Europe French"', '"00000"'], _
['"Europe German"', '"00000"'], _
['"Europe Italian"', '"00000"'], _
['"Europe Polish"', '"00000"'], _
['"Europe Russian"', '"00000"'], _
['"Europe Spanish"', '"00000"'], _
['"Europe"', '"00000"'], _
['"ExSel"', '"00000"'], _
['"Execute a single task such as opening chests\nor reapplying lightbringer title"', '"00000"'], _
['"Execute the hotkey now"', '"00000"'], _
['"Execute"', '"00000"'], _
['"Execute..."', '"00000"'], _
['"Exhaustion: %d"', '"00000"'], _
['"Explorable"', '"00000"'], _
['"ExtraType"', '"00000"'], _
['"Eye of the North"', '"00000"'], _
['"Faction mission outpost"', '"00000"'], _
['"Failed to create discord connection"', '"00000"'], _
['"Failed to find address for DiscordCreate"', '"00000"'], _
['"Far Shiverpeaks"', '"00000"'], _
['"Fav%d"', '"00000"'], _
['"Favor of the Gods announcements"', '"00000"'], _
['"Favorites"', '"00000"'], _
['"FillCircle"', '"00000"'], _
['"Fire Jet: %d"', '"00000"'], _
['"Fire Spout: %d"', '"00000"'], _
['"Fire Trap: %d"', '"00000"'], _
['"First item in inventory"', '"00000"'], _
['"Fissure of Woe"', '"00000"'], _
['"Fix height when moving forward"', '"00000"'], _
['"Flash Guild Wars taskbar icon when:"', '"00000"'], _
['"Flip bond order (left/right)"', '"00000"'], _
['"FoW - Army Of Darkness"', '"00000"'], _
['"FoW - Defend"', '"00000"'], _
['"FoW - Forgemaster"', '"00000"'], _
['"FoW - Griffons"', '"00000"'], _
['"FoW - Hunt"', '"00000"'], _
['"FoW - Khobay"', '"00000"'], _
['"FoW - Restore"', '"00000"'], _
['"FoW - Slaves"', '"00000"'], _
['"FoW - Toc"', '"00000"'], _
['"FoW - Tos"', '"00000"'], _
['"FoW - WailingLord"', '"00000"'], _
['"FontGlobalScale"', '"00000"'], _
['"Forge"', '"00000"'], _
['"Fort Aspenwood (Kurzick)"', '"00000"'], _
['"Fort Aspenwood (Luxon)"', '"00000"'], _
['"Fort Ranik"', '"00000"'], _
['"Foundry Reward"', '"00000"'], _
['"Foundry"', '"00000"'], _
['"Four Horseman"', '"00000"'], _
['"Frame Padding"', '"00000"'], _
['"Frame Rounding"', '"00000"'], _
['"FramePaddingX"', '"00000"'], _
['"FramePaddingY"', '"00000"'], _
['"FrameRounding"', '"00000"'], _
['"French"', '"00000"'], _
['"Frontier Gate"', '"00000"'], _
['"Frost Gate, The"', '"00000"'], _
['"Full Conset Price: %g k"', '"00000"'], _
['"Full Conset Price: (Material not available)"', '"00000"'], _
['"Full Conset Price: -"', '"00000"'], _
['"Functionality:"', '"00000"'], _
['"Fur Square"', '"00000"'], _
['"G:%3.0f"', '"00000"'], _
['"GWTB++ Debug Console"', '"00000"'], _
['"GWToolbox crashed, oops\n\n"', '"00000"'], _
['"GWToolbox++ - Clientside Error Detected"', '"00000"'], _
['"GWToolbox++ API Error"', '"00000"'], _
['"GWToolbox++ Crash!"', '"00000"'], _
['"GWToolbox++ version %s by Has and KAOS"', '"00000"'], _
['"GWToolbox++ version %s is available! You have %s"', '"00000"'], _
['"GWToolbox++ version %s is available! You have %s%s"', '"00000"'], _
['"GWToolbox++ version %s is available! You have %s%s."', '"00000"'], _
['"GWToolboxpp"', '"00000"'], _
['"GWToolboxpp-Mutex-DiscordIntegration"', '"00000"'], _
['"Game Settings"', '"00000"'], _
['"Gate of Anguish"', '"00000"'], _
['"Gate of Desolation"', '"00000"'], _
['"Gate of Fear"', '"00000"'], _
['"Gate of Madness"', '"00000"'], _
['"Gate of Pain"', '"00000"'], _
['"Gate of Secrets"', '"00000"'], _
['"Gate of Torment"', '"00000"'], _
['"Gate of the Nightfallen Lands"', '"00000"'], _
['"Gates of Kryta"', '"00000"'], _
['"General Interface"', '"00000"'], _
['"General Morgahn"', '"00000"'], _
['"General"', '"00000"'], _
['"General:"', '"00000"'], _
['"German"', '"00000"'], _
['"Get away from my baby!"', '"00000"'], _
['"GetClipCursor"', '"00000"'], _
['"Glob of Ectoplasm"', '"00000"'], _
['"Global Alpha"', '"00000"'], _
['"Global Font Scale"', '"00000"'], _
['"GlobalAlpha"', '"00000"'], _
['"Gloom"', '"00000"'], _
['"Go, banana!"', '"00000"'], _
['"Golden Egg"', '"00000"'], _
['"Goren"', '"00000"'], _
['"Grab MinSize"', '"00000"'], _
['"Grab Rounding"', '"00000"'], _
['"GrabMinSize"', '"00000"'], _
['"GrabRounding"', '"00000"'], _
['"Grail of Might"', '"00000"'], _
['"Grail of Might\nIron and Dust"', '"00000"'], _
['"Grand Court of Sebelkeh"', '"00000"'], _
['"Granite Citadel, The"', '"00000"'], _
['"Great Northern Wall, The"', '"00000"'], _
['"Great Temple of Balthazar"', '"00000"'], _
['"Green Rock Candy"', '"00000"'], _
['"Green channel (0 - 255)"', '"00000"'], _
['"Grendich Courthouse"', '"00000"'], _
['"Griffons"', '"00000"'], _
['"Guild"', '"00000"'], _
['"Gwen"', '"00000"'], _
['"Gyala Hatchery"', '"00000"'], _
['"H#%d"', '"00000"'], _
['"Hall of Heroes winners"', '"00000"'], _
['"Hard Mode"', '"00000"'], _
['"Harvest Temple"', '"00000"'], _
['"Hayda"', '"00000"'], _
['"Health"', '"00000"'], _
['"Height of each row, leave 0 for default"', '"00000"'], _
['"Height"', '"00000"'], _
['"Hello %ls!"', '"00000"'], _
['"Help"', '"00000"'], _
['"Henge of Denravi"', '"00000"'], _
['"Hero Build Name"', '"00000"'], _
['"Hero Builds"', '"00000"'], _
['"Hero Controls"', '"00000"'], _
['"Hero flagging"', '"00000"'], _
['"HeroTeamBuild"', '"00000"'], _
['"Hide Spiritual Possession and Lucky Aura"', '"00000"'], _
['"Hide any messages containing:"', '"00000"'], _
['"Hide any messages from: "', '"00000"'], _
['"Hide in-game info when appearing offline"', '"00000"'], _
['"Hide the following messages:"', '"00000"'], _
['"Hide"', '"00000"'], _
['"His blood has returned me to my mortal body."', '"00000"'], _
['"HoS range"', '"00000"'], _
['"Holy Veil"', '"00000"'], _
['"Home"', '"00000"'], _
['"Honur Hill"', '"00000"'], _
['"Hooks Enabled!\n"', '"00000"'], _
['"Hostile (>90%%)"', '"00000"'], _
['"Hostile (dead)"', '"00000"'], _
['"Hotkey: %s"', '"00000"'], _
['"Hotkeys"', '"00000"'], _
['"House zu Heltzer"', '"00000"'], _
['"Human sacrifice. Dogs and cats living together. Mass hysteria!"', '"00000"'], _
['"I have returned!"', '"00000"'], _
['"I see dead people."', '"00000"'], _
['"ID: 0x%X"', '"00000"'], _
['"IME Accept"', '"00000"'], _
['"IME Convert"', '"00000"'], _
['"IME Final"', '"00000"'], _
['"IME Hanja/Kanji"', '"00000"'], _
['"IME Junja"', '"00000"'], _
['"IME Mode change"', '"00000"'], _
['"IME Nonconvert"', '"00000"'], _
['"IME Process"', '"00000"'], _
['"Ice Caves of Sorrow"', '"00000"'], _
['"Ice Jet: %d"', '"00000"'], _
['"Ice Spout: %d"', '"00000"'], _
['"Ice Tooth Cave"', '"00000"'], _
['"If this custom agent is active"', '"00000"'], _
['"If unchecked, the default color will be used"', '"00000"'], _
['"If unchecked, the default shape will be used"', '"00000"'], _
['"If unchecked, the default size will be used"', '"00000"'], _
['"If unchecked, they will expand to the right"', '"00000"'], _
['"Imperial Sanctum"', '"00000"'], _
['"Important:\n"', '"00000"'], _
['"In Explorable"', '"00000"'], _
['"In Guild Hall"', '"00000"'], _
['"Indent Spacing"', '"00000"'], _
['"IndentSpacing"', '"00000"'], _
['"Info"', '"00000"'], _
['"Initialize Failed at finding all addresses, contact Developers about this."', '"00000"'], _
['"Initializing API\n"', '"00000"'], _
['"Installed chat hooks\n"', '"00000"'], _
['"Installed dx hooks\n"', '"00000"'], _
['"Installed input event handler, oldwndproc = 0x%X\n"', '"00000"'], _
['"Installing Cursor Fix\n"', '"00000"'], _
['"Installing dx hooks\n"', '"00000"'], _
['"Interface:"', '"00000"'], _
['"International %d"', '"00000"'], _
['"International"', '"00000"'], _
['"Invalid argument."', '"00000"'], _
['"Invalid hero number"', '"00000"'], _
['"Iron Mines of Moladune"', '"00000"'], _
['"Istan"', '"00000"'], _
['"It is needed to prevent toolbox from using a pcon twice, before it activates.\n"', '"00000"'], _
['"It will automaticly withdraw and deposit gold while buying materials"', '"00000"'], _
['"Italian"', '"00000"'], _
['"Item #%d not found!"', '"00000"'], _
['"Item ID"', '"00000"'], _
['"Item InnerSpacing"', '"00000"'], _
['"Item Name"', '"00000"'], _
['"Item Size"', '"00000"'], _
['"Item Spacing"', '"00000"'], _
['"Item"', '"00000"'], _
['"ItemID"', '"00000"'], _
['"ItemId"', '"00000"'], _
['"ItemInnerSpacingX"', '"00000"'], _
['"ItemInnerSpacingY"', '"00000"'], _
['"ItemName"', '"00000"'], _
['"ItemSpacingX"', '"00000"'], _
['"ItemSpacingY"', '"00000"'], _
['"Items per row"', '"00000"'], _
['"Jade Flats (Kurzick)"', '"00000"'], _
['"Jade Flats (Luxon)"', '"00000"'], _
['"Jade Quarry (Kurzick), The"', '"00000"'], _
['"Jade Quarry (Luxon), The"', '"00000"'], _
['"Jadeite Shard"', '"00000"'], _
['"Jokanur Diggings"', '"00000"'], _
['"Jora"', '"00000"'], _
['"Just used the last %s"', '"00000"'], _
['"Kahmu"', '"00000"'], _
['"Kaineng Center"', '"00000"'], _
['"Kaineng"', '"00000"'], _
['"Kama -> Docks @ Hahnna"', '"00000"'], _
['"Kamadan"', '"00000"'], _
['"Kamadan, Jewel of Istan"', '"00000"'], _
['"Keep away. The sow is mine."', '"00000"'], _
['"Keiran Thackeray"', '"00000"'], _
['"Khobay"', '"00000"'], _
['"Klaatu...barada...necktie?"', '"00000"'], _
['"Kodash Bazaar, The"', '"00000"'], _
['"Kodlonu Hamlet"', '"00000"'], _
['"Kodonur Crossroads"', '"00000"'], _
['"Koss"', '"00000"'], _
['"Kourna"', '"00000"'], _
['"Kryta"', '"00000"'], _
['"Kurzick"', '"00000"'], _
['"LA Gate -> LA @ Neiro"', '"00000"'], _
['"Lair of the Forgotten"', '"00000"'], _
['"Last Dialog"', '"00000"'], _
['"Later"', '"00000"'], _
['"Launch Application 1"', '"00000"'], _
['"Launch Application 2"', '"00000"'], _
['"Leather Square"', '"00000"'], _
['"Left Alt"', '"00000"'], _
['"Left Control"', '"00000"'], _
['"Left Shift"', '"00000"'], _
['"Left Windows"', '"00000"'], _
['"Left mouse"', '"00000"'], _
['"Left"', '"00000"'], _
['"Level = %d, tint = %d\n"', '"00000"'], _
['"Level"', '"00000"'], _
['"Leviathan Pits"', '"00000"'], _
['"Line X 1"', '"00000"'], _
['"Line X 2"', '"00000"'], _
['"Line Y 1"', '"00000"'], _
['"Line Y 2"', '"00000"'], _
['"Livia"', '"00000"'], _
['"Load Build on Hero"', '"00000"'], _
['"Load Build on Player"', '"00000"'], _
['"Load Hero Team Build"', '"00000"'], _
['"Load Now"', '"00000"'], _
['"Load a team hero build from the Hero Build Panel"', '"00000"'], _
['"Load build on your character"', '"00000"'], _
['"Load"', '"00000"'], _
['"Loading\0\0\0"', '"00000"'], _
['"Local"', '"00000"'], _
['"Lock Position"', '"00000"'], _
['"Lock Size"', '"00000"'], _
['"Log and dump files have been created in the GWToolbox data folder.\n"', '"00000"'], _
['"LoginNumber"', '"00000"'], _
['"Logs in"', '"00000"'], _
['"Logs out"', '"00000"'], _
['"Low on %s, please refill or disable"', '"00000"'], _
['"Lump of Charcoal"', '"00000"'], _
['"Lunar Fortunes"', '"00000"'], _
['"Lunar fortunes messages"', '"00000"'], _
['"Lunars and Alcohol"', '"00000"'], _
['"Lunars delay"', '"00000"'], _
['"Lutgardis Conservatory"', '"00000"'], _
['"Luxon"', '"00000"'], _
['"Maatu Keep"', '"00000"'], _
['"Maguuma Stade"', '"00000"'], _
['"Maguuma"', '"00000"'], _
['"Map ID is unique for each area"', '"00000"'], _
['"Map ID"', '"00000"'], _
['"Map Rotation"', '"00000"'], _
['"Map Type"', '"00000"'], _
['"Map file is unique for each pathing map (e.g. used by minimap).\nMany different maps use the same map file"', '"00000"'], _
['"Map file"', '"00000"'], _
['"Map rotation on (e.g. Compass), or off (e.g. Mission Map)."', '"00000"'], _
['"Map-"', '"00000"'], _
['"Margrid The Sly"', '"00000"'], _
['"Marker X Position"', '"00000"'], _
['"Marker Y Position"', '"00000"'], _
['"Marker: (%.0f, %.0f)"', '"00000"'], _
['"Marketplace, The"', '"00000"'], _
['"Master Of Whispers"', '"00000"'], _
['"Materials"', '"00000"'], _
['"Max range end"', '"00000"'], _
['"Max range start"', '"00000"'], _
['"Media Select"', '"00000"'], _
['"Media Stop"', '"00000"'], _
['"Melonni"', '"00000"'], _
['"Menzies"', '"00000"'], _
['"Mercenary Hero 1"', '"00000"'], _
['"Mercenary Hero 2"', '"00000"'], _
['"Mercenary Hero 3"', '"00000"'], _
['"Mercenary Hero 4"', '"00000"'], _
['"Mercenary Hero 5"', '"00000"'], _
['"Mercenary Hero 6"', '"00000"'], _
['"Mercenary Hero 7"', '"00000"'], _
['"Mercenary Hero 8"', '"00000"'], _
['"Mesmer"', '"00000"'], _
['"Message Color:"', '"00000"'], _
['"Message"', '"00000"'], _
['"Middle mouse"', '"00000"'], _
['"Mihanu Township"', '"00000"'], _
['"Miku"', '"00000"'], _
['"Minimap"', '"00000"'], _
['"Minion Size"', '"00000"'], _
['"Mnts"', '"00000"'], _
['"Moddok Crevice"', '"00000"'], _
['"Mode"', '"00000"'], _
['"Model ID is unique for each kind of agent.\nIt is static and shared by the same agents.\nWhen targeting players, this is Player ID instead, unique for each player in the instance.\nFor the purpose of targeting hotkeys and commands, use this value"', '"00000"'], _
['"Model ID"', '"00000"'], _
['"Model ID##target"', '"00000"'], _
['"ModelID"', '"00000"'], _
['"ModelState"', '"00000"'], _
['"Monk"', '"00000"'], _
['"Monstrous Claw"', '"00000"'], _
['"Monstrous Eye"', '"00000"'], _
['"Monstrous Fang"', '"00000"'], _
['"Mountains"', '"00000"'], _
['"Mouse Wheel to scroll."', '"00000"'], _
['"Mouth of Torment, The"', '"00000"'], _
['"Move Down"', '"00000"'], _
['"Move Up"', '"00000"'], _
['"Move items from/to storage with Control+Click"', '"00000"'], _
['"Move the color down in the list"', '"00000"'], _
['"Move the color up in the list"', '"00000"'], _
['"Move the hotkey down in the list"', '"00000"'], _
['"Move the hotkey up in the list"', '"00000"'], _
['"Move the teambuild down in the list"', '"00000"'], _
['"Move the teambuild up in the list"', '"00000"'], _
['"Move to %s"', '"00000"'], _
['"Move to (%.0f, %.0f)"', '"00000"'], _
['"Move to a specific (x,y) coordinate"', '"00000"'], _
['"Move to"', '"00000"'], _
['"Move"', '"00000"'], _
['"Moving to %s"', '"00000"'], _
['"Moving to (%.0f, %.0f)"', '"00000"'], _
['"Multiply"', '"00000"'], _
['"Nahpui Quarter"', '"00000"'], _
['"Name"', '"00000"'], _
['"NameProperties"', '"00000"'], _
['"Necromancer"', '"00000"'], _
['"Neutral"', '"00000"'], _
['"Next Track"', '"00000"'], _
['"Nightfall mission outpost"', '"00000"'], _
['"No Hero"', '"00000"'], _
['"No Profession"', '"00000"'], _
['"No one can stop me, let alone you puny mortals!"', '"00000"'], _
['"No target selected!"', '"00000"'], _
['"Nolani Academy"', '"00000"'], _
['"Noname"', '"00000"'], _
['"None"', '"00000"'], _
['"Norgu"', '"00000"'], _
['"Normal Mode"', '"00000"'], _
['"North Marker"', '"00000"'], _
['"Not connected"', '"00000"'], _
['"Note: only visible in Hard Mode explorable areas."', '"00000"'], _
['"Note: only visible in explorable areas."', '"00000"'], _
['"Note: the names of the widgets without a visible title bar are the same as in the setting headers below."', '"00000"'], _
['"Notepad"', '"00000"'], _
['"Num Lock"', '"00000"'], _
['"Number of favorites"', '"00000"'], _
['"Numpad 0"', '"00000"'], _
['"Numpad 1"', '"00000"'], _
['"Numpad 2"', '"00000"'], _
['"Numpad 3"', '"00000"'], _
['"Numpad 4"', '"00000"'], _
['"Numpad 5"', '"00000"'], _
['"Numpad 6"', '"00000"'], _
['"Numpad 7"', '"00000"'], _
['"Numpad 8"', '"00000"'], _
['"Numpad 9"', '"00000"'], _
['"Nundu Bay"', '"00000"'], _
['"Objective Timer"', '"00000"'], _
['"Obsidian Shard"', '"00000"'], _
['"Oem 1"', '"00000"'], _
['"Oem 10"', '"00000"'], _
['"Oem 2"', '"00000"'], _
['"Oem 3"', '"00000"'], _
['"Oem 4"', '"00000"'], _
['"Oem 5"', '"00000"'], _
['"Oem 6"', '"00000"'], _
['"Oem 7"', '"00000"'], _
['"Oem 8"', '"00000"'], _
['"Ogden"', '"00000"'], _
['"Olafstead"', '"00000"'], _
['"Olias"', '"00000"'], _
['"Only affects windows (with a title bar), not widgets"', '"00000"'], _
['"Only in Domain of Anguish, within 1400 range"', '"00000"'], _
['"Only show messages containing:"', '"00000"'], _
['"Only show non learned skills when using a tome"', '"00000"'], _
['"Only triggers when Guild Wars is not the active window"', '"00000"'], _
['"Onyx Gemstone"', '"00000"'], _
['"Open - %d"', '"00000"'], _
['"Open GWToolbox++ Website"', '"00000"'], _
['"Open Locked Chest"', '"00000"'], _
['"Open Settings Folder"', '"00000"'], _
['"Open Xunlai Chest"', '"00000"'], _
['"Open it by typing running %LOCALAPPDATA% and looking for GWToolboxpp folder\n"', '"00000"'], _
['"Open web links from templates"', '"00000"'], _
['"Opening and closing windows"', '"00000"'], _
['"Opening ini file\n"', '"00000"'], _
['"Others"', '"00000"'], _
['"Outpost\0\0\0"', '"00000"'], _
['"Owner"', '"00000"'], _
['"P081: agent_id %d, unk1 %d, unk2 "', '"00000"'], _
['"P081: id %d, name "', '"00000"'], _
['"P082: id %d, type %d\n"', '"00000"'], _
['"P085: id %d, type %d\n"', '"00000"'], _
['"Packet"', '"00000"'], _
['"Page Down"', '"00000"'], _
['"Page Up"', '"00000"'], _
['"Pahnai Salad"', '"00000"'], _
['"Paragon"', '"00000"'], _
['"Pause"', '"00000"'], _
['"Pcon Size"', '"00000"'], _
['"Pcons %s"', '"00000"'], _
['"Pcons delay"', '"00000"'], _
['"Pcons"', '"00000"'], _
['"Piken Square"', '"00000"'], _
['"Ping Build"', '"00000"'], _
['"Ping a build from the Build Panel"', '"00000"'], _
['"PingBuild"', '"00000"'], _
['"Pings and drawings"', '"00000"'], _
['"Pings"', '"00000"'], _
['"PingsLinesRenderer Lock() error: %d\n"', '"00000"'], _
['"Pits"', '"00000"'], _
['"Planes"', '"00000"'], _
['"Play"', '"00000"'], _
['"Play/Pause"', '"00000"'], _
['"Player (alive)"', '"00000"'], _
['"Player (dead)"', '"00000"'], _
['"Player ID is unique for each human player in the instance."', '"00000"'], _
['"Player ID##player"', '"00000"'], _
['"Player Size"', '"00000"'], _
['"Player"', '"00000"'], _
['"PlayerNumber"', '"00000"'], _
['"Please provide an integer or hex argument"', '"00000"'], _
['"Please provide command in format /flag [hero number] [x] [y]"', '"00000"'], _
['"Please provide command in format /flag all [x] [y]"', '"00000"'], _
['"Please send the files to the GWToolbox++ developers.\n"', '"00000"'], _
['"Pogahn Passage"', '"00000"'], _
['"Poison Jet: %d"', '"00000"'], _
['"Poison Spout: %d"', '"00000"'], _
['"Poison Trap: %d"', '"00000"'], _
['"Polish"', '"00000"'], _
['"Pools"', '"00000"'], _
['"Port Sledge"', '"00000"'], _
['"Position"', '"00000"'], _
['"Powered by https://kamadan.decltype.org"', '"00000"'], _
['"Powerstone of Courage\nGranite and Dust"', '"00000"'], _
['"Presearing"', '"00000"'], _
['"Press key"', '"00000"'], _
['"Prev Track"', '"00000"'], _
['"Price Check##armor"', '"00000"'], _
['"Price Check##essence"', '"00000"'], _
['"Price Check##grail"', '"00000"'], _
['"Price Check##pstone"', '"00000"'], _
['"Price Check##resscroll"', '"00000"'], _
['"Price:  -"', '"00000"'], _
['"Price: %g k"', '"00000"'], _
['"Price: (Material not available)"', '"00000"'], _
['"Price: Computing (in queue)"', '"00000"'], _
['"Price: Computing (request sent)"', '"00000"'], _
['"Primary Prof"', '"00000"'], _
['"Print"', '"00000"'], _
['"PrintScreen"', '"00000"'], _
['"Prof Change - Assassin"', '"00000"'], _
['"Prof Change - Dervish"', '"00000"'], _
['"Prof Change - Elementalist"', '"00000"'], _
['"Prof Change - Mesmer"', '"00000"'], _
['"Prof Change - Monk"', '"00000"'], _
['"Prof Change - Necro"', '"00000"'], _
['"Prof Change - Paragon"', '"00000"'], _
['"Prof Change - Ranger"', '"00000"'], _
['"Prof Change - Ritualist"', '"00000"'], _
['"Prof Change - Warrior"', '"00000"'], _
['"PvP messages"', '"00000"'], _
['"Pyre Fierceshot"', '"00000"'], _
['"Quarrel Falls"', '"00000"'], _
['"Quest Marker"', '"00000"'], _
['"Quest"', '"00000"'], _
['"Quest%d"', '"00000"'], _
['"R:%3.0f"', '"00000"'], _
['"Raisu Palace"', '"00000"'], _
['"Ran Musu Gardens"', '"00000"'], _
['"Random Arenas"', '"00000"'], _
['"Range"', '"00000"'], _
['"Ranger"', '"00000"'], _
['"Ranges"', '"00000"'], _
['"Rata Sum"', '"00000"'], _
['"Razah"', '"00000"'], _
['"ReadFile failed ! (%u)"', '"00000"'], _
['"Ready"', '"00000"'], _
['"Realm of Torment"', '"00000"'], _
['"Reapply appropriate Title"', '"00000"'], _
['"Recall"', '"00000"'], _
['"Recall\0Unyielding Aura\0Holy Veil\0Other"', '"00000"'], _
['"Received price %d for %d (item %d)\n"', '"00000"'], _
['"Receiving a party invite"', '"00000"'], _
['"Receiving a private message"', '"00000"'], _
['"Recent"', '"00000"'], _
['"Red Rock Candy"', '"00000"'], _
['"Red channel (0 - 255)"', '"00000"'], _
['"Reduce agent ping spam"', '"00000"'], _
['"Region: %s"', '"00000"'], _
['"Regular expressions allow you to specify wildcards and express more.\nThe syntax is described at www.cplusplus.com/reference/regex/ECMAScript\nNote that the whole message needs to be matched, so for example you might want .* at the end."', '"00000"'], _
['"Release the ownership of the Discord integration"', '"00000"'], _
['"Remains of Sahlahja"', '"00000"'], _
['"Removing Cursor Fix\n"', '"00000"'], _
['"Reset"', '"00000"'], _
['"Resign Log"', '"00000"'], _
['"Resigned"', '"00000"'], _
['"Resources"', '"00000"'], _
['"Restore Default"', '"00000"'], _
['"Restore Defaults"', '"00000"'], _
['"Restore Defaults?"', '"00000"'], _
['"Restore"', '"00000"'], _
['"Restoring input hook\n"', '"00000"'], _
['"Revert"', '"00000"'], _
['"Reward"', '"00000"'], _
['"Right Alt"', '"00000"'], _
['"Right Control"', '"00000"'], _
['"Right Shift"', '"00000"'], _
['"Right Windows"', '"00000"'], _
['"Right mouse"', '"00000"'], _
['"Right"', '"00000"'], _
['"Rilohn Refuge"', '"00000"'], _
['"Ring of Fire"', '"00000"'], _
['"Ritualist"', '"00000"'], _
['"Riverside Province"', '"00000"'], _
['"Roll of Parchment"', '"00000"'], _
['"Roll of Vellum"', '"00000"'], _
['"Rotation"', '"00000"'], _
['"Row Height"', '"00000"'], _
['"Ruby"', '"00000"'], _
['"Ruins of Morah"', '"00000"'], _
['"Ruins of Surmia"', '"00000"'], _
['"Russian"', '"00000"'], _
['"SafeThreadEntry __except body\n"', '"00000"'], _
['"Sanctum Cay"', '"00000"'], _
['"Sapphire"', '"00000"'], _
['"Sardelac Sanitarium"', '"00000"'], _
['"Save Location Data"', '"00000"'], _
['"Save Now"', '"00000"'], _
['"Scale"', '"00000"'], _
['"Scorpion: %d"', '"00000"'], _
['"Scroll Lock"', '"00000"'], _
['"Scroll of Resurrection\nFibers and Bones"', '"00000"'], _
['"Scrollbar Rounding"', '"00000"'], _
['"Scrollbar Size"', '"00000"'], _
['"ScrollbarRounding"', '"00000"'], _
['"ScrollbarSize"', '"00000"'], _
['"Search"', '"00000"'], _
['"Secondary Prof"', '"00000"'], _
['"Seitung Harbor"', '"00000"'], _
['"Select Hotkey"', '"00000"'], _
['"Select a favorite"', '"00000"'], _
['"Select"', '"00000"'], _
['"Sell##common"', '"00000"'], _
['"Sell##rare"', '"00000"'], _
['"Send Chat hotkey to enter one of the commands above."', '"00000"'], _
['"Send Chat"', '"00000"'], _
['"Send Kamadan ad1 trade chat to your trade chat"', '"00000"'], _
['"Send a Dialog"', '"00000"'], _
['"Send a message or command to chat"', '"00000"'], _
['"Send to team chat"', '"00000"'], _
['"Send"', '"00000"'], _
['"Send##1"', '"00000"'], _
['"Send##2"', '"00000"'], _
['"SendChat"', '"00000"'], _
['"Sender Color:"', '"00000"'], _
['"Sender"', '"00000"'], _
['"Sent Dialog 0x%X"', '"00000"'], _
['"Sent dialog %s (%d)"', '"00000"'], _
['"Separator"', '"00000"'], _
['"Serenity Temple"', '"00000"'], _
['"Setting your status to offline in friend list hides your info from Discord"', '"00000"'], _
['"Settings"', '"00000"'], _
['"Shadow Nexus, The"', '"00000"'], _
['"Shadow"', '"00000"'], _
['"Shadowstep Line (Max range)"', '"00000"'], _
['"Shadowstep Line"', '"00000"'], _
['"Shadowstep Marker"', '"00000"'], _
['"Shape"', '"00000"'], _
['"Shift + "', '"00000"'], _
['"Shift"', '"00000"'], _
['"Shing Jea Arena"', '"00000"'], _
['"Shing Jea Monastery"', '"00000"'], _
['"Shing Jea"', '"00000"'], _
['"Shiverpeak Mountains"', '"00000"'], _
['"Show Dialog"', '"00000"'], _
['"Show Enemy Count"', '"00000"'], _
['"Show Item"', '"00000"'], _
['"Show Map"', '"00000"'], _
['"Show Player"', '"00000"'], _
['"Show Quest"', '"00000"'], _
['"Show Resign Log"', '"00000"'], _
['"Show Target"', '"00000"'], _
['"Show a message when a friend:"', '"00000"'], _
['"Show bonds for Allies"', '"00000"'], _
['"Show chat messages timestamp. Color:"', '"00000"'], _
['"Show close button"', '"00000"'], _
['"Show extra timers"', '"00000"'], _
['"Show hero flag controls"', '"00000"'], _
['"Show numbers"', '"00000"'], _
['"Show second decimal"', '"00000"'], _
['"Show the bonds maintained by you.\nOnly works on human players"', '"00000"'], _
['"Show the damage done by each player in your party.\nOnly works on the damage done within your radar range."', '"00000"'], _
['"Show the following in the main window:"', '"00000"'], _
['"Show timestamps in message history."', '"00000"'], _
['"Show widget toggles"', '"00000"'], _
['"Show:"', '"00000"'], _
['"Shows a countdown timer for alcohol"', '"00000"'], _
['"Sifhalla"', '"00000"'], _
['"Signpost Size"', '"00000"'], _
['"Signpost"', '"00000"'], _
['"Size of each Pcon icon in the interface"', '"00000"'], _
['"Size"', '"00000"'], _
['"Sizes"', '"00000"'], _
['"Skill ID"', '"00000"'], _
['"Skill"', '"00000"'], _
['"Skill#%d"', '"00000"'], _
['"SkillID"', '"00000"'], _
['"Sleep"', '"00000"'], _
['"Slice of Pumpkin Pie"', '"00000"'], _
['"Soon you will all be crushed."', '"00000"'], _
['"Space"', '"00000"'], _
['"Spanish"', '"00000"'], _
['"Speed##player"', '"00000"'], _
['"Speed##target"', '"00000"'], _
['"Spirit range"', '"00000"'], _
['"Spiritwood Plank"', '"00000"'], _
['"Square"', '"00000"'], _
['"Start Mail"', '"00000"'], _
['"Start"', '"00000"'], _
['"Steel Ingot"', '"00000"'], _
['"Subtract"', '"00000"'], _
['"Such as Deep aspects"', '"00000"'], _
['"Such fools to think you can attack me here. Come closer so you can see the face of your doom!"', '"00000"'], _
['"Sunjiang District"', '"00000"'], _
['"Sunspear Arena"', '"00000"'], _
['"Sunspear Great Hall"', '"00000"'], _
['"Sunspear Sanctuary"', '"00000"'], _
['"Suppress drunk emotes"', '"00000"'], _
['"Suppress lunar and drunk post-processing effects"', '"00000"'], _
['"Suppress lunar and drunk text"', '"00000"'], _
['"Swat"', '"00000"'], _
['"Symbol Modifier"', '"00000"'], _
['"Symbols"', '"00000"'], _
['"TAB or SHIFT+TAB to cycle through keyboard editable fields."', '"00000"'], _
['"Tahlkora"', '"00000"'], _
['"Tahnnakai Temple"', '"00000"'], _
['"Take me now, subcreature."', '"00000"'], _
['"Take quest in Mountains"', '"00000"'], _
['"Take quest in Planes"', '"00000"'], _
['"Take quest"', '"00000"'], _
['"Take"', '"00000"'], _
['"Tanglewood Copse"', '"00000"'], _
['"Target #%d"', '"00000"'], _
['"Target %s"', '"00000"'], _
['"Target ID"', '"00000"'], _
['"Target a game entity by its ID"', '"00000"'], _
['"Target coordinates are (%f, %f)"', '"00000"'], _
['"Target model id (PlayerNumber) is %d"', '"00000"'], _
['"Target"', '"00000"'], _
['"TargetID"', '"00000"'], _
['"TargetName"', '"00000"'], _
['"Tarnished Haven"', '"00000"'], _
['"Team"', '"00000"'], _
['"TeamId"', '"00000"'], _
['"Tear"', '"00000"'], _
['"Teleport Lab"', '"00000"'], _
['"Teleport Mountains\nThis is NOT the mountains quest"', '"00000"'], _
['"Teleport Pits"', '"00000"'], _
['"Teleport Planes"', '"00000"'], _
['"Teleport Pools"', '"00000"'], _
['"Teleport Vale"', '"00000"'], _
['"Telport Wastes"', '"00000"'], _
['"Tempered Glass Vial"', '"00000"'], _
['"Template"', '"00000"'], _
['"Temple of the Ages"', '"00000"'], _
['"Terrain"', '"00000"'], _
['"Thank you and sorry for the inconvenience."', '"00000"'], _
['"The Agent to which this custom attributes will be applied. Required."', '"00000"'], _
['"The Barradin Estate"', '"00000"'], _
['"The Depths of Tyria"', '"00000"'], _
['"The Desolation"', '"00000"'], _
['"The Flight North"', '"00000"'], _
['"The Hunt"', '"00000"'], _
['"The Rise of The White Mantle"', '"00000"'], _
['"The Tarnished Coast"', '"00000"'], _
['"The Tengu Accords"', '"00000"'], _
['"The connection to kamadan.decltype.com has timed out."', '"00000"'], _
['"The custom color for this agent."', '"00000"'], _
['"The hotkey can trigger only when selected"', '"00000"'], _
['"The hotkey will only trigger in this map.\nUse 0 for any map."', '"00000"'], _
['"The hotkey will only trigger within this range.\nUse 0 for no limit."', '"00000"'], _
['"The map where it will be applied. Optional. Leave 0 for any map"', '"00000"'], _
['"The shape of this agent."', '"00000"'], _
['"The size for this agent."', '"00000"'], _
['"The syntax is /resize width height"', '"00000"'], _
['"Theme"', '"00000"'], _
['"There are several ways to open and close toolbox windows and widgets:"', '"00000"'], _
['"Thirsty River"', '"00000"'], _
['"This feature is experimental and might crash your game.\n"', '"00000"'], _
['"This house has many hearts."', '"00000"'], _
['"This house is clean."', '"00000"'], _
['"This is the color at the edge, the color in the middle is the same, with alpha-50"', '"00000"'], _
['"This will prevent kneel, bored, moan, flex, fistshake and roar.\n"', '"00000"'], _
['"Thresholds"', '"00000"'], _
['"Thunderhead Keep"', '"00000"'], _
['"Tick is a toggle"', '"00000"'], _
['"Tick with pcons"', '"00000"'], _
['"Ticking in party window will work as a toggle instead of opening the menu"', '"00000"'], _
['"Tihark Orchard"', '"00000"'], _
['"Time the instance has been active"', '"00000"'], _
['"Time"', '"00000"'], _
['"Time="', '"00000"'], _
['"Timeout"', '"00000"'], _
['"Timer"', '"00000"'], _
['"Toggle %s"', '"00000"'], _
['"Toggle a GWToolbox++ functionality such as clicker"', '"00000"'], _
['"Toggle"', '"00000"'], _
['"Toggle###combo"', '"00000"'], _
['"Toggle..."', '"00000"'], _
['"ToggleID"', '"00000"'], _
['"Tomb of the Primeval Kings"', '"00000"'], _
['"Toolbox Settings"', '"00000"'], _
['"Toolbox Update!"', '"00000"'], _
['"Toolbox minimap will not capture mouse events when in an outpost"', '"00000"'], _
['"Toolbox minimap will not capture mouse events"', '"00000"'], _
['"Toolbox normally loads settings on launch.\nClick to re-load from disk now."', '"00000"'], _
['"Toolbox normally saves settings on exit.\nClick to save to disk now."', '"00000"'], _
['"Toolbox will disable a pcon if it is not found in the inventory"', '"00000"'], _
['"Toolbox will save your location every second in a file in Settings Folder."', '"00000"'], _
['"Toolbox"', '"00000"'], _
['"Total ~ 100 % ~ "', '"00000"'], _
['"Tower of Strength"', '"00000"'], _
['"Trade Alerts"', '"00000"'], _
['"Trade"', '"00000"'], _
['"Travel To..."', '"00000"'], _
['"Travel"', '"00000"'], _
['"Try to use the current process for Discord integration"', '"00000"'], _
['"Tsumei Village"', '"00000"'], _
['"Type"', '"00000"'], _
['"UW - Chamber"', '"00000"'], _
['"UW - Escort"', '"00000"'], _
['"UW - Mnt"', '"00000"'], _
['"UW - Pits"', '"00000"'], _
['"UW - Planes"', '"00000"'], _
['"UW - Pools"', '"00000"'], _
['"UW - Restore"', '"00000"'], _
['"UW - UWG"', '"00000"'], _
['"UW - Vale"', '"00000"'], _
['"UW - Wastes"', '"00000"'], _
['"UW Teles"', '"00000"'], _
['"Umbral Grotto"', '"00000"'], _
['"Unknown map"', '"00000"'], _
['"Unknown"', '"00000"'], _
['"Unlock Move All"', '"00000"'], _
['"Unticking will completely disable a feature from initializing and running. Requires Toolbox restart."', '"00000"'], _
['"Unwaking Waters (Kurzick)"', '"00000"'], _
['"Unwaking Waters (Luxon)"', '"00000"'], _
['"Update mode:"', '"00000"'], _
['"Update successful, please restart toolbox."', '"00000"'], _
['"Updated error - cannot download GWToolbox.dll"', '"00000"'], _
['"Updater error - cannot find GWToolbox.dll path"', '"00000"'], _
['"Updater"', '"00000"'], _
['"Urgoz"', '"00000"'], _
['"Use #%d"', '"00000"'], _
['"Use %s"', '"00000"'], _
['"Use 24h clock"', '"00000"'], _
['"Use Item"', '"00000"'], _
['"Use Q/E, A/D, W/S, X/Z, R and arrows for camera movement"', '"00000"'], _
['"Use an item from your inventory"', '"00000"'], _
['"Use or cancel a skill such as Recall or UA"', '"00000"'], _
['"UseItem"', '"00000"'], _
['"Using level 1 alcohol instead of this is recommended for preventing drunk emotes.\n"', '"00000"'], _
['"VK_0x07"', '"00000"'], _
['"VK_0x0A"', '"00000"'], _
['"VK_0x0B"', '"00000"'], _
['"VK_0x0E"', '"00000"'], _
['"VK_0x0F"', '"00000"'], _
['"VK_0x16"', '"00000"'], _
['"VK_0x1A"', '"00000"'], _
['"VK_0x3A"', '"00000"'], _
['"VK_0x3B"', '"00000"'], _
['"VK_0x3C"', '"00000"'], _
['"VK_0x3D"', '"00000"'], _
['"VK_0x3E"', '"00000"'], _
['"VK_0x3F"', '"00000"'], _
['"VK_0x40"', '"00000"'], _
['"VK_0x5E"', '"00000"'], _
['"VK_0x88"', '"00000"'], _
['"VK_0x89"', '"00000"'], _
['"VK_0x8A"', '"00000"'], _
['"VK_0x8B"', '"00000"'], _
['"VK_0x8C"', '"00000"'], _
['"VK_0x8D"', '"00000"'], _
['"VK_0x8E"', '"00000"'], _
['"VK_0x8F"', '"00000"'], _
['"VK_0x92"', '"00000"'], _
['"VK_0x93"', '"00000"'], _
['"VK_0x94"', '"00000"'], _
['"VK_0x95"', '"00000"'], _
['"VK_0x96"', '"00000"'], _
['"VK_0x97"', '"00000"'], _
['"VK_0x98"', '"00000"'], _
['"VK_0x99"', '"00000"'], _
['"VK_0x9A"', '"00000"'], _
['"VK_0x9B"', '"00000"'], _
['"VK_0x9C"', '"00000"'], _
['"VK_0x9D"', '"00000"'], _
['"VK_0x9E"', '"00000"'], _
['"VK_0x9F"', '"00000"'], _
['"VK_0xB8"', '"00000"'], _
['"VK_0xB9"', '"00000"'], _
['"VK_0xE0"', '"00000"'], _
['"VK_0xE1"', '"00000"'], _
['"VK_0xE3"', '"00000"'], _
['"VK_0xE4"', '"00000"'], _
['"VK_0xE6"', '"00000"'], _
['"VK_0xE9"', '"00000"'], _
['"VK_0xEA"', '"00000"'], _
['"VK_0xEB"', '"00000"'], _
['"VK_0xEC"', '"00000"'], _
['"VK_0xED"', '"00000"'], _
['"VK_0xEE"', '"00000"'], _
['"VK_0xEF"', '"00000"'], _
['"VK_0xF0"', '"00000"'], _
['"VK_0xF1"', '"00000"'], _
['"VK_0xF2"', '"00000"'], _
['"VK_0xF3"', '"00000"'], _
['"VK_0xF4"', '"00000"'], _
['"VK_0xF5"', '"00000"'], _
['"Vabbi"', '"00000"'], _
['"Vale"', '"00000"'], _
['"Vanquish counter"', '"00000"'], _
['"Vanquish"', '"00000"'], _
['"Vanquished"', '"00000"'], _
['"Vasburg Armory"', '"00000"'], _
['"Veil"', '"00000"'], _
['"Vekk"', '"00000"'], _
['"Venta Cemetery"', '"00000"'], _
['"Version %s is available!"', '"00000"'], _
['"Vial of Ink"', '"00000"'], _
['"Visibility"', '"00000"'], _
['"Visible"', '"00000"'], _
['"Vizunah Square (Foreign)"', '"00000"'], _
['"Vizunah Square (Local)"', '"00000"'], _
['"Volume Down"', '"00000"'], _
['"Volume Mute"', '"00000"'], _
['"Volume Up"', '"00000"'], _
['"WSAStartup Failed.\n"', '"00000"'], _
['"Wailing Lord"', '"00000"'], _
['"Waiting for logged character\n"', '"00000"'], _
['"War Supplies"', '"00000"'], _
['"Warning"', '"00000"'], _
['"Warrior"', '"00000"'], _
['"Waste"', '"00000"'], _
['"Wastes"', '"00000"'], _
['"We have vanquished %lu %s! %lu %s remaining."', '"00000"'], _
['"We must prepare for the coming of Banjo the Clown, God of Puppets."', '"00000"'], _
['"WeaponType"', '"00000"'], _
['"Wehhan Terraces"', '"00000"'], _
['"When I grow up, I want to be a principal or a caterpillar."', '"00000"'], _
['"When enabled, GWToolbox++ can automatically restore\n"', '"00000"'], _
['"When you have less than this amount:\n-The number in the interface becomes yellow.\n-Warning message is displayed when zoning into outpost."', '"00000"'], _
['"While editing text:\n"', '"00000"'], _
['"Whisper Target Name,msg"', '"00000"'], _
['"Whispers"', '"00000"'], _
['"Widgets:"', '"00000"'], _
['"Width"', '"00000"'], _
['"Wilds, The"', '"00000"'], _
['"Will allow movement and resize of all widgets and windows"', '"00000"'], _
['"Will close the travel window when clicking on a travel destination"', '"00000"'], _
['"Will hide drunk and lunars messages on top of your and other characters"', '"00000"'], _
['"Will hide the skills in your effect monitor"', '"00000"'], _
['"Window Padding"', '"00000"'], _
['"Window Rounding"', '"00000"'], _
['"Window Title Align"', '"00000"'], _
['"WindowPaddingX"', '"00000"'], _
['"WindowPaddingY"', '"00000"'], _
['"WindowRounding"', '"00000"'], _
['"WindowTitleAlignX"', '"00000"'], _
['"WindowTitleAlignY"', '"00000"'], _
['"Windows:"', '"00000"'], _
['"Winnowing"', '"00000"'], _
['"Working"', '"00000"'], _
['"Wrote %lu of %lu bytes for %s"', '"00000"'], _
['"X pos##player"', '"00000"'], _
['"X pos##target"', '"00000"'], _
['"X1 mouse"', '"00000"'], _
['"X2 mouse"', '"00000"'], _
['"Xandra"', '"00000"'], _
['"Y pos##player"', '"00000"'], _
['"Y pos##target"', '"00000"'], _
['"Yahnur Market"', '"00000"'], _
['"Yohlon Haven"', '"00000"'], _
['"You are messing with affairs that are beyond your comprehension. Leave now and I may let you live!"', '"00000"'], _
['"You are no match for my almighty power."', '"00000"'], _
['"You can prefix the number by \"', '"00000"'], _
['"You can set the color alpha to 0 to disable any minimap feature."', '"00000"'], _
['"You need to show the widget for this control to work"', '"00000"'], _
['"You need to show the window for this control to work"', '"00000"'], _
['"Zaishen Challenge"', '"00000"'], _
['"Zaishen Elite"', '"00000"'], _
['"Zaishen Menagerie"', '"00000"'], _
['"Zei Ri"', '"00000"'], _
['"Zen Daijun"', '"00000"'], _
['"Zenmai"', '"00000"'], _
['"Zhed Shadowhoof"', '"00000"'], _
['"Zin Ku Corridor"', '"00000"'], _
['"Zoning in a new map"', '"00000"'], _
['"Zoom"', '"00000"'], _
['"Zos Shivros Channel"', '"00000"'], _
['"[%d - %s;%s]"', '"00000"'], _
['"[%d:%02d:%02d.%03d]"', '"00000"'], _
['"[%s %d;%s]"', '"00000"'], _
['"[%s;%s]"', '"00000"'], _
['"[%s] "', '"00000"'], _
['"[%s] %s\n"', '"00000"'], _
['"[%s] ~ Start: %s ~ End: %s ~ Time: %s"', '"00000"'], _
['"[Error] Please provide an argument"', '"00000"'], _
['"[SCAN] GoldConfirmationPatch = %p\n"', '"00000"'], _
['"[SCAN] StoragePatch = %p\n"', '"00000"'], _
['"[SCAN] TomePatch = %p\n"', '"00000"'], _
['"[SCAN] is_ingame = %p\n"', '"00000"'], _
['"[dis] can be any of: ae, ae1, ee, eg, int, etc"', '"00000"'], _
['"\x5F\x6A\x00\xFF\x75\xE4\x6A\x4C\xFF\x75\xF8"', '"00000"'], _
['"\x75\x1E\x90\x90\x90\x90\x90"', '"00000"'], _
['"\x8101\x1f4e\xd020\x87c8\x35a8\x0000"', '"00000"'], _
['"\x8102\x3236"', '"00000"'], _
['"\x90\x90"', '"00000"'], _
['"\xA3\x00\x00\x00\x00\xFF\x75\x0C\xC7\x05"', '"00000"'], _
['"\xEB\x17\x33\xD2\x8D\x4A\x06\xEB"', '"00000"'], _
['"\xF7\x40\x0C\x10\x00\x02\x00\x75"', '"00000"'], _
['"_Release"', '"00000"'], _
['"a.m."', '"00000"'], _
['"abaddonsgate"', '"00000"'], _
['"abaddonsmouth"', '"00000"'], _
['"active"', '"00000"'], _
['"activity.timestamps.start"', '"00000"'], _
['"age2"', '"00000"'], _
['"alcohol"', '"00000"'], _
['"alliance"', '"00000"'], _
['"altrummruins"', '"00000"'], _
['"amatzbasin"', '"00000"'], _
['"amnoonoasisthe"', '"00000"'], _
['"apple"', '"00000"'], _
['"arborstone"', '"00000"'], _
['"armor"', '"00000"'], _
['"ascaloncity"', '"00000"'], _
['"aspenwoodgatekurzick"', '"00000"'], _
['"aspenwoodgateluxon"', '"00000"'], _
['"assets.large_image"', '"00000"'], _
['"astralariumthe"', '"00000"'], _
['"auguryrock"', '"00000"'], _
['"auriosminesthe"', '"00000"'], _
['"auroraglade"', '"00000"'], _
['"baipaasureach"', '"00000"'], _
['"basaltgrotto"', '"00000"'], _
['"beaconsperch"', '"00000"'], _
['"beetletun"', '"00000"'], _
['"beknurharbor"', '"00000"'], _
['"bergenhotsprings"', '"00000"'], _
['"blacktideden"', '"00000"'], _
['"blocked skill %d\n"', '"00000"'], _
['"bloodstonefen"', '"00000"'], _
['"bluerock"', '"00000"'], _
['"body"', '"00000"'], _
['"bonepalace"', '"00000"'], _
['"borealstation"', '"00000"'], _
['"boreasseabed"', '"00000"'], _
['"borlispass"', '"00000"'], _
['"braueracademy"', '"00000"'], _
['"breakerhollow"', '"00000"'], _
['"buffer_"', '"00000"'], _
['"buildname"', '"00000"'], _
['"builds"', '"00000"'], _
['"builds%03d"', '"00000"'], _
['"camera"', '"00000"'], _
['"camphojanu"', '"00000"'], _
['"camprankor"', '"00000"'], _
['"cavalon"', '"00000"'], _
['"centraltransferchamber"', '"00000"'], _
['"chahbekvillage"', '"00000"'], _
['"championsdawn"', '"00000"'], _
['"channel"', '"00000"'], _
['"chantryofsecrets"', '"00000"'], _
['"chest"', '"00000"'], _
['"city"', '"00000"'], _
['"clear"', '"00000"'], _
['"close"', '"00000"'], _
['"closest"', '"00000"'], _
['"codexarena"', '"00000"'], _
['"color_custom_markers"', '"00000"'], _
['"color_drawings"', '"00000"'], _
['"color_map"', '"00000"'], _
['"color_mapshadow"', '"00000"'], _
['"color_north"', '"00000"'], _
['"color_pings"', '"00000"'], _
['"color_quest"', '"00000"'], _
['"color_range_aggro"', '"00000"'], _
['"color_range_cast"', '"00000"'], _
['"color_range_compass"', '"00000"'], _
['"color_range_hos"', '"00000"'], _
['"color_range_spirit"', '"00000"'], _
['"color_shadowstep_line"', '"00000"'], _
['"color_shadowstep_line_maxrange"', '"00000"'], _
['"color_shadowstep_mark"', '"00000"'], _
['"color_symbols_modifier"', '"00000"'], _
['"consulatedocks"', '"00000"'], _
['"copperhammermines"', '"00000"'], _
['"corn"', '"00000"'], _
['"count"', '"00000"'], _
['"count_"', '"00000"'], _
['"cupcake"', '"00000"'], _
['"customagent%03d"', '"00000"'], _
['"customline"', '"00000"'], _
['"customline%03d"', '"00000"'], _
['"custommarker"', '"00000"'], _
['"custommarker%03d"', '"00000"'], _
['"dajkahinlet"', '"00000"'], _
['"dalessioseaboard"', '"00000"'], _
['"damage"', '"00000"'], _
['"dashavestibule"', '"00000"'], _
['"days"', '"00000"'], _
['"deep"', '"00000"'], _
['"deepthe"', '"00000"'], _
['"default"', '"00000"'], _
['"deldrimorwarcamp"', '"00000"'], _
['"destinysgorge"', '"00000"'], _
['"dialog"', '"00000"'], _
['"disabled"', '"00000"'], _
['"distance"', '"00000"'], _
['"divinitycoast"', '"00000"'], _
['"dll file name is %s\n"', '"00000"'], _
['"dllpath"', '"00000"'], _
['"dllversion"', '"00000"'], _
['"doom"', '"00000"'], _
['"doomlore"', '"00000"'], _
['"doomloreshrine"', '"00000"'], _
['"dragonslairthe"', '"00000"'], _
['"dragonsthroat"', '"00000"'], _
['"droknarsforge"', '"00000"'], _
['"druidsoverlook"', '"00000"'], _
['"dunesofdespair"', '"00000"'], _
['"durheimarchives"', '"00000"'], _
['"dzagonurbastion"', '"00000"'], _
['"elonareach"', '"00000"'], _
['"embark"', '"00000"'], _
['"embarkbeach"', '"00000"'], _
['"emberlightcamp"', '"00000"'], _
['"enabled"', '"00000"'], _
['"enter-up"', '"00000"'], _
['"eotn"', '"00000"'], _
['"eredonterrace"', '"00000"'], _
['"error"', '"00000"'], _
['"essence"', '"00000"'], _
['"eternalgrovethe"', '"00000"'], _
['"exit"', '"00000"'], _
['"eyeofthenorth"', '"00000"'], _
['"fav_count"', '"00000"'], _
['"fishermenshaven"', '"00000"'], _
['"flag"', '"00000"'], _
['"foes"', '"00000"'], _
['"fortaspenwoodkurzick"', '"00000"'], _
['"fortaspenwoodluxon"', '"00000"'], _
['"fortranik"', '"00000"'], _
['"frontiergate"', '"00000"'], _
['"frostgatethe"', '"00000"'], _
['"gadd"', '"00000"'], _
['"gadds"', '"00000"'], _
['"gaddsencampment"', '"00000"'], _
['"gateofanguish"', '"00000"'], _
['"gateofdesolation"', '"00000"'], _
['"gateoffear"', '"00000"'], _
['"gateofmadness"', '"00000"'], _
['"gateofpain"', '"00000"'], _
['"gateofsecrets"', '"00000"'], _
['"gateofthenightfallenlands"', '"00000"'], _
['"gateoftorment"', '"00000"'], _
['"gatesofkryta"', '"00000"'], _
['"getid"', '"00000"'], _
['"getpos"', '"00000"'], _
['"global_enable"', '"00000"'], _
['"grail"', '"00000"'], _
['"grandcourtofsebelkeh"', '"00000"'], _
['"granitecitadelthe"', '"00000"'], _
['"greatnorthernwallthe"', '"00000"'], _
['"greattempleofbalthazar"', '"00000"'], _
['"greenrock"', '"00000"'], _
['"grendichcourthouse"', '"00000"'], _
['"gtob"', '"00000"'], _
['"guild"', '"00000"'], _
['"gunnarshold"', '"00000"'], _
['"gyalahatchery"', '"00000"'], _
['"harvesttemple"', '"00000"'], _
['"header"', '"00000"'], _
['"health"', '"00000"'], _
['"hellsprecipice"', '"00000"'], _
['"hengeofdenravi"', '"00000"'], _
['"hero_flag_controls_background"', '"00000"'], _
['"heroesascent"', '"00000"'], _
['"heroesaudience"', '"00000"'], _
['"heroindex%d"', '"00000"'], _
['"hide"', '"00000"'], _
['"honurhill"', '"00000"'], _
['"hotkey-"', '"00000"'], _
['"hotkey-%03d:%s"', '"00000"'], _
['"hour"', '"00000"'], _
['"hours"', '"00000"'], _
['"housezuheltzer"', '"00000"'], _
['"http://"', '"00000"'], _
['"http://wiki.fbgmguild.com/Main_Page"', '"00000"'], _
['"http://wiki.fbgmguild.com/index.php?search="', '"00000"'], _
['"https://"', '"00000"'], _
['"https://api.github.com/repos/HasKha/GWToolboxpp/releases/tags/"', '"00000"'], _
['"https://github.com/HasKha/GWToolboxpp/releases/download/"', '"00000"'], _
['"https://haskha.github.io/GWToolboxpp/"', '"00000"'], _
['"https://kamadan.decltype.org"', '"00000"'], _
['"icecavesofsorrow"', '"00000"'], _
['"icetoothcave"', '"00000"'], _
['"id: %d"', '"00000"'], _
['"ignore"', '"00000"'], _
['"img/bonds"', '"00000"'], _
['"img/icons"', '"00000"'], _
['"img/materials"', '"00000"'], _
['"img/pcons"', '"00000"'], _
['"img\\bonds"', '"00000"'], _
['"img\\icons"', '"00000"'], _
['"img\\materials"', '"00000"'], _
['"img\\pcons"', '"00000"'], _
['"imperialsanctum"', '"00000"'], _
['"in February 5, 2019 update."', '"00000"'], _
['"installing event handler\n"', '"00000"'], _
['"instance timer"', '"00000"'], _
['"ironminesofmoladune"', '"00000"'], _
['"jadeflatskurzick"', '"00000"'], _
['"jadeflatsluxon"', '"00000"'], _
['"jadequarrykurzickthe"', '"00000"'], _
['"jadequarryluxonthe"', '"00000"'], _
['"jennurshorde"', '"00000"'], _
['"jokanurdiggings"', '"00000"'], _
['"kabob"', '"00000"'], _
['"kaineng"', '"00000"'], _
['"kainengcenter"', '"00000"'], _
['"kama"', '"00000"'], _
['"kamadan"', '"00000"'], _
['"kamadan, Jewel of Istan"', '"00000"'], _
['"kodashbazaarthe"', '"00000"'], _
['"kodlonuhamlet"', '"00000"'], _
['"kodonurcrossroads"', '"00000"'], _
['"lairoftheforgotten"', '"00000"'], _
['"leviathanpits"', '"00000"'], _
['"line"', '"00000"'], _
['"line%d"', '"00000"'], _
['"lines"', '"00000"'], _
['"lionsarch"', '"00000"'], _
['"load"', '"00000"'], _
['"local"', '"00000"'], _
['"location logs"', '"00000"'], _
['"lock"', '"00000"'], _
['"lock_move"', '"00000"'], _
['"longeyesledge"', '"00000"'], _
['"lunars"', '"00000"'], _
['"lutgardisconservatory"', '"00000"'], _
['"m[0] == 0x%X && m[1] == 0x%X && m[2] == 0x%X && m[3] == 0x%X\n"', '"00000"'], _
['"maatukeep"', '"00000"'], _
['"maguumastade"', '"00000"'], _
['"mapid"', '"00000"'], _
['"marhansgrotto"', '"00000"'], _
['"marker"', '"00000"'], _
['"marker%d"', '"00000"'], _
['"markers"', '"00000"'], _
['"marketplacethe"', '"00000"'], _
['"maxi"', '"00000"'], _
['"maximize"', '"00000"'], _
['"maxrange_interp_begin"', '"00000"'], _
['"maxrange_interp_end"', '"00000"'], _
['"menubuttons"', '"00000"'], _
['"message"', '"00000"'], _
['"mihanutownship"', '"00000"'], _
['"mini"', '"00000"'], _
['"minimize"', '"00000"'], _
['"ministerchosestate"', '"00000"'], _
['"minute"', '"00000"'], _
['"minutes of inactivity"', '"00000"'], _
['"minutes"', '"00000"'], _
['"moddokcrevice"', '"00000"'], _
['"mode"', '"00000"'], _
['"mouthoftormentthe"', '"00000"'], _
['"moving to %s\n"', '"00000"'], _
['"nahpuiquarter"', '"00000"'], _
['"name"', '"00000"'], _
['"name%d"', '"00000"'], _
['"nearest"', '"00000"'], _
['"nolaniacademy"', '"00000"'], _
['"num_results"', '"00000"'], _
['"nundubay"', '"00000"'], _
['"occur, such as entering instances."', '"00000"'], _
['"offset"', '"00000"'], _
['"olafstead"', '"00000"'], _
['"open"', '"00000"'], _
['"p.m."', '"00000"'], _
['"pcons"', '"00000"'], _
['"pconsize"', '"00000"'], _
['"pikensquare"', '"00000"'], _
['"plane"', '"00000"'], _
['"pogahnpassage"', '"00000"'], _
['"portsledge"', '"00000"'], _
['"print"', '"00000"'], _
['"profession_%d_512px"', '"00000"'], _
['"quarrelfalls"', '"00000"'], _
['"query"', '"00000"'], _
['"quit"', '"00000"'], _
['"raisupalace"', '"00000"'], _
['"randomarenas"', '"00000"'], _
['"ranmusugardens"', '"00000"'], _
['"ratasum"', '"00000"'], _
['"redrock"', '"00000"'], _
['"region_ascalon"', '"00000"'], _
['"region_battleisles"', '"00000"'], _
['"region_battlejahai"', '"00000"'], _
['"region_charrhomelands"', '"00000"'], _
['"region_crystaldesert"', '"00000"'], _
['"region_depths"', '"00000"'], _
['"region_deso"', '"00000"'], _
['"region_farshivs"', '"00000"'], _
['"region_flightnorth"', '"00000"'], _
['"region_fow"', '"00000"'], _
['"region_ha"', '"00000"'], _
['"region_istan"', '"00000"'], _
['"region_kaineng"', '"00000"'], _
['"region_kourna"', '"00000"'], _
['"region_kryta"', '"00000"'], _
['"region_kurz"', '"00000"'], _
['"region_lux"', '"00000"'], _
['"region_maguuma"', '"00000"'], _
['"region_presearing"', '"00000"'], _
['"region_shingjea"', '"00000"'], _
['"region_shiverpeaks"', '"00000"'], _
['"region_swat"', '"00000"'], _
['"region_tarnished"', '"00000"'], _
['"region_tenguaccords"', '"00000"'], _
['"region_torment"', '"00000"'], _
['"region_vabbi"', '"00000"'], _
['"region_whitemantle"', '"00000"'], _
['"remainsofsahlahja"', '"00000"'], _
['"report"', '"00000"'], _
['"reset"', '"00000"'], _
['"resign"', '"00000"'], _
['"resignlog"', '"00000"'], _
['"resize"', '"00000"'], _
['"results"', '"00000"'], _
['"rilohnrefuge"', '"00000"'], _
['"ringoffire"', '"00000"'], _
['"riversideprovince"', '"00000"'], _
['"round"', '"00000"'], _
['"ruinsofmorah"', '"00000"'], _
['"ruinsofsurmia"', '"00000"'], _
['"saintanjekasshrine"', '"00000"'], _
['"salad"', '"00000"'], _
['"sanctumcay"', '"00000"'], _
['"sardelacsanitarium"', '"00000"'], _
['"save"', '"00000"'], _
['"scale must be between [6, 255]"', '"00000"'], _
['"scwiki"', '"00000"'], _
['"seafarersrest"', '"00000"'], _
['"second"', '"00000"'], _
['"seconds"', '"00000"'], _
['"seekerspassage"', '"00000"'], _
['"seitungharbor"', '"00000"'], _
['"selling Gold and Green items introduced\n"', '"00000"'], _
['"selling"', '"00000"'], _
['"sending purchase request for %d (price=%d)\n"', '"00000"'], _
['"sending sell request for %d (price=%d)\n"', '"00000"'], _
['"senjiscorner"', '"00000"'], _
['"serenitytemple"', '"00000"'], _
['"settings"', '"00000"'], _
['"shadownexusthe"', '"00000"'], _
['"shape"', '"00000"'], _
['"shingjeaarena"', '"00000"'], _
['"shingjeamonastery"', '"00000"'], _
['"show"', '"00000"'], _
['"showNumbers"', '"00000"'], _
['"show_active_in_header"', '"00000"'], _
['"show_run_in_header"', '"00000"'], _
['"sifhalla"', '"00000"'], _
['"size"', '"00000"'], _
['"soup"', '"00000"'], _
['"speed"', '"00000"'], _
['"start string"', '"00000"'], _
['"stop"', '"00000"'], _
['"sugest"', '"00000"'], _
['"suggest"', '"00000"'], _
['"sunjiangdistrict"', '"00000"'], _
['"sunspeararena"', '"00000"'], _
['"sunspeargreathall"', '"00000"'], _
['"sunspearsanctuary"', '"00000"'], _
['"tag_name"', '"00000"'], _
['"tahnnakaitemple"', '"00000"'], _
['"tanglewoodcopse"', '"00000"'], _
['"target"', '"00000"'], _
['"tarnishedhaven"', '"00000"'], _
['"team"', '"00000"'], _
['"template%d"', '"00000"'], _
['"templeoftheages"', '"00000"'], _
['"the window from a minimized state when important events\n"', '"00000"'], _
['"thirstyriver"', '"00000"'], _
['"thunderheadkeep"', '"00000"'], _
['"tiharkorchard"', '"00000"'], _
['"timestamp"', '"00000"'], _
['"title"', '"00000"'], _
['"tomboftheprimevalkings"', '"00000"'], _
['"trade"', '"00000"'], _
['"trade_scroll"', '"00000"'], _
['"transmo"', '"00000"'], _
['"travel"', '"00000"'], _
['"travelto"', '"00000"'], _
['"tsumeivillage"', '"00000"'], _
['"typeMap"', '"00000"'], _
['"type_"', '"00000"'], _
['"umbralgrotto"', '"00000"'], _
['"unlock"', '"00000"'], _
['"unwakingwaterskurzick"', '"00000"'], _
['"unwakingwatersluxon"', '"00000"'], _
['"update_mode"', '"00000"'], _
['"urgoz"', '"00000"'], _
['"urgozswarren"', '"00000"'], _
['"useskill"', '"00000"'], _
['"vasburgarmory"', '"00000"'], _
['"ventacemetery"', '"00000"'], _
['"ventarisrefuge"', '"00000"'], _
['"visible"', '"00000"'], _
['"vizunahsquareforeign"', '"00000"'], _
['"vizunahsquarelocal"', '"00000"'], _
['"vlox"', '"00000"'], _
['"vloxs"', '"00000"'], _
['"vloxsfalls"', '"00000"'], _
['"warsupply"', '"00000"'], _
['"wehhanterraces"', '"00000"'], _
['"whispers"', '"00000"'], _
['"wildsthe"', '"00000"'], _
['"wss://kamadan.decltype.org/ws/"', '"00000"'], _
['"x minutes of favor of the gods remaining"', '"00000"'], _
['"x##delete"', '"00000"'], _
['"x????xxxxx"', '"00000"'], _
['"xunlai"', '"00000"'], _
['"xxxxxxxx"', '"00000"'], _
['"xxxxxxxxxxx"', '"00000"'], _
['"yahnurmarket"', '"00000"'], _
['"yaksbend"', '"00000"'], _
['"yohlonhaven"', '"00000"'], _
['"zaishenchallenge"', '"00000"'], _
['"zaishenelite"', '"00000"'], _
['"zaishenmenagerie"', '"00000"'], _
['"zendaijun"', '"00000"'], _
['"zinkucorridor"', '"00000"'], _
['"zoom"', '"00000"'], _
['"zosshivroschannel"', '"00000"'] _
]

Local $fileNames=_FileListToArrayRec(@ScriptDir, "*.cpp", $FLTAR_FILES,  $FLTAR_RECUR)
_ArrayDelete($fileNames, 0)

Local $fileNames1=_FileListToArrayRec(@ScriptDir, "*.h", $FLTAR_FILES,  $FLTAR_RECUR)
_ArrayDelete($fileNames1, 0)

_ArrayConcatenate($fileNames, $fileNames1)

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

msgbox(0,"提示", "运行完毕")

Func Convert($lData)

	Local $original = $lData

	For $i = 0 To Ubound($ConversionTable) - 1
		$lData = StringReplace($lData,$ConversionTable[$i][0], $ConversionTable[$i][1])
	Next

	return $lData
EndFunc