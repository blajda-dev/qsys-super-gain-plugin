LoggingLevelAll, LoggingLevelFunction, LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = false, false, false, false, false

function HandleMinimumGain(gain)
  if LoggingLevelFunction then print("Minumum Gain Updated: "..gain.Value.." dB") end
  
  UpdateGain(Controls.Gain)
end

function HandleMaximumGain(gain)
  if LoggingLevelFunction then print("Maximum Gain Updated: "..gain.Position.." dB") end
  
  UpdateGain(Controls.Gain)
end

function HandleFaderChange(gain)
  if LoggingLevelFunction then print("Fader Position Updated: "..gain.Position) end
  
  UpdateGain(gain)
end

function HandleGainExternalInput(vol)
  if LoggingLevelFunction then print(string.format("External Input Gain: %f", vol.Value)) end

  position = ConvertDecibelToPosition(vol.Value)
  
  UpdateFaderPosition(position)
  UpdateGain(Controls.Gain)
end

function HandleMute(mute)
  if LoggingLevelFunction then print("Mute Updated: "..tostring(mute.Boolean)) end
  
  Main.mute.Boolean = mute.Boolean
  
  if LoggingLevelAll then print("Main Mute -> "..tostring(mute.Boolean)) end
  
  Passthrough.mute.Boolean = mute.Boolean
  
  if LoggingLevelAll then print("Passthrough Mute -> "..tostring(mute.Boolean)) end
end

function HandleRampHold(hold)  
  if LoggingLevelFunction then print(string.format("Ramp Hold Updated: %f seconds", hold.Value)) end
  
  RampController['stepper.hold.off'].Value = hold.Value
end

function HandleRampTime(time)
  if LoggingLevelFunction then print(string.format("Ramp Time Updated: %f seconds", time.Value)) end
  
  RampController['stepper.time'].Value = time.Value
end

function HandleRampUp(btn)
  if LoggingLevelFunction then print(string.format("Ramp Up -> %s", tostring(btn.Boolean))) end 
  
  if (Controls.Down.Boolean == false) then
    if RampController.gain.Value <= Controls.MaximumGain.Value then
      RampController['stepper.increase'].Boolean = btn.Boolean
    else
      RampController['stepper.increase'].Boolean = false
      if LoggingLevelAll then print(string.format("Cannot Ramp Up, Max Gain Hit!")) end
    end
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Up While Ramp Down -> %s", tostring(Controls.Down.Boolean))) end
  end
end

function HandleRampDown(btn)
  if LoggingLevelFunction then print(string.format("Ramp Down -> %s", tostring(btn.Boolean))) end

  if (Controls.Up.Boolean == false) then
    if RampController.gain.Value >= Controls.MinimumGain.Value then
      RampController['stepper.decrease'].Boolean = btn.Boolean
    else
      RampController['stepper.decrease'].Boolean = false
      if LoggingLevelAll then print(string.format("Cannot Ramp Down, Min Gain Hit!")) end
    end
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Down While Ramp Up -> %s", tostring(Controls.Up.Boolean))) end
  end
end

function HandleRampPositionChange(ramp)
  if LoggingLevelFunction then print(string.format("Ramp Updated: %s dB // %s", ramp.Value, ramp.Position)) end

  position = ConvertDecibelToPosition(ramp.Value)
  
  UpdateFaderPosition(position)
  UpdateGain(Controls.Gain)
end

function UpdateFaderPosition(position)
    if position > 1.0 then
    Controls.Gain.Position = 1.0
    RampController['stepper.increase'].Boolean = false
  elseif position < 0.0 then
    Controls.Gain.Position = 0.0
    RampController['stepper.decrease'].Boolean = false
  else  
    Controls.Gain.Position = math.min(1.0, math.max(0.0, position))
  end
end

function UpdateGain(gain)
  vol = ConvertPositionToDecibel(gain.Position)
  
  SynchronizeVolume(vol)
end

