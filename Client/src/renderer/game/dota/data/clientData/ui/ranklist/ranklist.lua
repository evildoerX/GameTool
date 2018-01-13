local base = ed.ui.basescene
local class = newclass(base.mt)
ed.ui.ranklist = class
class.ranklist_config = {
  {
    mode = "pvp",
    name = T(LSTR("ranklist.1.10.1.001")),
    initHandler = function(self, callback)
      if self.pvpRanklist then
        if callback then
          callback()
        else
          self:initListLayer("pvp")
        end
      else
        ed.registerNetReply("query_pvp_ranklist", function(list)
          self.pvpRanklist = list
          if callback then
            callback()
          else
            self:initListLayer("pvp")
          end
        end)
        local msg = ed.upmsg.ladder()
        msg._query_rankboard = {}
        ed.send(msg, "ladder")
      end
    end
  },
  {
    mode = "guildliveness",
    name = T(LSTR("ranklist.1.10.1.002")),
    initHandler = function(self, callback)
      if self.glRankList then
        if callback then
          callback()
        else
          self:initListLayer("guildliveness")
        end
      else
        ed.registerNetReply("query_ranklist", function(data)
          self.glRankList = data._summary
          self.glSelfRank = data._self_ranking
          self.glSelfSummary = data._self_summary
          if callback then
            callback()
          else
            self:initListLayer("guildliveness")
          end
        end)
        local msg = ed.upmsg.query_ranklist()
        msg._rank_type = "guildliveness"
        ed.send(msg, "query_ranklist")
      end
    end
  }
}
class.title_scale_large = 1
class.title_scale_middle = 0.75
class.title_scale_small = 0.6
local registerTouchHandler = function(self)
  local ui = self.ui
  self:btRegisterButtonClick({
    button = ui.back_button,
    press = ui.back_button_press,
    key = "back_button",
    clickHandler = function()
      ed.popScene()
    end,
    clickInterval = 0.5
  })
  self:btRegisterRectClick({
    rect = ed.DGRectMake(0, 0, 205, 70),
    parent = ui.title_bg,
    key = "title_bg_left",
    clickHandler = function()
      self:registerOperation("pre")
    end,
    clickInterval = 0.2
  })
  self:btRegisterRectClick({
    rect = ed.DGRectMake(538, 0, 205, 70),
    parent = ui.title_bg,
    key = "title_bg_right",
    clickHandler = function()
      self:registerOperation("next")
    end,
    clickInterval = 0.2
  })
end
class.registerTouchHandler = registerTouchHandler
local initpvpItemHandler = function(self)
  local function handler(param)
    local index = param.index
    local data = param.data
    local summary = data._summary
    local container = param.container
    local board = ed.createNode({
      t = "Scale9Sprite",
      base = {
        res = data._user_id == ed.getUserid() and "UI/alpha/HVGA/pvp/pvp_rank_bg_green.png" or "UI/alpha/HVGA/pvp/pvp_rank_bg_high.png",
        capInsets = ed.DGRectMake(65, 25, 545, 25)
      },
      layout = {
        anchor = ccp(0, 1)
      },
      config = {
        scaleSize = ed.DGSizeMake(650, 95)
      }
    }, container)
    local ranking
    if index == 1 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_1st.png")
    elseif index == 2 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_2nd.png")
    elseif index == 3 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_3rd.png")
    else
      ranking = ed.getNumberNode({text = index, folder = "big_pvp"}).node
    end
    ranking:setPosition(ed.DGccp(60, 50))
    board:addChild(ranking)
    local head = ed.getTeamHead({
      id = summary._avatar,
      vip = 0 < summary._vip
    })
    head:setPosition(ed.DGccp(175, 50))
    board:addChild(head)
    local nameBg = ed.createNode({
      t = "Sprite",
      base = {
        res = "UI/alpha/HVGA/task_name_bg.png"
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(250, 52)
      }
    }, board)
    local level = ed.getLevelIcon({
      level = summary._level,
      vip = 0 < summary._vip
    })
    level:setPosition(ed.DGccp(250, 50))
    board:addChild(level)
    local name = ed.createNode({
      t = "Label",
      base = {
        text = summary._name,
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(280, 52)
      }
    }, board)
    ed.setNodeAnchor(board, ccp(0.5, 0.5))
    self:btRegisterButtonClick({
      button = board,
      pressScale = 0.95,
      mcpMode = true,
      key = "pvp_item_" .. index,
      force = true,
      clickInterval = 0.3,
      extraCheckHandler = function(x, y)
        if self.scrollView:checkTouchInList(x, y) then
          return true
        end
        return false
      end,
      clickHandler = function()
        ed.registerNetReply("query_pvp_oppo", function(data)
          if not tolua.isnull(self.mainLayer) then
            self.mainLayer:addChild(self.usersummary.create(data).mainLayer, 100)
          end
        end)
        local msg = ed.upmsg.ladder()
        msg._query_oppo = {}
        msg._query_oppo._oppo_user_id = data._user_id
        ed.send(msg, "ladder")
      end
    })
    return {
      icon = board,
      ranking = ranking,
      head = head
    }
  end
  return handler
