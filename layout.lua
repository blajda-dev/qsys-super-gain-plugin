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

  upControl = { 
    Style = "Button",
    Position = {5 + 75 + 5 + 5 + 5, 5},
    Size = {75, 50},
    Color = {124, 155, 207},
    FontSize = 18,
    Legend = "Up",
    PrettyName = "Controls~Up"
  }

  downControl = { 
    Style = "Down",
    Position = {5 + 75 + 5 + 5 + 5, 5 + (250 - 50)},
    Size = {75, 50},
    Color = {124, 155, 207},
    FontSize = 18,
    Legend = "Down",
    PrettyName = "Controls~Down"
  }

  layout['Gain'] = gainControl
  layout['Mute'] = muteControl
  layout['GainExternal'] = externalGainControl
  layout['Up'] = upControl
  layout['Down'] = downControl

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

  table.insert(graphics, {
    Type = "Label",
    Text = "Hold Time",
    Position = {5, 5 + 60 + 50},
    Size = {100, 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

  table.insert(graphics, {
    Type = "Label",
    Text = "Ramp Time",
    Position = {105, 5 + 60 + 50},
    Size = {100, 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

  holdTime = { 
    Style = "Text",
    Position = {5, 5 + 60 + 50 + 50},
    Size = {100, 50},
    FontSize = 18,
    PrettyName = "Configuration~Hold"
  }

  rampTime = { 
    Style = "Text",
    Position = {5 + (105 / 2) + (100 / 2), 5 + 60 + 50 + 50},
    Size = {100, 50},
    FontSize = 18,
    PrettyName = "Configuration~Time"
  }

  layout['MinimumGain'] = minGainControl
  layout['MaximumGain'] = maxGainControl
  layout['Hold'] = holdTime
  layout['Time'] = rampTime
end