LoggingLevelAll, LoggingLevelFunction, LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = false, false, false, false, false

function HandleMinimumGain(gain)
  if LoggingLevelFunction then print("Minumum Gain Updated: "..gain.Value) end
  UpdateVolume(Controls.Gain)
end

function HandleMaximumGain(gain)
  if LoggingLevelFunction then print("Maximum Gain Updated: "..gain.Value) end
  UpdateVolume(Controls.Gain)
end

function HandleGain(gain)
  if LoggingLevelFunction then print("Gain Updated: "..gain.Value) end
  UpdateVolume(gain)
end

function HandleGainExternal(gain)
  if LoggingLevelFunction then print("Bypassing Event Handler for GainExternal") end
end

function HandleMute(mute)
  if LoggingLevelFunction then print("Mute Updated: "..tostring(mute.Boolean)) end
  Main.mute.Boolean = mute.Boolean
  if LoggingLevelAll then print("Main -> mute: "..tostring(mute.Boolean)) end
  Passthrough.mute.Boolean = mute.Boolean
  if LoggingLevelAll then print("Passthrough -> mute: "..tostring(mute.Boolean)) end
end

function HandleRampHold(hold)  
  if LoggingLevelFunction then print(string.format("Ramp Hold Updated: %f", hold.Value)) end
  RampController['stepper.hold.off'].Value = hold.Value
end

function HandleRampTime(time)
  if LoggingLevelFunction then print(string.format("Ramp Time Updated: %f", time.Value)) end
  RampController['stepper.time'].Value = time.Value
end

function HandleRampUp(btn)
  if LoggingLevelFunction then print(string.format("Ramp Up Updated: %s", tostring(btn.Boolean))) end
  if (Controls.Down.Boolean == false) then
    RampController['stepper.increase'].Boolean = btn.Boolean
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Up While Ramp Down: %s", tostring(Controls.Down.Boolean))) end
  end
end

function HandleRampDown(btn)
  if LoggingLevelFunction then print(string.format("Ramp Down Updated: %s", tostring(btn.Boolean))) end
  if (Controls.Up.Boolean == false) then
    RampController['stepper.decrease'].Boolean = btn.Boolean
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Down While Ramp Up: %s", tostring(Controls.Up.Boolean))) end
  end
end

function HandleRampGain(gain)
  if LoggingLevelFunction then print(string.format("Ramp Gain Updated: %s", tostring(gain.Position))) end

  if Controls.Gain.Position ~= gain.Position then
    if LoggingLevelAll then print(string.format("Update Gain Fader: %s", tostring(gain.Position))) end
    Controls.Gain.Position = gain.Position
    UpdateVolume(Controls.Gain)
  end
end

function UpdateVolume(gain)
  --[make sure ramp controller and volume fader stay in sync]
  RampController.gain.Position = gain.Position
  vol = ScaleVolume(gain.Position)
  if LoggingLevelFunction then print(string.format("Setting Main Gain: %f dB", vol)) end
  Main.gain.Value = vol
  if LoggingLevelFunction then print(string.format("Setting GainExternal: %f dB", vol)) end
  Controls.GainExternal.Value = vol
end

function ScaleVolume(position)
  if LoggingLevelFunction then print("Attempting To Scale User Fader Level: "..position) end

  scaledVolume = Controls.MinimumGain.Value + (Controls.MaximumGain.Value - Controls.MinimumGain.Value) * position

  if LoggingLevelAll then print(string.format("%f = %f + (%f - %f) * %f", scaledVolume, Controls.MinimumGain.Value, Controls.MinimumGain.Value, Controls.MaximumGain.Value, position)) end
  
  return scaledVolume
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
  Controls.MinimumGain.EventHandler = HandleMinimumGain
  Controls.MaximumGain.EventHandler = HandleMaximumGain
  Controls.Gain.EventHandler = HandleGain
  Controls.Mute.EventHandler = HandleMute
  Controls.GainExternal.EventHandler = HandleGainExternal
  Controls.Hold.EventHandler = HandleRampHold
  Controls.Time.EventHandler = HandleRampTime
  Controls.Up.EventHandler = HandleRampUp
  Controls.Down.EventHandler = HandleRampDown
  --[this event handler is used to allow use to generate ramp value separate from the true gain]
  RampController.gain.EventHandler = HandleRampGain

  --[handle initial values]
  HandleMinimumGain(Controls.MinimumGain)
  HandleMaximumGain(Controls.MaximumGain)
  HandleGain(Controls.Gain)
  HandleMute(Controls.Mute)
  HandleRampGain(RampController.gain)
end

--[run the initial setup logic]
Initialize()