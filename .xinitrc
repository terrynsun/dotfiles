xrdb -merge  ~/.Xresources
sh ~/.xrc

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set mute
amixer set Master 0

# Keymap
if [ -f .Xmodmap ]; then
  xmodmap .Xmodmap
nm-applet &
fi

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# SCIM
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
scim -d

# Programs
feh --bg-scale ~/dotfiles/background.jpg &
xbacklight -set 20 &
redshift -l 37:-121 &
pavucontrol &
keepass &
amixer sset Master mute

exec i3
