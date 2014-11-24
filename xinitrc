#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK_IM_MODULE='uim'
uim-xim &
export QT_IM_MODULE='xim'
export XMODIFIERS='@im=uim'
uim-toolbar-gtk3 &
xsetroot -cursor_name left_ptr
nitrogen --restore

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -d ~/.xinitrc.d ]; then
  for f in ~/.xinitrc.d/*; do
    source "$f"
  done
  unset f
fi

if [ -r ~/.xbindkeysrc ]; then
	xbindkeys
fi

which gnome-keyring-daemon && eval "$(gnome-keyring-daemon --start | sed -e 's/^/export /g')"

if [ $2 ]; then
	wm=$2
else
	wm=xmonad # DEFAULT
fi

echo "xinit: Start" $wm
case "$wm" in
	xmonad|stumpwm|qtile)
		[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
		which xscreensaver && (xscreensaver -nosplash&)
		which wmname && wmname LG3D
		exec $wm
		;;
	*)
		[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
		metacity -c&
		exec $wm;;
esac