end
class.initpvpItemHandler = initpvpItemHandler
local initglItemHandler = function(self)
  local function handler(param)
    local container = param.container
    local index = param.index
    local data = param.data
    local board = ed.createNode({
      t = "Scale9Sprite",
      base = {
        res = data._id == ed.player:getGuildId() and "UI/alpha/HVGA/pvp/pvp_rank_bg_green.png" or "UI/alpha/HVGA/pvp/pvp_rank_bg_high.png",
        capInsets = ed.DGRectMake(65, 25, 545, 25)
      },
      layout = {
        anchor = ccp(0, 1)
      },
      config = {
        scaleSize = ed.DGSizeMake(650, 95)
      }
    }, container)
    ed.setNodeAnchor(board, ccp(0.5, 0.5))
    local ranking
    if index == 1 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_1st.png")
    elseif index == 2 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_2nd.png")
    elseif index == 3 then
      ranking = ed.createSprite("UI/alpha/HVGA/pvp/pvp_rank_3rd.png")
    else
      ranking = ed.getNumberNode({text = index, folder = "big_pvp"}).node
    end
    ranking:setPosition(ed.DGccp(60, 50))
    board:addChild(ranking)
    local head = ed.readequip.createIcon(nil, 60, 1, {
      fres = ed.getDataTable("GuildAvatar")[data._avatar].Picture
    })
    head:setPosition(ed.DGccp(175, 48))
    board:addChild(head, 5)
    local nameBg = ed.createNode({
      t = "Sprite",
      base = {
        res = "UI/alpha/HVGA/task_name_bg.png"
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(200, 66)
      }
    }, board)
    local name = ed.createNode({
      t = "Label",
      base = {
        text = data._name,
        size = 18
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(215, 68)
      }
    }, board)
    local livenessTitle = ed.createNode({
      t = "Label",
      base = {
        text = T(LSTR("ranklist.1.10.1.003")),
        size = 18
      },
      config = {
        color = ccc3(134, 53, 4)
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(215, 28)
      }
    }, board)
    local liveness = ed.createNode({
      t = "Label",
      base = {
        text = data._liveness,
        size = 18
      },
      config = {
        color = ccc3(134, 53, 4)
      },
      layout = {
        anchor = ccp(0, 0.5),
        position = ed.DGccp(400, 28)
      }
    }, board)
    self:btRegisterButtonClick({
      button = board,
      pressScale = 0.95,
      mcpMode = true,
      key = "guildliveness_item_" .. index,
      force = true,
      clickInterval = 0.3,
      extraCheckHandler = function(x, y)
        if self.scrollView:checkTouchInList(x, y) then
          return true
        end
        return false
      end,
      clickHandler = function()
        package.loaded["ui/ranklist/guildsummary"] = nil
        require("ui/ranklist/guildsummary")
        self.mainLayer:addChild(self.guildsummary.create(index, data).mainLayer, 100)
      end
    })
    return {icon = board}
  end
  return handler
