#!/usr/bin/env bash

CACHE=cache.png
BLURRED=blurred.png
SQUARE=square.png
DIR=$HOME/.config/hypr/bg

#convert to PNG
convert $1 $DIR/$CACHE

# blur wallpaper
magick $DIR/$CACHE -blur "50x30" $DIR/$BLURRED

# square wallpaper
magick $DIR/$CACHE -gravity center -extent 1:1 $DIR/$SQUARE
