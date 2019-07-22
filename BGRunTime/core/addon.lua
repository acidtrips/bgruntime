local GetBattlefieldInstanceRunTime, SecondsToTime, TIME_ELAPSED = GetBattlefieldInstanceRunTime, SecondsToTime, TIME_ELAPSED


local function SetBattlegroundRunTime(self)
  if ( GetBattlefieldInstanceRunTime() > 60000 ) then
    self.BattlegroundRunTime:Show()
    self.BattlegroundRunTime:SetText(TIME_ELAPSED.." "..SecondsToTime(GetBattlefieldInstanceRunTime()/1000, true))
  else
    self.BattlegroundRunTime:Hide()
  end
end


function BGRunTime:PLAYER_LOGIN()
  PVPMatchResults.overlay.decorator:SetAlpha(0)
  PVPMatchResults.glowTop:SetAlpha(0)
  PVPMatchResults.BattlegroundRunTime = PVPMatchResults:CreateFontString("OVERLAY", nil, "GameFontNormal")
  PVPMatchResults.BattlegroundRunTime:SetPoint("BOTTOMLEFT", 30, 80)
  PVPMatchResults:HookScript("OnShow", function(self) SetBattlegroundRunTime(self) end)
  PVPMatchScoreboard.BattlegroundRunTime = PVPMatchScoreboard:CreateFontString("OVERLAY", nil, "GameFontNormal")
  PVPMatchScoreboard.BattlegroundRunTime:SetPoint("BOTTOMLEFT", 30, 20)
  PVPMatchScoreboard:HookScript("OnShow", function(self) SetBattlegroundRunTime(self) end)
end
