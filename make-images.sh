#!/bin/sh
cd ${0%/*} || exit 1 # run from this directory

# Execute the following command at the command prompt on your local computer to begin making your movie. All settings, including the number of processors, will be the same as your current VisIt session when you invoke:

DIR_OUTPUT=/home/danny/
BASE_FILENAME=test_
FPS=50
FRAME_START=1
FRAME_END=4
EMAIL=sale.danny@gmail.com


# /home/danny/workspace/VisIt/visit2_8_1.linux-x86_64/bin/visit -movie -v 2.8.1 -format png -geometry 1470x950 -output /home/danny/test_ -fps 50 -start 0 -end 4 -frame 0 -sessionfile /home/danny/test_.session -email sale.danny@gmail.com
/home/danny/workspace/VisIt/visit2_8_1.linux-x86_64/bin/visit -movie -v 2.8.1 -format png -geometry 1470x950 -output $DIR_OUTPUT/$BASE_FILENAME -fps $FPS -start $FRAME_START -end $FRAME_END -frame 0 -sessionfile VisIt-$DIR_OUTPUT/$BASE_FILENAME.session -email $EMAIL
