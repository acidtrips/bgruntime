local GetBattlefieldInstanceRunTime, GetBattlefieldTeamInfo, IsActiveBattlefieldArena,
      IsInLFDBattlefield, SecondsToTime, TIME_ELAPSED, PLAYER_COUNT_HORDE, PLAYER_COUNT_ALLIANCE =
      GetBattlefieldInstanceRunTime, GetBattlefieldTeamInfo, IsActiveBattlefieldArena,
      IsInLFDBattlefield, SecondsToTime, TIME_ELAPSED, PLAYER_COUNT_HORDE, PLAYER_COUNT_ALLIANCE


local function UpdateBattlegroundStatus(self)
  local _, _, _, _, numHorde = GetBattlefieldTeamInfo(0)
  local _, _, _, _, numAlliance = GetBattlefieldTeamInfo(1)

  self.PlayerCount:Show()

  if ( numHorde > 0 and numAlliance > 0 ) then
    self.PlayerCount:SetText(format(PLAYER_COUNT_ALLIANCE, numAlliance).." / "..format(PLAYER_COUNT_HORDE, numHorde))
  elseif ( numAlliance > 0 ) then
    self.PlayerCount:SetFormattedText(PLAYER_COUNT_ALLIANCE, numAlliance)
  elseif ( numHorde > 0 ) then
    self.PlayerCount:SetFormattedText(PLAYER_COUNT_HORDE, numHorde)
  else
    self.PlayerCount:Hide()
  end

  if ( IsActiveBattlefieldArena() or IsInLFDBattlefield() ) then
    self.PlayerCount:Hide()
  end

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
  PVPMatchResults.PlayerCount = PVPMatchResults:CreateFontString("OVERLAY", nil, "GameFontNormal")
  PVPMatchResults.PlayerCount:SetPoint("BOTTOMRIGHT", -30, 80)
  PVPMatchResults:HookScript("OnShow", UpdateBattlegroundStatus)

  PVPMatchScoreboard.BattlegroundRunTime = PVPMatchScoreboard:CreateFontString("OVERLAY", nil, "GameFontNormal")
  PVPMatchScoreboard.BattlegroundRunTime:SetPoint("BOTTOMLEFT", 30, 20)
  PVPMatchScoreboard.PlayerCount = PVPMatchScoreboard:CreateFontString("OVERLAY", nil, "GameFontNormal")
  PVPMatchScoreboard.PlayerCount:SetPoint("BOTTOMRIGHT", -30, 20)
  PVPMatchScoreboard:HookScript("OnUpdate", UpdateBattlegroundStatus)
end
