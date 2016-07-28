#!/bin/bash
DIRECTORY=/var/log/psad
found=false;

URL="https://skad.dog/portscan.php"

DATE=;
SOURCE=;
HOSTNAME=;
ORG=;
PORTS=;
COUNTRY=;
ATTACK_TYPE=;
linecount=0;
scanblock=false;
scanblockoffset=0;

KEYFILE=/home/pi/watch_dog.key
KEY_HASH=""

if [ ! -f $KEYFILE ]; then
        KEY_HASH="MISSING"
else
        KEY_HASH=`cat $KEYFILE`
fi



FILES="$(find "$DIRECTORY" -maxdepth 2 -name '*email_alert')"
echo $FILES 

echo "end of file list"
for f in $FILES; do
echo "processing " $f
while read p ; do
  ((linecount+=1))
  if [[ $p == Source* ]];
  then
  	SOURCE=${p:8}
  fi
  if [[ $p == *start:* ]]
  then
      DATE=${p:20}
  fi
  if [[ $p == DNS:* ]] && [[ $found == false ]] && [[ $p != *available* ]];
  then
        HOSTNAME=${p:5}
        found=true;
  fi
  if [[ $p == OrgName* ]] || [[ $p == person ]];
  then
        ORG=${p:9}
  fi
  if [[ $p == org-name* ]]
  then
        ORG=${p:10}
  fi
  if [[ $p == descr:* ]]
  then 
        ORG=${p:7}
  fi
  if [[ $p == Scanned* ]];
  then
        PORTS=${p:19}
  fi
  if [[ $p == country* ]];
  then
        COUNTRY=${p:10}
  fi
  if [[ $p == *signatures:* ]];
  then
        scanblock=true
  fi
  if [[ $scanblock == true ]];
  then
      if [[ $scanblockoffset == 2 ]]
      then
	 ATTACK_TYPE=$p	
         scanblockoffset=0
         scanblock=false
      else
         ((scanblockoffset+=1))
      fi
  fi
done <$f


#strip out unwanted characters such as additional " and spaces

DATE="$(echo -e "$DATE" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";
SOURCE="$(echo -e "$SOURCE" | sed -e 's/^[[:space:]]*//'| sed -e 's/^\"//')";
HOSTNAME="$(echo -e "$HOSTNAME" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";
ORG="$(echo -e "$ORG" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";
PORTS="$(echo -e "$PORTS" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";
COUNTRY="$(echo -e "$COUNTRY" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";
ATTACK_TYPE="$(echo -e "$ATTACK_TYPE" | sed -e 's/^[[:space:]]*//' | sed -e 's/^\"//')";

#ignore local sources of port scans
if [[ $SOURCE != 192.168.* ]]
then

read -r -d '' JSON << EOM
{
    "timestamp" :"$DATE",
    "ports" : "$PORTS",
    "attack_type" : "$ATTACK_TYPE",
    "source" : "$SOURCE",
    "hostname" : "$HOSTNAME",
    "organisation" : "$ORG",
    "country" : "$COUNTRY",
    "key": "$KEY_HASH"
}
EOM
DATESTAMP="$(echo -e "$DATE" | tr -d ' ')";
JSON_FILE="/tmp/json.$DATESTAMP.$RANDOM"
echo $JSON_FILE

echo "$JSON" > $JSON_FILE


echo "attack detected: $JSON" >> /var/log/skad_dog.log
CMD="curl -i -X POST -d @$JSON_FILE $URL"
`$CMD` &> /dev/null
`rm $JSON_FILE`

#  echo Probed at $PORTS for $ATTACK_TYPE By $SOURCE\($HOSTNAME\) from $ORG in $COUNTRY 
# echo $ATTACK_TYPE

fi

##echo { probe : [ {ports : $PORTS}  ,{ attack_type:$ATTACK_TYPE},{source:$HOSTNAME},{organisation:$ORG},{country:$COUNTRY}]}echo { probe : [ {ports : $PORTS}  ,{ attack_type:$ATTACK_TYPE},{source:$HOSTNAME},{organisation:$ORG},{country:$COUNTRY}]} 
done

#clean up the psad folder now we've sent them all
TIME_STAMP=`date "+%Y%m%d-%H%M%S"`
FOLDERS="$(find "$DIRECTORY" -maxdepth 1 -type d -name '*.*.*')";
for d in $FOLDERS; do
  filename="$(echo -e "$d" | cut -d '/' -f 5)";
  echo "folder name is" $filename
  `mv $d /var/log/psad/archive/$TIME_STAMP.$filename`
done

OLDFOLDERS="$(find "$DIRECTORY" -type d -ctime +7 -name '*.*.*')";
for d in $OLDFOLDERS; do
   echo "deleting old attack " $d
  `rm -rf $d`
done
