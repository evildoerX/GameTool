---

pcall(function()
  if EDFLAGWIN32 then
    logfile = io.open("log_client.log", "w")
  end
  require("LocalString")
  require("tools")
  require("edebug")
  require("maingameproject")
end)

ed.debug_mode = debug_mode
EDLanguage = EDLanguage or "chinese"
local initFont = function()
  font = "Arial"
  fontBold = "Arial"
  if HGFLAGANDROID or EDFLAGWP8 then
    font = "Arial"
    fontBold = "Arial"
  end
  ed.font = font
  ed.fontBold = fontBold
end
function loadAllFiles()
  for i, v in ipairs(ed.needLoadFiles) do
    require(v)
  end
end
local scene_stack = {}
ed.scene_stack = scene_stack

local main = function()
  local list = {
    ["WVGA"] = {800, 480},
    ["720p"] = {1280, 720},
    ["1080p"] = {1920, 1080},
    ["iPhone"] = {1024, 615},
    ["iPad"] = {2048, 1230}
  }
  
  local rr = list[resource_resolution]
  local lowres = 1
  
  if false then
    EDSwitchToResolutionDir(1)
    lowres = 0.5
  end
  
  CCDirector:sharedDirector():setContentScaleFactor(lowres * rr[2] / 480)
  HGLog("-------------------------------------------")
  for i, v in ipairs(patch_servers) do
    HGLog(string.format("Assets server %i: %s", i, v))
  end
  -- HGLog("Resource Resolution: " .. resource_resolution)
  -- HGLog("")
  HGLog("Current Version: " .. CCUserDefault:sharedUserDefault():getStringForKey("current-version"))
  HGLog("-------------------------------------------")
  
  if HGLuaReset then 
    HGLog("HGLuaReset is set")
  end
  
  collectgarbage("setpause", 100)
  collectgarbage("setstepmul", 5000)
  HGLuaReset = HGLuaReset or 0
  if HGFLAGANDROID and HGLuaReset == 1 then
    ed.pushScene(ed.ui.platformlogo.create())
  else
    ed.pushScene(ed.ui.serverlogin.create())
    --ed.pushScene(ed.ui.logo.create(sessionId))
    --ed.replaceScene(ed.ui.logo.create(sessionId))
  end
  local update_entry_id = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(ed.gameUpdate, 0, false)
end
local function pushScene(scene)
  table.insert(scene_stack, scene)
  if #scene_stack == 1 then
    CCDirector:sharedDirector():runWithScene(scene:ccScene())
  else
    CCDirector:sharedDirector():pushScene(scene:ccScene())
  end
