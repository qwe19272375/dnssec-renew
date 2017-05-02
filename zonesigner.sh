#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/local/sbin:~/bin
export PATH
ZONE=yourdomain.com
ZONEFILE="/path/to/zonefile"
KSK="/path/to/KSK"
ZSK="/path/to/ZSK"
SALT=`head -c 1000 /dev/random | sha1 | cut -b 1-16`
SERIAL=`named-checkzone $ZONE $ZONEFILE | egrep -ho '[0-9]{10}'`
NEW_SERIAL=`date +%Y%m%d00`
if [ $SERIAL -ge $NEW_SERIAL ]; then
	$NEW_SERIAL=$(($SERIAL+1))
fi
sed -i -e 's/'$SERIAL'/'$NEW_SERIAL'/' $ZONEFILE &&
dnssec-signzone -A -3 $SALT -o $ZONE -k $KSK -t $ZONEFILE $ZSK &&
rndc reload &&
echo "dnssec renew success" || echo "failed to renew dnssec, serial not changed" && sed -i -e 's/'$NEW_SERIAL'/'$SERIAL'/' $ZONEFILE
