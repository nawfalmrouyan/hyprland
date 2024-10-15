#!/usr/bin/env bash

CACHE=cache.png
BLURRED=blurred.png
SQUARE=square.png
PROFILE=profile.png
DIR=$HOME/.config/hypr/bg

#convert to PNG
magick $1 $DIR/$CACHE

# blur wallpaper
magick $DIR/$CACHE -blur "50x30" $DIR/$BLURRED

# square wallpaper
# magick $DIR/$PROFILE -gravity center -extent 1:1 $DIR/$SQUARE

magick $PROFILE \
  \( -clone 0 -alpha extract -threshold 0 \) \
  \( -clone 1 -blur 10x65000 -threshold 0 \) \
  \( -clone 2 -fill grey -opaque white \) \
  \( -clone 3 -clone 0 -clone 1 -alpha off -compose over -composite \) \
  -delete 0,1,3 +swap -alpha off -compose copy_opacity -composite \
  $SQUARE
