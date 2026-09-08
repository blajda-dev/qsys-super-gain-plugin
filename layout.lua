local CurrentPage = PageNames[props["page_index"].Value]

if CurrentPage == "Control" then
  gainControl = { 
    Style = "Fader",
    Position = {25, 5},
    Size = {75, 250},
    Color = {124, 155, 207},
    PrettyName = "Gain"
  }

  muteControl = { 
    Style = "Button",
    Position = {25, 255},
    Size = {75, 50},
    Color = {223, 0, 36},
    FontSize = 18,
    Legend = "Mute",
    PrettyName = "Mute"
  }

  limitedGainOutput = { 
    Style = "None",
    Position = {5, 5},
    Size = {25, 25},
    FontSize = 18,
    PrettyName = "Gain Output"
  }

  limitedGainInput = { 
    Style = "None",
    Position = {5, 5},
    Size = {25, 25},
    FontSize = 18,
    PrettyName = "Gain Input"
  }

  upControl = { 
    Style = "Button",
    Position = {95, 5},
    Size = {75, 50},
    Color = {124, 155, 207},
    FontSize = 18,
    Legend = "Up",
    PrettyName = "Increase"
  }

  downControl = { 
    Style = "Button",
    Position = {95, 5 + (250 - 50)},
    Size = {75, 50},
    Color = {124, 155, 207},
    FontSize = 18,
    Legend = "Down",
    PrettyName = "Decrease"
  }

  layout['gain'] = gainControl
  layout['mute'] = muteControl

  layout['gain_limited_output'] = limitedGainOutput
  layout['gain_limited_input'] = limitedGainInput
  layout['stepper_increase'] = upControl
  layout['stepper_decrease'] = downControl

elseif CurrentPage == "Metering" then
  table.insert(graphics, {
    Type = "Label",
    Text = "Peak Meters",
    Position = {5, 5},
    Size = {75 + (5 * 3), 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

    outputAPeakMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~Peak~Output A"
  }

  outputBPeakMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5 + 25 + 5, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~Peak~Output B"
  }

  outputCPeakMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5 + 5 + 25 + 5 + 25, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~Peak~Output C"
  }

  table.insert(graphics, {
    Type = "Label",
    Text = "RMS Meters",
    Position = {5 + ((25 + 5) * 3), 5},
    Size = {75 + (5 * 3), 50},
    Color = {0, 0, 0},
    FontSize = 18,
    HTextAlign = "Center"
  })

  outputARMSMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5 + ((25 + 5) * 3) + 5, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~RMS~Output A"
  }

  outputBRMSMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5 + ((25 + 5) * 3) + 25 + 10, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~RMS~Output B"
  }

  outputCRMSMeter = { 
    Style = "Meter",
    MeterStyle = "Standard",
    Position = {5 + ((25 + 5) * 3) + 50 + 15, 55},
    Size = {25, 250},
    Color = {124, 155, 207},
    PrettyName = "Meter~RMS~Output C"
  }

  layout['output_peak_meter 1'] = outputAPeakMeter
  layout['output_peak_meter 2'] = outputBPeakMeter
  layout['output_peak_meter 3'] = outputCPeakMeter

  layout['output_rms_meter 1'] = outputARMSMeter
  layout['output_rms_meter 2'] = outputBRMSMeter
  layout['output_rms_meter 3'] = outputCRMSMeter
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
    PrettyName = "Configuration~Minimum Gain"
  }
  
  maxGainControl = { 
    Style = "Knob",
    Position = {5 + 50 + (105 / 2) + (50 / 2), 60},
    Size = {50, 50},
    PrettyName = "Configuration~Maximum Gain"
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
    PrettyName = "Hold Off"
  }

  rampTime = { 
    Style = "Text",
    Position = {5 + (105 / 2) + (100 / 2), 5 + 60 + 50 + 50},
    Size = {100, 50},
    FontSize = 18,
    PrettyName = "Time"
  }

  layout['gain_minimum'] = minGainControl
  layout['gain_maximum'] = maxGainControl
  layout['stepper_hold_off'] = holdTime
  layout['stepper_time'] = rampTime
end