for i in *.png ; do convert "$i" "${i%.*}.jpg" ; done
#I noticed that LaTeX compiles faster with jpg images
