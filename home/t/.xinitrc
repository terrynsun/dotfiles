# This script, along with .Xresources and .Xmodmap, are run by lxdm. (lxdm runs
# .xsession.)

## Programs
redshift -l 37:-121 &
nm-applet &
blueman-applet &
# picom -b

export PATH=$PATH:$HOME/.local/bin
wallpaper
pulseaudio -D
autorandr -c
