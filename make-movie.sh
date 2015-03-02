# webm
 
# ffmpeg -i input.ext -c:v libvpx -c:a libvorbis -pix_fmt yuv420p -quality good -b:v 2M -crf 5 -vf 
"scale=trunc(in_w/2)*2:trunc(in_h/2)*2" output.webm
 
# This will turn input.ext into output.webm.
 
#     -c:v libvpx -c:a libvorbis specifies the vp8 and vorbis encodings
#     -quality good can be good, best, or fast. 'best' is not suggested.
#     -b:v 2M sets the target bitrate to 2 MB/s. Adjust this to fit your bandwidth requirements (it will affect quality)
#     -crf 5 sets the constant rate factor. This works on a different scale than x264.
 
# INPUT='fastDuct_v3_.png'
 
# ffmpeg -i fastDuct_v3_.png -c:v libvpx -c:a libvorbis -pix_fmt yuv420p -quality good -b:v 2M -crf 5 -vf 
"scale=trunc(in_w/2)*2:trunc(in_h/2)*2" zzzzz_fastDuct.webm

# just run this script from a directory containing a series of images 
# convert the series of PNG images to GIF images
mogrify -format gif *.png
 
# now combine the GIF images into a single animated GIF, using compression
gifsicle --colors=256 --delay=4 --loopcount=0 --dither -O3 *.gif > output_gifsicle.gif
