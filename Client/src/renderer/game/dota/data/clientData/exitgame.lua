local ExitGame = function()
  HGAnimation:releaseAnimationFileInfo()
  LoadResources:releaseMemory()
end
ListenEvent("ExitGame", ExitGame)
