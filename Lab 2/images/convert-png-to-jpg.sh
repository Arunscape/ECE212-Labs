for i in *.png ; do convert "$i" "${i%.*}.jpg" ; done
#I noticed that latex compiles faster with jpg images
