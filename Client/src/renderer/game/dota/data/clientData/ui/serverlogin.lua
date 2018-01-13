local serverLogin = {}
serverLogin.__index = serverLogin
local base = ed.ui.basescene
setmetatable(serverLogin, base.mt)
ed.ui.serverlogin = serverLogin
local lastServerName = ""
local stateColor = {
  [T(LSTR("SERVERLOGIN.MAINTAINENACE"))] = ccc3(183, 183, 183),
  [T(LSTR("SERVERLOGIN.FULL"))] = ccc3(255, 81, 20),
  [T(LSTR("SERVERLOGIN.BUSY"))] = ccc3(255, 225, 20),
  [T(LSTR("SERVERLOGIN.RECOMMEND"))] = ccc3(20, 255, 59)
}
local clientVersion = ""
local bSDKLoginSucess = false
local sessionId = ""
local oldDevideId = ""
local initServerEvent, redoInitServerEvent
local serverListData = {}
local function initServerListData()
  if EDServerList == nil then
    return false
  end
  if #serverListData ~= 0 then
    return true
  end
  for i, v in ipairs(EDServerList) do
    local singleServer = {}
    singleServer.name, singleServer.ip, singleServer.port = string.match(v, "([^%|]*)%|([^%|]*)%|([^%|]*)")
    singleServer.state = T(LSTR("SERVERLOGIN.RECOMMEND"))
    table.insert(serverListData, singleServer)
  end
  return true
end
local function getServerName(index)
  if serverListData[index] ~= nil then
    return serverListData[index].name
  end
  return ""
end
local serverList = {}
local buttonHandle = {
  entergame = "enterGame",
  selectserver = "selectServer",
  selectlastserve = "selectLastServer"
}
local panelui = {}
local buttonList = {}
local selectServerContainer, enterContainer
local function getServerInfo(name)
  for i, v in ipairs(serverListData) do
    if v.name == name then
      return v
    end
  end
end
function serverLogin.refreshCurrentServerInfo(name)
  local serverInfo = getServerInfo(name)
  if serverInfo then
    game_server_id = serverInfo.id
    game_server_ip = serverInfo.ip
    game_server_port = serverInfo.port
    lastServerName = serverInfo.name
    ed.setString(panelui.servername, name)
    selectServerContainer:setVisible(false)
    enterContainer:setVisible(true)
    local info = {id = game_server_id}
    HGAndroidExtra("setGameData", ed.getJson(info))
  end
end
local function isInitSuccess()
  if lastServerName == "" or ed.getUserid() == "" and not EDFLAGWIN32 then
    return false
  end
  return true
end
function serverLogin.selectServer()
  if isInitSuccess() == false then
    return
  end
  if selectServerContainer then
    selectServerContainer:setVisible(true)
    enterContainer:setVisible(false)
    if getServerInfo(lastServerName) then
      ed.setString(panelui.lastserverstate, getServerInfo(lastServerName).state)
      buttonList.selectlastserve:setVisible(true)
      ed.setString(panelui.lastservername, lastServerName)
    end
  end
end
function serverLogin.selectLastServer()
  serverLogin.refreshCurrentServerInfo(lastServerName)
end
local function doEnterGameTouch(self, event, x, y)
  if not HGFLAGANDROID then
    return
  end
  local button = buttonList.entergame
  local press = self.buttonPress.entergame
  if event == "began" then
    if ed.containsPoint(button, x, y) then
      self.isPressEnterGame = true
      press:setVisible(true)
    end
  elseif event == "ended" then
    local k = self.isPressEnterGame
    self.isPressEnterGame = nil
    if k then
      press:setVisible(false)
      if ed.containsPoint(button, x, y) then
        --HGSDKLogin()
      end
    end
  end
end
serverLogin.doEnterGameTouch = doEnterGameTouch
function serverLogin:doMainLayerTouch()
  local function handler(event, x, y)
    if isInitSuccess() == false then
      self:doEnterGameTouch(event, x, y)
      return true
    end
    if event == "began" then
      for k, v in pairs(buttonList) do
        if ed.checkVisible(v) and ed.containsPoint(v, x, y) then
          if self.buttonPress[k] ~= nil then
            self.buttonPress[k]:setVisible(true)
            v:setVisible(false)
          end
          self.currentPressName = k
        end
      end
    elseif event == "ended" then
      if self.currentPressName == nil or self.currentPressName == "" then
        return false
      end
      buttonList[self.currentPressName]:setVisible(true)
      if self.buttonPress[self.currentPressName] ~= nil then
        self.buttonPress[self.currentPressName]:setVisible(false)
      end
      if ed.containsPoint(buttonList[self.currentPressName], x, y) then
        xpcall(function()
          serverLogin[buttonHandle[self.currentPressName]](self)
        end, EDDebug)
        self.currentPressName = ""
      end
    end
    return true
  end
  return handler
