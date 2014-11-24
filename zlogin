for p in $HOME/local/bin(N-/); do
	if [ -z ${path[(r)${p}]} ]; then
		path=(${p} $path)
	fi
done
export PATH

typeset -T LD_LIBRARY_PATH ldlibpath
for p in $HOME/local/lib(N-/); do
	if [ -z ${ldlibpath[(r)${p}]} ]; then
		ldlibpath=(${p} $ldlibpath)
	fi
done
unset p
export LD_LIBRARY_PATH

if [[ ${$(tty)/\/dev\/tty*/} == "" ]]; then
	env LANG=C date;
	echo -n "> "
	read line
	case "$line" in
		tty)
			;;
		"")
			exec startx
			;;
		*)
			exec startx "$line"
			;;
	esac
fi
