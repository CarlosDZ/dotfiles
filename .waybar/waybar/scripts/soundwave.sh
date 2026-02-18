#!/bin/bash
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}

for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create cava config
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
framerate = 30
bars = 14

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF


pkill -f "cava -p $config_file"
cava -p "$config_file" | sed -u "$dict"

# This script isnt self made, but instead downloaded from a public waybar dotfile that had this function.
# That repo's uploader notes in that file that it isnt is work too, but doesnt mention an original author to give credit to.
# If I end up knowing who made this code it will appear on the first lines and this comment will dissapear.
# Also, I would like to note that while this audio displey is simmetrical, I wanted to make it more Timeline-like from right to left. 
# However, my limited knowledge on cava and having 0 time right now is making it hard. I may deep dive on this after finishing exam period.