end
function serverLogin.getOldDeviceId()
  return oldDevideId
end
function serverLogin:doPressInList()
  local function handler(x, y)
    for i = 1, #serverList do
      if ed.containsPoint(serverList[i].highlightbg, x, y) and selectServerContainer:isVisible() then
        serverList[i].highlightbg:setVisible(true)
        return i
      end
    end
  end
  return handler
end
function serverLogin:doClickInServerHandler(clickHandler)
  local function handler(id)
    if serverListData[id] then
      self.refreshCurrentServerInfo(serverListData[id].name)
    end
  end
  return handler
end
function serverLogin:doClickInList(clickHandler)
  local function handler(x, y, id)
    if serverList[id] then
      if not ed.containsPoint(serverList[id].highlightbg, x, y) then
        return
      end
      if clickHandler then
        clickHandler(id)
      end
    end
  end
  return handler
end
function serverLogin:cancelPressInList()
  local function handler(x, y, id)
    serverList[id].highlightbg:setVisible(false)
  end
  return handler
end
function serverLogin:cancelClickInList()
  local function handler(x, y, id)
    serverList[id].bg:setScale(1)
    serverList[id].highlightbg:setVisible(false)
  end
  return handler
end
function serverLogin:createServer(info)
  if info.name == nil or info.name == "" then
    return
  end
  local progressColor = {
    ccc3(70, 114, 0),
    ccc3(138, 56, 1)
  }
  local board = {}
  local bg = CCSprite:create()
  board.bg = bg
  local color = info.color and ed.toccc3(info.color) or stateColor[info.state]
  local ui_info = {
    {
      t = "Scale9Sprite",
      base = {
        name = "highlightbg",
        res = "installer/serverselect_highlight_bg.png",
        capInsets = CCRectMake(80, 10, 190, 12)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(150, 71)
      },
      config = {
        scaleSize = CCSizeMake(390, 42),
        visible = false
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "lineinfo",
        res = "installer/serverselect_delimiter.png",
        capInsets = CCRectMake(80, 0, 190, 2)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(150, 50)
      },
      config = {
        scaleSize = CCSizeMake(390, 2)
      }
    },
    {
      t = "Label",
      base = {
        name = "servername",
        text = info.name,
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ccp(40, 71)
      },
      config = {color = color}
    },
    {
      t = "Label",
      base = {
        name = "serverstate",
        text = info.state,
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ccp(230, 71)
      },
      config = {color = color}
    }
  }
  local readNode = ed.readnode.create(bg, board)
  readNode:addNode(ui_info)
  board.info = info
  self.draglist:addItem(bg)
  return board