end
class.initglItemHandler = initglItemHandler
local initListLayer = function(self, mode)
  local init_handler = {
    pvp = self:initpvpItemHandler(),
    guildliveness = self:initglItemHandler()
  }
  local info = {
    cliprect = CCRectMake(144, 26, 512, 380),
    noshade = true,
    zorder = 10,
    container = self.container,
    priority = -10,
    direction = "v",
    pageSize = CCSizeMake(1, 1),
    oriPosition = ed.DGccp(185, 500),
    itemSize = ed.DGSizeMake(512, 105),
    initHandler = init_handler[mode],
    useBar = true,
    barPosition = "left",
    barLenOffset = -10,
    barPosOffset = ccp(-8, -2),
    barThick = 3,
    heightOffset = 10
  }
  local scrollView = ed.scrollview.create(info)
  self.scrollView = scrollView
  if mode == "pvp" then
    local list = self.pvpRanklist
    for i, v in ipairs(list) do
      scrollView:push({index = i, data = v})
    end
  elseif mode == "guildliveness" then
    local list = self.glRankList or {}
    for i, v in ipairs(list) do
      scrollView:push({index = i, data = v})
    end
    if self.glSelfRank and self.glSelfRank > #list then
      scrollView:push({
        index = self.glSelfRank,
        data = self.glSelfSummary
      })
    end
  end
end
class.initListLayer = initListLayer
local doPushPage = function(self, mode)
  local k = 1
  if mode == "pre" then
    k = -1
  end
  self.index = self.index + k
  local handler = self.ranklist_config[self.index].initHandler
  handler(self, function()
    if mode == "pre" then
      self:pushPreTitle()
    elseif mode == "next" then
      self:pushNextTitle()
    end
    local psv = self.scrollView
    psv:setTouchEnabled(false)
    self:initListLayer(self.ranklist_config[self.index].mode)
    self.scrollView:setTouchEnabled(false)
    local sv = self.scrollView
    sv.draglist.listLayer:setPosition(ed.DGccp(725 * k, 0))
    psv:doMoveLayer(ed.DGccp(-725 * k, 0), function()
      psv:destroy()
    end)
    sv:doMoveLayer(ed.DGccp(0, 0), function()
      self.lockTurnPage = nil
      self.scrollView:setTouchEnabled(true)
    end)
    self:refreshArrow()
  end)
end
class.doPushPage = doPushPage
local pushPreTitle = function(self)
  local ui = self.ui
  local temp = ui.rightTitle
  ui.rightTitle = ui.title
  ui.title = ui.leftTitle
  ui.leftTitle = ed.createNode({
    t = "Label",
    base = {
      text = (self.ranklist_config[self.index - 1] or {}).name or "",
      size = 24
    },
    layout = {
      position = ed.DGccp(148, 560)
    },
    config = {
      color = ccc3(248, 159, 120),
      scale = self.title_scale_small,
      opacity = 0
    }
  }, self.container)
  ui.leftTitle:runAction(ed.readaction.create({
    t = "sp",
    CCFadeIn:create(0.2),
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(248, 560))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_middle))
  }))
  ui.title:runAction(ed.readaction.create({
    t = "sp",
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(512, 562))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_large))
  }))
  ui.rightTitle:runAction(ed.readaction.create({
    t = "sp",
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(776, 560))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_middle))
  }))
  temp:runAction(ed.readaction.create({
    t = "seq",
    {
      t = "sp",
      CCFadeOut:create(0.2),
      CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(876, 560))),
      CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_small))
    },
    CCCallFunc:create(function()
      xpcall(function()
        temp:removeFromParentAndCleanup(true)
      end, EDDebug)
    end)
  }))
  self:registerUpdateHandler("title_color", ed.readaction.getColorChangeHandler({
    label = ui.title,
    origin = ccc3(248, 159, 120),
    target = ccc3(255, 214, 17),
    duration = 0.2,
    callback = function()
      self:removeUpdateHandler("title_color")
    end
  }))
  self:registerUpdateHandler("right_title_color", ed.readaction.getColorChangeHandler({
    label = ui.rightTitle,
    origin = ccc3(255, 214, 17),
    target = ccc3(248, 159, 120),
    duration = 0.2,
    callback = function()
      self:removeUpdateHandler("right_title_color")
    end
  }))
