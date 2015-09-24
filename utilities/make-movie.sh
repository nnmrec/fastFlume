
# just run this script from a directory containing a series of images 
# convert the series of PNG images to GIF images
mogrify -format gif *.png
 
# now combine the GIF images into a single animated GIF, using compression
gifsicle --colors=256 --delay=4 --loopcount=0 --dither -O3 *.gif > output_gifsicle.gif

# Also, this combo of commands for FFMPEG works okay
ffmpeg -framerate 50 -i fastFlume-RC5__%04d.png -s:v 1920x1080 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p movie-v1-50fps.mp4



## the below lines are for reference only, and commands are broken, or not quite right
 
# ffmpeg -i input.ext -c:v libvpx -c:a libvorbis -pix_fmt yuv420p -quality good -b:v 2M -crf 5 -vf "scale=trunc(in_w/2)*2:trunc(in_h/2)*2" output.webm
 
# This will turn input.ext into output.webm.
 
#     -c:v libvpx -c:a libvorbis specifies the vp8 and vorbis encodings
#     -quality good can be good, best, or fast. 'best' is not suggested.
#     -b:v 2M sets the target bitrate to 2 MB/s. Adjust this to fit your bandwidth requirements (it will affect quality)
#     -crf 5 sets the constant rate factor. This works on a different scale than x264.
 
# INPUT='fastDuct_v3_.png'
 
# ffmpeg -i fastDuct_v3_.png -c:v libvpx -c:a libvorbis -pix_fmt yuv420p -quality good -b:v 2M -crf 5 -vf "scale=trunc(in_w/2)*2:trunc(in_h/2)*2" zzzzz_fastDuct.webm
