# Super Gain Control Plugin

## Input Pins
- Input A
  - routed to Output A - Wet
- Input B
  - routed to Output B - Pre-Fader (Post-Mute)
- Input C
  - routed to Output C - Pre-Fader (Post-Mute)

## Output Pins
- Output A - Wet
  - a full wet feed
    - Post-Fader, Post-Mute
- Output B - Pre-Fader (Post-Mute)
  - this output is intended to feed any device that requires a pre-fader, post-mute feed such as:
    - assisted listening devices
    - vtc / atc codecs
    - soft conferencing hardware
    - recording hardware
    - an automixer that feeds hardware that needs this type of feed downstream
- Output C - Pre-Fader (Post-Mute)
  - this output is intended to feed any device that requires a pre-fader, post-mute feed such as:
    - assisted listening devices
    - vtc / atc codecs
    - soft conferencing hardware
    - recording hardware
    - an automixer that feeds hardware that needs this type of feed downstream

## Control Pins
- Gain Input
  - allow this object to adjust based on the gain of another object
  - this will ignore out of range values
- Gain Output
  - force other objects to bend to the will of this gain object, output only
- Mute
  - force or feed a mute using the input or output pins
- Up
  - cause the gain to ramp up
- Down
  - cause the gain to ramp down