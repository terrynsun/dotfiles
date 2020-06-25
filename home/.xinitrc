# This script, along with .Xresources and .Xmodmap, are run by lxdm.

## Programs
xbacklight -set 5
redshift -l 37:-121 &
nm-applet &
blueman-applet &
picom -b
~/.local/bin/wallpaper
echo '.profile' >> ~/out
export PATH=$PATH:$HOME/.local/bin
