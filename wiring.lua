--[full wet]

table.insert( wiring, 
{ 
  "Input A - Dry Feed", 
  "Main Input" 
})

table.insert( wiring, 
{ 
  "Main Output", 
  "Output A - Wet",
  "Peak Input 1",
  "RMS Input 1"
})

--[pre-fader listen post-mute]

table.insert( wiring, 
{ 
  "Input B - Dry Feed [Optionally Post AEC Processing]", 
  "Passthrough Input Channel 1" ,
})

table.insert( wiring, 
{ 
  "Input C - Dry Feed [Optionally Post AEC Processing]", 
  "Passthrough Input Channel 2"
})

table.insert( wiring, 
{ 
  "Passthrough Output Channel 1",
  "Output B - Pre-Fader (Post Mute)",
  "Peak Input 2",
  "RMS Input 2"
})

table.insert( wiring, 
{ 
  "Passthrough Output Channel 2",
  "Output C - Pre-Fader (Post Mute)",
  "Peak Input 3",
  "RMS Input 3"
})