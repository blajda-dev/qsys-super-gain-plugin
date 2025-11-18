local CurrentPage = PageNames[props["page_index"].Value]

if CurrentPage == "Control" then
  gainControl = { 
    Style = "Fader",
    Position = {25, 5},
    Size = {75, 250},
    Color = {124, 155, 207},
  }

  muteControl = { 
    Style = "Button",
    Position = {25, 255},
    Size = {75, 50},
    Color = {223, 0, 36},
    FontSize = 18,
    Legend = "Mute",
    PrettyName = "Controls~Mute"
  }

  externalGainControl = { 
    Style = "None",
    Position = {5, 5},
    Size = {25, 25},
    FontSize = 18,
    PrettyName = "Controls~Gain"
  }

  layout['Gain'] = gainControl
  layout['Mute'] = muteControl
  layout['GainExternal'] = externalGainControl

elseif CurrentPage == "Setup" then
  table.insert(graphics, {
    Type = "Label",
    Text = "Minimum Gain",
    Position = {5, 5},
    Size = {100, 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

  table.insert(graphics, {
    Type = "Label",
    Text = "Maximum Gain",
    Position = {105, 5},
    Size = {100, 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

  minGainControl = { 
    Style = "Knob",
    Position = {5 + (50 / 2), 60},
    Size = {50, 50},
    PrettyName = "Configuration~MinimumGain"
  }
  
  maxGainControl = { 
    Style = "Knob",
    Position = {5 + 50 + (105 / 2) + (50 / 2), 60},
    Size = {50, 50},
    PrettyName = "Configuration~MaximumGain"
  }

  layout['MinimumGain'] = minGainControl
  layout['MaximumGain'] = maxGainControl
end