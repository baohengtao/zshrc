alias rmdir-empty='fd -H .DS_Store -x rm -v -- {}; fd -te -td -x grmdir -v -- {}'


alias ef-export-library-delete='osxphotos export --deleted-only ~/Cooper/TimeLine/hidelte/delete --update --db /Users/htao/Pictures/照片图库.photoslibrary'
alias ef-export-library-hideen='osxphotos export --hidden ~/Cooper/TimeLine/hidelte/hidden --update --db /Users/htao/Pictures/照片图库.photoslibrary'

# clean
function ef-clean-file() {
  mkdir -p ~/.exif_trash
  fd -e mov_original -e jpg_original -e jpeg_original -e xmp_original -e png_original -e mp4_original -e gif_original -e HEIC_original -X trash
  fd original_original -X trash
  rmdir-empty
  rmdir-empty
  rmdir-empty
}

#######################################################################
#                       get info from file name                       #
#######################################################################

function ef-get-info-from-filename-for-twitter() {
  exiftool -m -d "%Y%m%d_%H%M%S" -progress -r "$1" \
    '-XMP:DateCreated<${XMP:RawFileName;m/(.*)-(.*)-(.*)-(.*)/;$_="$3"}' \
    '-XMP:BlogUrl<${RawFilename;m/(.*)-(.*)-(.*)-(.*)/;$_="https://twitter.com/$1/status/$2"}' \
    '-XMP:SeriesNumber<${RawFileName;m/(.*)-(.*)-(.*)-(vid|img|gif)([0-9]+).([a-z1-9]+)/;$_="$5"}' \
    '-XMP:ImageSupplierName=Twitter' \
    '-XMP:ImageCreatorName<${RawFileName;m/(.*)-(.*)-(.*)-(.*)/;$_="$1"}' \
    '-XMP:ImageUniqueID<${RawFileName;m/(.*)-(.*)-(.*)-(.*)/;$_="$2"}' 
}

function ef-get-info-from-filename-for-pixiv() {
  exiftool -m -d "%Y%m%d" -progress -r "$1" \
    '-SeriesNumber<${Filename;m/(\d+)_p(\d*).([a-z1-9]+)/;$_=$2}'
}

#######################################################################
#                   Organize Filename                          #
#######################################################################

function ef-rename-dir() {
  for file in "$@"; do
    exiftool '-directory<${Artist}' -r "$file" -progress -if '$Artist' '-filename=%f%+2c%E'
  done
}

#######################################################################
#                                Alias                                #
#######################################################################
alias ef-flatten='exiftool -directory=. -r -progress'
function ef-chrome() {
  url=$(\exiftool "$1" -BlogUrl -s3)
  if [[ $url ]]; then
    echo url
    open -a 'Google Chrome' "$url"
  else
    echo 'Blog URL not defined'
  fi
}

alias ec=ef-chrome

alias exiftool='exiftool -progress -if "\$filename !~ /^\./"'
alias ep="exiftool -fileorder filename -@ ~/.config/photo_args.txt"
alias ef=exiftool