end
class.pushPreTitle = pushPreTitle
local pushNextTitle = function(self)
  local ui = self.ui
  local temp = ui.leftTitle
  ui.leftTitle = ui.title
  ui.title = ui.rightTitle
  ui.rightTitle = ed.createNode({
    t = "Label",
    base = {
      text = (self.ranklist_config[self.index + 1] or {}).name or "",
      size = 24
    },
    layout = {
      position = ed.DGccp(876, 560)
    },
    config = {
      color = ccc3(248, 159, 120),
      scale = self.title_scale_small,
      opacity = 0
    }
  }, self.container)
  ui.leftTitle:runAction(ed.readaction.create({
    t = "sp",
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(248, 560))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_middle))
  }))
  ui.title:runAction(ed.readaction.create({
    t = "sp",
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(512, 562))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_large))
  }))
  ui.rightTitle:runAction(ed.readaction.create({
    t = "sp",
    CCFadeIn:create(0.2),
    CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(776, 560))),
    CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_middle))
  }))
  temp:runAction(ed.readaction.create({
    t = "seq",
    {
      t = "sp",
      CCFadeOut:create(0.2),
      CCEaseSineOut:create(CCMoveTo:create(0.2, ed.DGccp(148, 560))),
      CCEaseSineOut:create(CCScaleTo:create(0.2, self.title_scale_small))
    },
    CCCallFunc:create(function()
      xpcall(function()
        temp:removeFromParentAndCleanup(true)
      end, EDDebug)
    end)
  }))
  self:registerUpdateHandler("title_color", ed.readaction.getColorChangeHandler({
    label = ui.title,
    origin = ccc3(248, 159, 120),
    target = ccc3(255, 214, 17),
    duration = 0.2,
    callback = function()
      self:removeUpdateHandler("title_color")
    end
  }))
  self:registerUpdateHandler("left_title_color", ed.readaction.getColorChangeHandler({
    label = ui.leftTitle,
    origin = ccc3(255, 214, 17),
    target = ccc3(248, 159, 120),
    duration = 0.2,
    callback = function()
      self:removeUpdateHandler("left_title_color")
    end
  }))
end
class.pushNextTitle = pushNextTitle
local initTitle = function(self)
  local ui = self.ui
  ui.leftTitle = ed.createNode({
    t = "Label",
    base = {
      text = (self.ranklist_config[self.index - 1] or {}).name or "",
      size = 24
    },
    layout = {
      position = ed.DGccp(248, 562)
    },
    config = {
      color = ccc3(248, 159, 120),
      scale = self.title_scale_middle
    }
  }, self.container)
  ui.title = ed.createNode({
    t = "Label",
    base = {
      text = (self.ranklist_config[self.index] or {}).name or "",
      size = 24
    },
    layout = {
      position = ed.DGccp(512, 562)
    },
    config = {
      color = ccc3(255, 214, 17)
    }
  }, self.container)
  ui.rightTitle = ed.createNode({
    t = "Label",
    base = {
      text = (self.ranklist_config[self.index + 1] or {}).name or "",
      size = 24
    },
    layout = {
      position = ed.DGccp(776, 562)
    },
    config = {
      color = ccc3(248, 159, 120),
      scale = self.title_scale_middle
    }
  }, self.container)
