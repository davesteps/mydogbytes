#!/bin/bash
# this snippet was taken from this guy’s blog: http://thomasloughlin.com/gpspipe-gps-client/
# gpspipe takes the serial output from an attached GPS device and
gpsdata=$( gpspipe -w -n 10 | grep -m 1 lon )
# the next 4 lines use jsawk to parse the JSON feed gpspipe spits out
# latitude

time=$(echo "$gpsdata" | jsawk ‘return this.time’)

lat=$(echo "$gpsdata" | jsawk ‘return this.lat’)
# longitude
lon=$(echo "$gpsdata" | jsawk ‘return this.lon’)
# altitude is here, but kinda not important, that’s why it’s commented out, if I decide I want to include it later
alt=$(echo "$gpsdata" | jsawk ‘return this.alt’)
# the speed is measured in m/s from the GPS device – handy to know if the result was taken whilst walking, driving/train or standing still
speed=$(echo "$gpsdata" | jsawk ‘return this.speed’)

echo "$time,$lat,$lon,$alt,$speed" >> /home/pi/Cydorg/gps.log2