end
function serverLogin:refreshList()
  for i = 1, #serverList do
    serverList[i].bg:setPosition(ccp(250, 200 - 42 * (i - 1)))
  end
  self.draglist:initListHeight(42 * #serverList + 20)
end
function serverLogin:createListLayer()
  if self.draglist ~= nil then
    return
  end
  local info = {
    cliprect = CCRectMake(200, 90, 400, 200),
    noshade = true,
    container = selectServerContainer,
    doPressIn = self:doPressInList(),
    doClickIn = self:doClickInList(self:doClickInServerHandler()),
    cancelPressIn = self:cancelPressInList(),
    cancelClickIn = self:cancelClickInList()
  }
  self.draglist = ed.draglist.create(info)
end
function serverLogin:initServerList()
  for i, v in ipairs(serverListData) do
    table.insert(serverList, self:createServer(v))
  end
end
function serverLogin.onExitFramework()
  selectServerContainer = nil
  enterContainer = nil
  buttonList = {}
  panelui = {}
  serverListData = {}
  EDServerList = {}
  serverList = {}
end
local function closeEvent()
  if initServerEvent then
    CloseTimer(initServerEvent.Name)
    initServerEvent = nil
  end
  if redoInitServerEvent then
    CloseTimer(redoInitServerEvent.Name)
    redoInitServerEvent = nil
  end
  ed.loadEnd()
end
function serverLogin:initServer()
  lastServerName = CCUserDefault:sharedUserDefault():getStringForKey("lastservername")
  closeEvent()
  self:createListLayer()
  self:initServerList()
  self:refreshList()
  if lastServerName == "" then
    lastServerName = getServerName(1)
  end
  if lastServerName ~= "" then
    ed.setString(panelui.lastservername, lastServerName)
    ed.setString(panelui.servername, lastServerName)
  end
end
function serverLogin:doInitServer()
  closeEvent()
  if #serverListData ~= 0 then
    return
  end
  ed.loadBegin(false)
  initServerEvent = ListenTimer(Timer:Always(1), function()
    local file = HGFileFromPatchServer("serverlist.txt")
    local bSucess = file and file ~= ""
    if bSucess then
      serverListData = loadstring(file)()
      self:initServer()
    end
  end)
  redoInitServerEvent = ListenTimer(Timer:Once(5), function()
    local text = T(LSTR("SERVERLOGIN.FAILED_TO_CONNECT_TO_SERVER"))
    local info = {
      text = text,
      buttonText = T(LSTR("SERVERLOGIN.RECONNECT")),
      handler = function()
        xpcall(function()
          self:doInitServer()
          if initServerEvent then
          end
        end, EDDebug)
      end
    }
    ed.showAlertDialog(info)
  end)
end
function serverLogin:enterGame()
  if isInitSuccess() == false then
    return
  end
  serverLogin.refreshCurrentServerInfo(lastServerName)
  if game_server_ip == nil then
    return
  end
  CCUserDefault:sharedUserDefault():setStringForKey("lastservername", lastServerName)
  if bSDKLoginSucess then
    ed.replaceScene(ed.ui.logo.create(sessionId))
  else
    local login = ed.upmsg.sdk_login()
    login._session_key = sessionId
    login._plat_id = HGSDKType
    ed.send(login, "sdk_login")
  end
end
function serverLogin:onEnterFramework()
  local function handler()
--    if HGFLAGANDROID then
      FireEvent("SDKInit")
--    end
    if selectServerContainer then
      selectServerContainer:setVisible(false)
    end
  end
  return handler
end

local loginSDK = function()
  local text = T(LSTR("SERVERLOGIN.LOGIN_FAILED_PLEASE_TRY_AGAIN"))
  local info = {
    text = text,
    buttonText = T(LSTR("ERRORNET.RETRY")),
    handler = function()
      xpcall(function()
        HGSDKLogin()
      end, EDDebug)
    end
  }
  ed.showAlertDialog(info)
end

function serverLogin:OnSDKLogin()
  local function handler(success, session, uin, userId, serverId,serverIP,serverPort)
    if success then
      sessionId = session
      game_server_id = serverId
      game_server_ip = serverIP
      game_server_port = serverPort
      ed.setCryptKey(sessionId)
      ed.setDeviceId(uin)
      ed.setUserid(tonumber(userId))
      local scene = CCDirector:sharedDirector():getRunningScene()
      if(scene) then
        ed.replaceScene(ed.ui.logo.create(sessionId))
      else
        ed.pushScene(ed.ui.logo.create(sessionId))
      end
    else
      loginSDK()
    end
  end
  return handler
end

function serverLogin:OnDebugLogin()
  local function handler()
    CloseEvent("DebugLogin")
    ed.setUserid(tonumber(ed.config.uin))
    game_server_ip = ed.config.server
    game_server_port = ed.config.port
    game_server_id = ed.config.serverId
    ed.setDeviceId(ed.config.uin)
    sessionId = ed.config.sessionId
    ed.setCryptKey(sessionId)
    local scene = CCDirector:sharedDirector():getRunningScene()
    if(scene) then
      ed.replaceScene(ed.ui.logo.create(sessionId))
    else
      ed.pushScene(ed.ui.logo.create(sessionId))
    end
  end
  return handler
end

function serverLogin.getClientVersion()
  return clientVersion
end

local createHeroFca = function(self,baseScene)
  hid = 3;
  HGLog("create HeroFca ".. hid);
  local testAction = "atk2"
  puppet, cha = ed.readhero.getActor(hid, testAction)
  puppet:setPosition(ccp(330, 275))
  self:addChild(puppet, 110)
  baseScene:addFca(puppet)
  puppet:setAction(testAction)
  puppet:tint(0.4,0.4,0.4)
  puppet:tint(2.5,2.5,2.5)
end

function serverLogin.create()
  local newscene = base.create("serverlogin")
  setmetatable(newscene, serverLogin)
  local scene = newscene.scene
  local mainLayer = CCLayer:create()
  newscene.mainLayer = mainLayer
  scene:addChild(mainLayer)
  --mainLayer:setTouchEnabled(true)
  --mainLayer:registerScriptTouchHandler(newscene:doMainLayerTouch(), false, 0, false)
  newscene.buttonPress = {}
  newscene.buttonLabel = {}
  local bg = ed.createSprite("installer/splash.jpg")
  bg:setPosition(ccp(400, 240))
  mainLayer:addChild(bg)
  local logo = ed.createSprite("installer/logo.png")
  logo:setPosition(ccp(660, 402))
  mainLayer:addChild(logo)
  enterContainer = CCSprite:create()
  mainLayer:addChild(enterContainer)
  local ui_select = {
    {
      t = "Scale9Sprite",
      base = {
        name = "selectserverbg",
        res = "installer/serverselect_serverlist_bg.png",
        capInsets = CCRectMake(15, 10, 142, 16)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 200)
      },
      config = {
        scaleSize = CCSizeMake(400, 266)
      }
    },
    {
      t = "Label",
      base = {
        name = "allserver",
        text = T(LSTR("SERVERLOGIN.ALL_SERVERS")),
        size = 20
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 310)
      },
      config = {
        color = ccc3(255, 255, 255)
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "selectserverbg",
        res = "installer/serverselect_serverlist_bg.png",
        capInsets = CCRectMake(15, 10, 142, 16)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 380)
      },
      config = {
        scaleSize = CCSizeMake(400, 90)
      }
    },
    {
      t = "Sprite",
      base = {
        name = "selectlastserve",
        array = buttonList
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 362)
      },
      config = {
        messageRect = CCRectMake(0, 0, 400, 42)
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "selectlastserve",
        array = newscene.buttonPress,
        res = "installer/serverselect_highlight_bg.png",
        capInsets = CCRectMake(80, 10, 190, 12)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 362)
      },
      config = {
        scaleSize = CCSizeMake(400, 42),
        visible = false
      }
    },
    {
      t = "Label",
      base = {
        name = "lastservername",
        text = "",
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ccp(290, 362)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    },
    {
      t = "Label",
      base = {
        name = "lastserverstate",
        text = "",
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ccp(480, 362)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    },
    {
      t = "Label",
      base = {
        name = "allserver",
        text = T(LSTR("SERVERLOGIN.LAST_SIGN")),
        size = 20
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 403)
      },
      config = {
        color = ccc3(255, 255, 255)
      }
    }
  }
  selectServerContainer = CCSprite:create()
  --mainLayer:addChild(selectServerContainer)
  local readNode = ed.readnode.create(selectServerContainer, panelui)
  --readNode:addNode(ui_select)
  local ui_enter = {
    {
      t = "Scale9Sprite",
      base = {
        name = "entergame",
        array = buttonList,
        res = "installer/serverselect_confirm_button_1.png",
        capInsets = CCRectMake(10, 10, 28, 29)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 50)
      },
      config = {
        scaleSize = CCSizeMake(183, 59)
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "entergame",
        array = newscene.buttonPress,
        res = "installer/serverselect_confirm_button_2.png",
        capInsets = CCRectMake(10, 10, 28, 29)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 50)
      },
      config = {
        scaleSize = CCSizeMake(183, 59),
        visible = false
      }
    },
    {
      t = "Label",
      base = {
        name = "entergame",
        array = newscene.buttonLabel,
        text = T(LSTR("SERVERLOGIN.ENTER_THE_GAME")),
        size = 24
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 50)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "bg",
        res = "installer/serverselect_serverlist_bg.png",
        capInsets = CCRectMake(15, 10, 142, 16)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 110)
      },
      config = {
        scaleSize = CCSizeMake(400, 60)
      }
    },
    {
      t = "Sprite",
      base = {
        name = "selectserver",
        array = buttonList
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 110)
      },
      config = {
        messageRect = CCRectMake(0, 0, 350, 42)
      }
    },
    {
      t = "Scale9Sprite",
      base = {
        name = "selectserver",
        array = newscene.buttonPress,
        res = "installer/serverselect_highlight_bg.png",
        capInsets = CCRectMake(80, 10, 190, 12)
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(400, 111)
      },
      config = {
        scaleSize = CCSizeMake(400, 45),
        visible = false
      }
    },
    {
      t = "Label",
      base = {
        name = "selectserver",
        text = T(LSTR("SERVERLOGIN.CLICK_TO_CHANGE_REGION")),
        size = 18
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(540, 110)
      },
      config = {
        color = ccc3(255, 255, 255)
      }
    },
    {
      t = "Label",
      base = {
        name = "servername",
        text = "",
        size = 18
      },
      layout = {
        anchor = ccp(0.5, 0.5),
        position = ccp(300, 110)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    },
    {
      t = "Label",
      base = {
        name = "ui",
        text = T(LSTR("SERVERLOGIN.VERSION_")),
        size = 18
      },
      layout = {
        anchor = ccp(0, 0),
        position = ccp(600, 15)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    },
    {
      t = "Label",
      base = {
        name = "version",
        text = "",
        size = 18
      },
      layout = {
        anchor = ccp(0, 0),
        position = ccp(670, 15)
      },
      config = {
        color = ccc3(251, 206, 16)
      }
    }
  }
  local readNode = ed.readnode.create(enterContainer, panelui)
  --readNode:addNode(ui_enter)
  local version = CCUserDefault:sharedUserDefault():getStringForKey("current-version")
 -- version = string.match(version, "%d+%.%d+%.%d+%.%d+$")
  if version ~= nil then
 --   clientVersion = string.sub(version, 0, -5)
    ed.setString(panelui.version, clientVersion)
  end
  enterContainer:setVisible(true)
  newscene:registerOnEnterHandler("onEnterFramework", newscene:onEnterFramework())
  newscene:registerOnExitHandler("onExitFramework", newscene.onExitFramework)
  ed.playMusic(ed.music.map)
  if oldDevideId == "" then
    oldDevideId = ed.getDeviceId()
  end
  CloseEvent("SDKLogin")
  ListenEvent("SDKLogin", newscene:OnSDKLogin())
  
  CloseEvent("GoogleConnectResponse")
  ListenEvent("GoogleConnectResponse", function(stateStr)
    local state = false
    if "true" == stateStr then
      state = true
    else
      state = false
    end
    HGLog("+++Lua+++ GoogleConnectResponse: "..stateStr)
    ed.player.isGoogleLinked = state
  end)
  
  CloseEvent("SDKLoginRsp")
  ListenEvent("SDKLoginRsp", function(result)
    if result == "fail" then
      loginSDK()
    elseif result == "success" then
      bSDKLoginSucess = true
      if sessionId ~= "" then
        ed.setCryptKey(sessionId)
      end
      ed.replaceScene(ed.ui.logo.create(sessionId))
    end
  end)
  CloseEvent("DebugLogin")
  ListenEvent("DebugLogin", newscene:OnDebugLogin())

  --TEST ONLY
--  HGLog("create fca")
--  createHeroFca(mainLayer,newscene);

--  local node = ed.createFcaNode( "eff_UI_Main_Guard");
--  node:setScale(1)
--  newscene:addFca(node)
--  node:setPosition(ccp(400, 200))
--   mainLayer:addChild(node,5);
--TEST ONLY

  return newscene
end
local OnSDKInit = function()
  HGSDKLogin()
  HGEnableSDKUI(0)
end
ListenEvent("SDKInit", OnSDKInit)

local OnEnterGroud = function()
  local function handler(enterType)
  
  	HGLog("applicationWillEnterForeground OnEnterGroud")
  
  
    if enterType == 1 then
    	
      ed.applicationDidEnterBackground()
    else
    	HGLog("applicationWillEnterForeground OnEnterGroud 2")
      ed.applicationWillEnterForeground()
    end
  end
  return handler
end
ListenEvent("EnterGroud", OnEnterGroud())

local OnPrintError = function()
  local function handler(errorInfo)
    ListenTimer(Timer:Once(0.5), function()
      ed.popScene()
    end)
    ListenTimer(Timer:Once(1), function()
      EDDebug(errorInfo)
    end)
  end
  return handler
end
ListenEvent("PrintError", OnPrintError())

