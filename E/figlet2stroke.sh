#!/bin/bash

 TEXT=$*
 FONT=`ls ../lib/fonts/figlet/*.flf | shuf -n 1`
 CFONT="OCRA-Medium"
 TMPDIR=.
 TMP=$TMPDIR/${RANDOM}
 OUTDIR=.

 if [ `echo $TEXT | wc -c` -lt 2 ]; then 
 echo; echo "We need some text!"
       echo "$0 \"your text here\""; echo
       exit 0;fi
 echo "$FONT"; echo
 echo "$TEXT" | sed 's,\\n, ,g' | #
 figlet -w 80 -f $FONT ;echo
 read -p "SAVE THIS? [y/n] " ANSWER
 if [ X$ANSWER != Xy ]; then 
      echo "Try another one!";echo
      exit 0;
 else
      OUTPUT=${OUTDIR}/`date +%Y%m%d%H%M%S`.pdf
      FTXT=`echo -e "$TEXT"             | #
            figlet -w 800 -f $FONT      | #
            sed 's/\\\/\\\\\\\\/g'      | #
            sed ':a;N;$!ba;s/\n/\\\n/g' | #
            sed 's/ /\\\ /'`              #
      convert -background "#ffffff"  \
              -fill "#000000"        \
              -density 200           \
              -font $CFONT           \
               label:"$FTXT"         \
              ${TMP}.gif 
      autotrace -color-count 2           \
                -background-color ffffff \
                -output-file=$OUTPUT     \
                -centerline              \
                ${TMP}.gif
      rm ${TMP}.gif
      echo "saved $OUTPUT"
 fi

exit 0;