end
class.initTitle = initTitle
local initArrow = function(self)
  local ui = self.ui
  ui.left_arrow:runAction(ed.readaction.create({
    t = "seq",
    isRepeat = true,
    CCFadeOut:create(1),
    CCFadeIn:create(1)
  }))
  ui.right_arrow:runAction(ed.readaction.create({
    t = "seq",
    isRepeat = true,
    CCFadeOut:create(1),
    CCFadeIn:create(1)
  }))
  self:btRegisterCircleClick({
    center = ed.getCenterPos(ui.left_arrow),
    radius = 50,
    parent = ui.left_arrow,
    pressHandler = function()
      ui.left_arrow:setScale(0.95)
    end,
    cancelPressHandler = function()
      ui.left_arrow:setScale(1)
    end,
    key = "left_arrow",
    force = true,
    clickHandler = function()
      self:registerOperation("pre")
    end,
    priority = -10
  })
  self:btRegisterCircleClick({
    center = ed.getCenterPos(ui.right_arrow),
    radius = 50,
    parent = ui.right_arrow,
    pressHandler = function()
      ui.right_arrow:setScale(0.95)
    end,
    cancelPressHandler = function()
      ui.right_arrow:setScale(1)
    end,
    key = "right_arrow",
    force = true,
    clickHandler = function()
      self:registerOperation("next")
    end,
    priority = -10
  })
  local px, py
  self:btRegisterHandler({
    key = "drag_horizontal",
    handler = function(event, x, y)
      if event == "began" then
        px, py = x, y
      elseif event == "ended" and math.abs(x - px) > math.abs(y - py) then
        if x - px > 100 then
          self:registerOperation("pre")
        elseif x - px < -100 then
          self:registerOperation("next")
        end
      end
    end,
    force = true
  })
  self:refreshArrow()
end
class.initArrow = initArrow
local refreshArrow = function(self)
  local ui = self.ui
  ui.left_arrow:setVisible(false)
  ui.right_arrow:setVisible(false)
  if self.index > 1 then
    ui.left_arrow:setVisible(true)
  end
  if self.index < #self.ranklist_config then
    ui.right_arrow:setVisible(true)
  end
end
class.refreshArrow = refreshArrow
local registerOperation = function(self, operation)
  self.operations = self.operations or {}
  table.insert(self.operations, operation)
end
class.registerOperation = registerOperation
local removeOperation = function(self)
  self.operations = self.operations or {}
  if #self.operations > 0 then
    table.remove(self.operations, 1)
  end
end
class.removeOperation = removeOperation
local doTurnPage = function(self)
  local function handler()
    if self.lockTurnPage then
      return
    end
    self.operations = self.operations or {}
    local operations = self.operations
    if #operations == 0 then
      return
    end
    local opt = operations[1]
    self:removeOperation()
    if opt == "pre" then
      if 1 < self.index then
        self.lockTurnPage = true
        self:doPushPage("pre")
      end
    elseif opt == "next" and self.index < #self.ranklist_config then
      self.lockTurnPage = true
      self:doPushPage("next")
    end
  end
  return handler
end
class.doTurnPage = doTurnPage
local function create(param)
  param = param or {}
  local self = base.create("ranklist")
  setmetatable(self, class.mt)
  local mainLayer = self.mainLayer
  self.container, self.ui = ed.editorui(ed.uieditor.ranklistwindow)
  local container = self.container
  self.mainLayer:addChild(container)
  self:registerUpdateHandler("turn_page", self:doTurnPage())
  self:registerTouchHandler()
  self:registerOnEnterHandler("enter_ranklist", function()
    self.ranklist_config[param.index].initHandler(self, function()
      self:initListLayer(self.ranklist_config[param.index].mode)
    end)
    self.index = param.index
    self:initArrow()
    self:initTitle()
  end)
  return self
end
class.create = create
