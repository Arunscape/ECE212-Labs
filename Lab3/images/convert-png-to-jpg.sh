for i in *.png ; do convert "$i" "${i%.*}.jpg" ; done
for i in *.PNG ; do convert "$i" "${i%.*}.jpg" ; done
mkdir ./original-png-files
for i in *.png ; do mv "$i" "./original-png-files" ; done
for i in *.PNG ; do mv "$i" "./original-png-files" ; done
