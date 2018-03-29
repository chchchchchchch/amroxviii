#!/bin/bash

# MAKE ONE PIXEL 99% TRANSPARENT TO FORCE
# IMAGE COMPRESSORS TO USE THE PNG FORMAT
# ---------------------------------------------------------------- #

# TODO: - DIALOG
#       - RANDOM PIXEL POSITION
#       - BETTER

  SRCIMG=$1
  NEWIMG=`echo $SRCIMG | sed 's/\.[a-z]\{2,4\}$/.png/'`
  TMP="/tmp/$RANDOM"

# ---------------------------------------------------------------- #
# MAKE 1 PIXEL 99% OPAQUE
# ---------------------------------------------------------------- #
# MAKE PIXEL FULL TRANSPARENT ------------------------------------ #
  convert $SRCIMG -alpha on -fill none \
                  -draw 'color 0,0 point' ${TMP}.1.png
# MAKE FULL IMAGE 99% OPAQUE ------------------------------------- #
  convert $SRCIMG -alpha set -channel A \
                  -evaluate set 99% ${TMP}.2.png
# COMBINE -------------------------------------------------------- #
  composite -gravity center \
            ${TMP}.1.png ${TMP}.2.png \
            ${TMP}.3.png

  cp ${TMP}.3.png $NEWIMG

# CLEAN UP ------------------------------------------------------- #
  rm ${TMP}.1.png ${TMP}.2.png ${TMP}.3.png
# ---------------------------------------------------------------- #


exit 0;

