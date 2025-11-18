table.insert(ctrls, {
  Name = "MinimumGain",
  ControlType = "Knob",
  ControlUnit = "dB",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = -100,
  Max = -15,
})

table.insert(ctrls, {
  Name = "MaximumGain",
  ControlType = "Knob",
  ControlUnit = "dB",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = 0,
  Max = 20,
})

table.insert(ctrls, {
  Name = "Gain",
  ControlType = "Knob",
  ControlUnit = "Position",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
})

table.insert(ctrls, {
  Name = "GainExternal",
  ControlType = "Knob",
  ControlUnit = "dB",
  Min = -100,
  Max = 20,
  Count = 1,
  UserPin = true,
  PinStyle = "Output",
})

table.insert(ctrls, {
  Name = "Mute",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})