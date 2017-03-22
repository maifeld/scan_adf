#!/bin/sh

transport_opts='--progress'
batch_opts='--batch=sheet%03d.tif'
image_opts='--format=tiff --mode Gray --quick-format Letter --resolution 200'
# without quick-format Letter, scan comes out too long: 17.5 inches
paper_opts='-despeckle -level 10,80%'
filesize_opts='-depth 4 -compress Zip'
trim_opts='-crop -0+8 +repage' # crop 8 pixels from the top
#device_opts='-d epkowa:interpreter:001:011'
device_opts=''

name="`date +%Y-%b-%d_%H%M`"
mkdir ${name}
echo $name

# SCANNING
cd ${name}
scanimage $device_opts $transport_opts $batch_opts --source "Automatic Document Feeder" $image_opts 

echo "scanimage --source Automatic Document Feeder $device_opts $transport_opts $batch_opts $image_opts "
identify sheet001.tif

# CONVERSION
for file in `ls -1 *.tif`;
do
	echo $file
	bfile=$(basename ${file} .tif)
	convert ${bfile}*.tif $paper_opts $filesize_opts $trim_opts ${bfile}.pdf
done


# ASSEMBLY
joinPDF $name.pdf `ls -1 *.pdf`
cd ..
mv $name/$name.pdf .
rm -r $name
okular $name.pdf
