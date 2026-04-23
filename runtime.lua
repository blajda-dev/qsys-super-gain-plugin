LoggingLevelAll, LoggingLevelFunction, LoggingLevelTransmit, LoggingLevelReceive, LoggingLevelTranscieve = false, false, false, false, false

function HandleMinimumGain(gain)
  if LoggingLevelFunction then print("Minumum Gain Updated: "..gain.Value.." dB") end
  
  UpdateGain(Controls['gain'])
end

function HandleMaximumGain(gain)
  if LoggingLevelFunction then print("Maximum Gain Updated: "..gain.Position.." dB") end
  
  UpdateGain(Controls['gain'])
end

function HandleFaderChange(gain)
  if LoggingLevelFunction then print("Fader Position Updated: "..gain.Position) end
  
  UpdateGain(gain)
end

function HandleGainExternalInput(vol)
  if LoggingLevelFunction then print(string.format("External Input Gain: %f", vol.Value)) end

  position = ConvertDecibelToPosition(vol.Value)
  
  UpdateFaderPosition(position)
  UpdateGain(Controls['gain'])
end

function HandleMute(mute)
  if LoggingLevelFunction then print("Mute Updated: "..tostring(mute.Boolean)) end
  
  Main['mute'].Boolean = mute.Boolean
  
  if LoggingLevelAll then print("Main Mute -> "..tostring(mute.Boolean)) end
  
  Passthrough['mute'].Boolean = mute.Boolean
  
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
  
  if (Controls['stepper.decrease'].Boolean == false) then
    if RampController['gain'].Value <= Controls['gain.maximum'].Value then
      RampController['stepper.increase'].Boolean = btn.Boolean
    else
      RampController['stepper.increase'].Boolean = false
      if LoggingLevelAll then print(string.format("Cannot Ramp Up, Max Gain Hit!")) end
    end
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Up While Ramp Down -> %s", tostring(Controls['stepper.decrease'].Boolean))) end
  end
end

function HandleRampDown(btn)
  if LoggingLevelFunction then print(string.format("Ramp Down -> %s", tostring(btn.Boolean))) end

  if (Controls['stepper.increase'].Boolean == false) then
    if RampController['gain'].Value >= Controls['gain.minimum'].Value then
      RampController['stepper.decrease'].Boolean = btn.Boolean
    else
      RampController['stepper.decrease'].Boolean = false
      if LoggingLevelAll then print(string.format("Cannot Ramp Down, Min Gain Hit!")) end
    end
  else
    if LoggingLevelAll then print(string.format("Cannot Ramp Down While Ramp Up -> %s", tostring(Controls['stepper.increase'].Boolean))) end
  end
end

function HandleRampPositionChange(ramp)
  if LoggingLevelFunction then print(string.format("Ramp Updated: %s dB // %s", ramp.Value, ramp.Position)) end

  position = ConvertDecibelToPosition(ramp.Value)
  
  UpdateFaderPosition(position)
  UpdateGain(Controls['gain'])
end

function UpdateFaderPosition(position)
    if position > 1.0 then
    Controls['gain'].Position = 1.0
    RampController['stepper.increase'].Boolean = false
  elseif position < 0.0 then
    Controls['gain'].Position = 0.0
    RampController['stepper.decrease'].Boolean = false
  else  
    Controls['gain'].Position = math.min(1.0, math.max(0.0, position))
  end
end

function UpdateGain(gain)
  vol = ConvertPositionToDecibel(gain.Position)
  
  SynchronizeVolume(vol)
end

function SynchronizeVolume(vol)
  val = math.min(Controls['gain.maximum'].Value, math.max(Controls['gain.minimum'].Value, vol))
  --[set the actual gain object to the attentuation value required]
  if LoggingLevelFunction then print(string.format("Setting Main Gain: %f dB", val)) end
  Main['gain'].Value = val
  
  --[set the ramp controller gain so that everything stays in sync]
  if LoggingLevelFunction then print(string.format("Setting RampController Gain: %f dB", val)) end
  
  RampController['gain'].Value = val

  --[sets the output knob to the same value so other devices could synchronize to this level]
  if LoggingLevelFunction then print(string.format("Setting Limited Gain Output: %f dB", val)) end
  Controls['gain.limited.output'].Value = val
end

function ConvertPositionToDecibel(position)
  if LoggingLevelFunction then print("Attempting To Convert Position: "..position) end

  decibel = Controls['gain.minimum'].Value + (Controls['gain.maximum'].Value - Controls['gain.minimum'].Value) * position

  if LoggingLevelAll then print(string.format("%f = %f + (%f - %f) * %f", decibel, Controls['gain.minimum'].Value, Controls['gain.minimum'].Value, Controls['gain.maximum'].Value, position)) end
  
  return decibel
end

function ConvertDecibelToPosition(decibel)
  if LoggingLevelFunction then print("Attempting To Convert Decibel: "..decibel.." dB") end

  position = (decibel - Controls['gain.minimum'].Value) / (Controls['gain.maximum'].Value - Controls['gain.minimum'].Value)

  if LoggingLevelAll then print(string.format("%f = (%f - %f) / (%f - %f)", position, decibel, Controls['gain.minimum'].Value, Controls['gain.maximum'].Value, Controls['gain.minimum'].Value)) end

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
  Controls['gain.minimum'].EventHandler = HandleMinimumGain
  Controls['gain.maximum'].EventHandler = HandleMaximumGain
  
  --[user event handlers]
  Controls['gain'].EventHandler = HandleFaderChange
  Controls['mute'].EventHandler = HandleMute

  --[subscribe to a change in the ramp gain, and forward that through to the update volume logic as required]
  RampController['gain'].EventHandler = HandleRampPositionChange
  
  --[allow external devices to provide us with an update]
  Controls['gain.limited.input'].EventHandler = HandleGainExternalInput
  
  --[ramp events]
  Controls['stepper.hold.off'].EventHandler = HandleRampHold
  
  Controls['stepper.time'].EventHandler = HandleRampTime
  
  Controls['stepper.increase'].EventHandler = HandleRampUp
  Controls['stepper.decrease'].EventHandler = HandleRampDown

  --[handle initial values]
  --[check the mute state first]
  HandleMute(Controls['mute']) 
  --[set the min-max next, to make sure scaling is correct]
  HandleMinimumGain(Controls['gain.minimum'])
  HandleMaximumGain(Controls['gain.maximum'])
  --[handle ramp time and hold off defaults]
  HandleRampHold(Controls['stepper.hold.off'])
  HandleRampTime( Controls['stepper.time'])
  --[check the ui gain object]
  HandleFaderChange(Controls['gain'])
  --[check the input pin]
  --HandleGainExternalInput(Controls['gain.limited.input'])
end

--[run the initial setup logic]
Initialize()