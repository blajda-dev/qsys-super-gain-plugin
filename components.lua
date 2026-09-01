Mono = 1
Stereo = 2
MultiChannel = 3

table.insert(components , 
{
  Name = "Main",
  Type = "gain",
  Properties =   
  {
    ["multi_channel_type"] = Mono,
    ["multi_channel_count"] = 1,
  }
})

table.insert(components , 
{
  Name = "RampController",
  Type = "gain",
  Properties =   
  {
    ["multi_channel_type"] = Mono,
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
    ["multi_channel_type"] = MultiChannel,
    ["multi_channel_count"] = 2,
  }
})

table.insert(components,
{
  Name = "Peak",
  Type = "meter2",
  Properties =
  {
    ['multi_channel_type'] = MultiChannel,
    ['multi_channel_count'] = 3,
    ['meter_type'] = 1
  }
})

table.insert(components,
{
  Name = "RMS",
  Type = "meter2",
  Properties =
  {
    ['multi_channel_type'] = MultiChannel,
    ['multi_channel_count'] = 3,
    ['meter_type'] = 1
  }
})