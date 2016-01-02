function DSM.Gui.centerPanel(panel)
  local screenWidth = ScrW()
  local screenHeight = ScrH()
  local panelWidth = panel:GetWide()
  local panelHeight = panel:GetTall()
  local xPosition =  (screenWidth - panelWidth) / 2
  local yPosition = (screenHeight - panelHeight) / 2
  panel:SetPos( xPosition, yPosition )
end