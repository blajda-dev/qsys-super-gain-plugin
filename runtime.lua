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

function UpdateVolume(gain)
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
  --[handle initial values]
  HandleMinimumGain(Controls.MinimumGain)
  HandleMaximumGain(Controls.MaximumGain)
  HandleGain(Controls.Gain)
  HandleMute(Controls.Mute)
end

--[run the initial setup logic]
Initialize()