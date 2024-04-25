#!/usr/bin/env bash

CACHE=cache.png
BLURRED=blurred.png
SQUARE=square.png
DIR=$HOME/.config/hypr/bg
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

#convert to PNG
convert $DIR/$RANDOMPICS $DIR/$CACHE

# blur wallpaper
magick $DIR/$CACHE -blur "50x30" $DIR/$BLURRED

# square wallpaper
magick $DIR/$CACHE -gravity center -extent 1:1 $DIR/$SQUARE
