#! /bin/bash
echo "NFC tag cloning utility (using libnfc and mfoc)
Put the \"chinese\" blank card on the NFC reader
"
read -p "Press Enter to continue" < /dev/tty
mfoc -P 500 -O blank-chinese.dmp
echo "

Put the \"card to copy\" on the NFC reader
"
read -p "Press Enter to continue" < /dev/tty

mfoc -P 500 -O cardtocopy.dmp
#echo "Copy the card UID on a notepad"
#nfc-list
uid=$(nfc-anticol | grep UID)
if [[ $uid =~ :[[:blank:]](.+) ]]; then
	uid=${BASH_REMATCH[1]}
fi
echo "UID : $uid"
echo "

Put the \"chinese\" blank card on the NFC reader
"
read -p "Press Enter to continue" < /dev/tty
echo "Which key do you want to use? (a/b/A/B)"
read key
nfc-mfclassic w $key cardtocopy.dmp blank-chinese.dmp
echo "Setting new UID with nfc-mfsetuid"
nfc-mfsetuid $uid
