#!/bin/bash

WORDS=0
TMPFILE=/tmp/myscript.tmp

if [ ! -e $TMPFILE ]; then
    touch $TMPFILE
    echo 0 > $TMPFILE
fi

WORDS_OLD=`cat $TMPFILE`

LINES=`cat $LOGFILE | wc -l`
WORDS=`cat $LOGFILE | grep $KEYWORD | wc -l`

echo $WORDS > /tmp/myscript.tmp

if [ $WORDS -gt $WORDS_OLD  ] ; then
    echo "In $LINES lines we have $WORDS keywords" >> /var/log/myservice.log
fi