end
ed.pushScene = pushScene
local function popScene()
  HGLog("popScene ")
  if #scene_stack > 0 then
  

  
    if scene_stack[#scene_stack].identity == "main" then
      return
    end
    local scene = table.remove(scene_stack, #scene_stack)
    if scene.OnPopScene then
      scene:OnPopScene()
    end
  end
  CCDirector:sharedDirector():popScene()
end
ed.popScene = popScene

local function popScene2()
  HGLog("popScene2 ")
  if #scene_stack > 0 then
  

  
    if scene_stack[#scene_stack].identity == "main" or scene_stack[#scene_stack].identity == "serverlogin" or scene_stack[#scene_stack].identity == "logo" then
      return
    end
    local scene = table.remove(scene_stack, #scene_stack)
    if scene.OnPopScene then
      scene:OnPopScene()
    end
  end
  CCDirector:sharedDirector():popScene()
end
ed.popScene2 = popScene2

local function replaceScene(scene)
  if #scene_stack > 0 then
    if scene_stack[#scene_stack].identity == "main" then
      pushScene(scene)
      return
    end
    local scene = table.remove(scene_stack, #scene_stack)
    if scene.OnPopScene then
      scene:OnPopScene()
    end
  end
  table.insert(scene_stack, scene)
  scene.pushed = false
  CCDirector:sharedDirector():replaceScene(scene:ccScene())
end
ed.replaceScene = replaceScene

local function getSceneCount()

  if #scene_stack > 0 then
    if scene_stack[#scene_stack].identity == "main" or scene_stack[#scene_stack].identity == "serverlogin" or scene_stack[#scene_stack].identity == "logo" then
      return 0
    end
  end  
   return #scene_stack
end
ed.getSceneCount=getSceneCount

local applicationDidEnterBackground = function()
  print("applicationDidEnterBackground")
  HGLog("applicationDidEnterBackground")
  
  ed.loadEnd()
  ed.closeConnect()
  if ed.player.initialized then
    ed.localnotify.refresh()
  end
  if resume_timestamp and game_server_ip then
    local msg = ed.upmsg.suspend_report()
    msg._gametime = ed.getMillionTime() - resume_timestamp
    resume_timestamp = nil
    ed.send(msg, "suspend_report")
  end
end
ed.applicationDidEnterBackground = applicationDidEnterBackground
local applicationWillEnterForeground = function()
  HGLog("applicationWillEnterForeground 31")
  ed.loadEnd()
  ed.closeConnect()
	--ed.playMusic(ed.music.map)
  resume_timestamp = ed.getMillionTime()
  if ed.checkSoundSwitch then
    ed.checkSoundSwitch()
  end
end
ed.applicationWillEnterForeground = applicationWillEnterForeground
local runScriptString = function()
  local temp = HGGetScriptString()
  if temp ~= nil then
    local func = loadstring(temp)
    if func ~= nil then
      xpcall(func, EDDebug)
    end
  end
end
local gcPassTime = 0
local function memeryGC(fDelTime)
  gcPassTime = gcPassTime + fDelTime
  if gcPassTime > 10 then
    CCSpriteFrameCache:sharedSpriteFrameCache():gc(gcPassTime)
    CCTextureCache:sharedTextureCache():gc(gcPassTime)
    HGAnimation:gc(gcPassTime)
    gcPassTime = 0
  end
end
local function getCurrentScene()
  return scene_stack[#scene_stack]
end
ed.getCurrentScene = getCurrentScene
local update_timestamp = ed.getMillionTime()
local resume_timestamp
local game_update_handler_list = {}
local function gameUpdate()
  xpcall(function()
    local time = ed.getMillionTime()
    if not resume_timestamp then
      resume_timestamp = time
    end
    local dt = update_timestamp ~= 0 and time - update_timestamp or 0
    --dt = dt * 2;
    dt = math.min(dt, ed.tick_interval)
    ed.proc_net()
    local scene = scene_stack[#scene_stack] or {}
    if scene.update then
      scene:update(dt)
    end
    update_timestamp = time
    runScriptString()
    UpdateEventSystem(dt)
    memeryGC(dt)
    for k, v in pairs(game_update_handler_list or {}) do
      v(dt)
    end
  end, EDDebug)
end
ed.gameUpdate = gameUpdate
local function registerGameUpdateHandler(key, handler)
  game_update_handler_list = game_update_handler_list or {}
  game_update_handler_list[key] = handler
end
ed.registerGameUpdateHandler = registerGameUpdateHandler
local function removeGameUpdateHandler(key)
  game_update_handler_list = game_update_handler_list or {}
  game_update_handler_list[key] = nil
end
ed.removeGameUpdateHandler = removeGameUpdateHandler
local initGcTime = function()
  CCSpriteFrameCache:sharedSpriteFrameCache():setGcTime(60)
  CCTextureCache:sharedTextureCache():setGcTime(60)
  HGAnimation:setgcTime(120)
end

function OnRestartGame()
  local function handler()
    --CloseEvent("RestartGame")
    ed.replaceScene(ed.ui.platformlogo.create())
  end
  return handler
end

xpcall(function()
  local ed = ed
  ed.run_with_scene = true
  loadAllFiles()
  initFont()
  initGcTime()
  main()
end, EDDebug)
