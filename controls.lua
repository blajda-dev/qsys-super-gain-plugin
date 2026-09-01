table.insert(ctrls, {
  Name = "gain.limited.output",
  ControlType = "Knob",
  ControlUnit = "dB",
  Min = -100,
  Max = 20,
  Count = 1,
  UserPin = true,
  PinStyle = "Output",
})

table.insert(ctrls, {
  Name = "gain.limited.input",
  ControlType = "Knob",
  ControlUnit = "dB",
  Min = -100,
  Max = 20,
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
})

--------------[[]]

table.insert(ctrls, {
  Name = "gain.minimum",
  ControlType = "Knob",
  ControlUnit = "dB",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = -100,
  Max = -5,
  DefaultValue = -40
})

table.insert(ctrls, {
  Name = "gain.maximum",
  ControlType = "Knob",
  ControlUnit = "dB",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = 0,
  Max = 20,
  DefaultValue = 5
})

--------------[[]]

table.insert(ctrls, {
  Name = "gain",
  ControlType = "Knob",
  ControlUnit = "Position",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
})

table.insert(ctrls, {
  Name = "mute",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})

table.insert(ctrls, {
  Name = "stepper.increase",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
})

table.insert(ctrls, {
  Name = "stepper.decrease",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
})

table.insert(ctrls, {
  Name = "stepper.hold.off",
  ControlType = "Knob",
  ControlUnit = "Float",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = 0.005,
  Max = 5,
})

table.insert(ctrls, {
  Name = "stepper.time",
  ControlType = "Knob",
  ControlUnit = "Float",
  Count = 1,
  UserPin = false,
  PinStyle = "None",
  Min = 0.25,
  Max = 30,
  DefaultValue = 5
})

table.insert(ctrls, {
  Name = "output_peak_meter",
  ControlType = "Indicator",
  IndicatorType = "Meter",
  Count = 3,
  UserPin = false,
  PinStyle = "None",
})

table.insert(ctrls, {
  Name = "output_rms_meter",
  ControlType = "Indicator",
  IndicatorType = "Meter",
  Count = 3,
  UserPin = false,
  PinStyle = "None",
})