function SynchronizeVolume(vol)
  val = math.min(Controls.MaximumGain.Value, math.max(Controls.MinimumGain.Value, vol))
  --[set the actual gain object to the attentuation value required]
  if LoggingLevelFunction then print(string.format("Setting Main Gain: %f dB", val)) end
  Main.gain.Value = val
  
  --[set the ramp controller gain so that everything stays in sync]
  if LoggingLevelFunction then print(string.format("Setting RampController Gain: %f dB", val)) end
  
  RampController.gain.Value = val

  --[sets the output knob to the same value so other devices could synchronize to this level]
  if LoggingLevelFunction then print(string.format("Setting Limited Gain Output: %f dB", val)) end
  Controls.LimitedGainOutput.Value = val
end

function ConvertPositionToDecibel(position)
  if LoggingLevelFunction then print("Attempting To Convert Position: "..position) end

  decibel = Controls.MinimumGain.Value + (Controls.MaximumGain.Value - Controls.MinimumGain.Value) * position

  if LoggingLevelAll then print(string.format("%f = %f + (%f - %f) * %f", decibel, Controls.MinimumGain.Value, Controls.MinimumGain.Value, Controls.MaximumGain.Value, position)) end
  
  return decibel
end

function ConvertDecibelToPosition(decibel)
  if LoggingLevelFunction then print("Attempting To Convert Decibel: "..decibel.." dB") end

  position = (decibel - Controls.MinimumGain.Value) / (Controls.MaximumGain.Value - Controls.MinimumGain.Value)

  if LoggingLevelAll then print(string.format("%f = (%f - %f) / (%f - %f)", position, decibel, Controls.MinimumGain.Value, Controls.MaximumGain.Value, Controls.MinimumGain.Value)) end

  return position
end

function ConfigureLoggingLevels(level)
  print("Logging Level: "..level)
  if level == "All" then
    LoggingLevelAll, LoggingLevelFunction, LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = true, true, true, true, true
  elseif level == "Function Calls" then
    LoggingLevelFunction = true
  elseif level == "Tx" then
    LoggingLevelTransmit =  true
  elseif level == "Rx" then
    LoggingLevelReceive = true
  elseif level == "Tx/Rx" then
    LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = true, true, true
  elseif level == "None" then
    LoggingLevelAll, LoggingLevelFunction, LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = false, false, false, false, false
  else
    print("Logging Level: "..level.." Unknown!!")
  end
end

function Initialize()
  --[configure logging]
  ConfigureLoggingLevels(Properties['Debug Print'].Value)
  
  --[set up event handlers]
  
  --[configuration event handlers]
  Controls.MinimumGain.EventHandler = HandleMinimumGain
  Controls.MaximumGain.EventHandler = HandleMaximumGain
  
  --[user event handlers]
  Controls.Gain.EventHandler = HandleFaderChange
  Controls.Mute.EventHandler = HandleMute

  --[subscribe to a change in the ramp gain, and forward that through to the update volume logic as required]
  RampController.gain.EventHandler = HandleRampPositionChange
  
  --[allow external devices to provide us with an update]
  Controls.LimitedGainInput.EventHandler = HandleGainExternalInput
  
  --[ramp events]
  Controls.Hold.EventHandler = HandleRampHold
  
  Controls.Time.EventHandler = HandleRampTime
  
  Controls.Up.EventHandler = HandleRampUp
  Controls.Down.EventHandler = HandleRampDown

  --[handle initial values]
  --[check the mute state first]
  HandleMute(Controls.Mute) 
  --[set the min-max next, to make sure scaling is correct]
  HandleMinimumGain(Controls.MinimumGain)
  HandleMaximumGain(Controls.MaximumGain)
  --[check the ui gain object]
  HandleFaderChange(Controls.Gain)
  --[check the input pin]
  --HandleGainExternalInput(Controls.LimitedGainInput)
end

--[run the initial setup logic]
Initialize()