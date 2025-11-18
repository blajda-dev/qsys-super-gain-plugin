GainMono = 1
GainStereo = 2
GainMultiChannel = 3

table.insert(components , 
{
  Name = "Main",
  Type = "gain",
  Properties =   
  {
    ["multi_channel_type"] = GainMono,
    ["multi_channel_count"] = 1,
  }
})

table.insert(components , 
{
  Name = "RampController",
  Type = "gain",
  Properties =   
  {
    ["multi_channel_type"] = GainMono,
    ["multi_channel_count"] = 1,
    ["enable_stepper"] = true,
    ["step_mode"] = 0,
  }
})


table.insert(components, 
{
  Name = "Passthrough",
  Type = "gain",
  Properties = 
  {
    ["multi_channel_type"] = GainMultiChannel,
    ["multi_channel_count"] = 2,
  }
})