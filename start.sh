#!/bin/bash
PHP_VERSION=$1
LOOP_ENABLE=$2
NAME="$(whoami)"
cd "$HOME"
DO_LOOP="$LOOP_ENABLE"
while getopts "p:f:l" OPTION 2> /dev/null; do
	case ${OPTION} in
		p)
			PHP_BINARY="$OPTARG"
			;;
		f)
			POCKETMINE_FILE="$OPTARG"
			;;
		l)
			DO_LOOP="yes"
			;;
		\?)
			break
			;;
	esac
done
if [ "$PHP_BINARY" == "" ]; then
	if [ -f /home/cp/libs/php$PHP_VERSION/bin/php ]; then
		export PHPRC=""
		PHP_BINARY="/home/cp/libs/php$PHP_VERSION/bin/php"
	elif [ type php 2>/dev/null ]; then
		PHP_BINARY=$(type -p php)
	else
		echo "Couldn't find a working PHP binary, please use the installer."
		exit 1
	fi
fi
if [ "$POCKETMINE_FILE" == "" ]; then
	if [ -f $HOME/PocketMine-iTX.phar ]; then
		POCKETMINE_FILE="$HOME/PocketMine-iTX.phar"
	elif [ -f $HOME/Genisys_1.0dev_#*.phar ]; then
	    POCKETMINE_FILE="$HOME/Genisys*.phar"
	elif [ -f $HOME/PocketMine-MP.phar ]; then
		POCKETMINE_FILE="$HOME/PocketMine-MP.phar"
	elif [ -f $HOME/src/pocketmine/PocketMine.php ]; then
		POCKETMINE_FILE="$HOME/src/pocketmine/PocketMine.php"
	elif [ -f $HOME/src/PocketMine.php ]; then
		POCKETMINE_FILE="$HOME/src/PocketMine.php"
	elif [ -f $HOME/PocketMine.php ]; then
		POCKETMINE_FILE="$HOME/PocketMine.php"
	else
		echo "Couldn't find a valid Genisys installation"
		exit 1
	fi
fi
LOOPS=0
set +e
while [ "$LOOPS" -eq 0 ] || [ "$DO_LOOP" == "yes" ]; do
	find /tmp -user "$NAME" | xargs rm
	rm $HOME/server.log
	if [ "$DO_LOOP" == "yes" ]; then
		"$PHP_BINARY" "$POCKETMINE_FILE" $@
	else
		exec "$PHP_BINARY" "$POCKETMINE_FILE" $@
	fi
	((LOOPS++))
done
if [ ${LOOPS} -gt 1 ]; then
	echo "Restarted $LOOPS times"
fi
