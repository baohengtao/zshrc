alias crawler-clean='fd -e txt -e log -x rm {} && rmdir-empty'
alias ef-flatten='exiftool -directory=. -r -progress'
function ef-chrome(){
  url=$(\exiftool "$1" -BlogUrl -s3)
  if [[ $url ]]; then
    echo url
    open -a 'Google Chrome' $url
  else
    echo 'Blog URL not defined'
  fi
}

alias ec=ef-chrome

alias weibo-download='workon crawler && python -m weibo_spider --output_dir="$HOME/Cooper/TimeLine/new" --config_path="$XDG_CONFIG_HOME/crawler-weibo/config.json" '


alias weibo-download-sql='cd "$XDG_CONFIG_HOME/crawler-weibo/sql" && workon crawler && python -m weibo_spider'

alias weibo-csv-download='workon crawler && python -m weibo_spider --output_dir="$HOME/Cooper/TimeLine/csv-files" --config_path="$XDG_CONFIG_HOME/crawler-weibo/config-csv.json" '

export CRAWLER_INFO_HOME=$XDG_CONFIG_HOME/crawler-info
alias rmdir-empty='fd -H .DS_Store -x rm -v -- {}; fd -te -td -x grmdir -v -- {}'

function ef-instagram(){
  exiftool '-XMP:DateCreated<FileModifyDate' -if 'not $DateCreated'  $1 -r -progress
  exiftool '-BaseUrl<ImageDescription' -if '$ImageDescription =~ /https:/'  $1 -r -progress
  exiftool -ImageDescription= -if '$ImageDescription eq $BaseUrl' $1 -r -progress
  exiftool '-BlogTitle<UserComment' -if 'not $BlogTitle' -if '$UserComment' $1 -r -progress
  exiftool -UserComment= -if '$UserComment eq $BlogTitle'  $1 -r -progress
  exiftool -UserComment= -if '$UserComment eq ""'  $1 -r -progress
  exiftool '-ImageSupplierID<Artist' -ImageSupplierName=Instagram $1 -r -progress
  # exiftool -UserComment= -if '$UserComment eq ""' $1 -r -progress
}

function ef-mp4-meta-add(){
  exiftool '-QuickTime:CreateDate<DateCreated' $1 -progress -r -ext mp4
  exiftool '-QuickTime:Description<Description' -if '$description' $1 -progress -r -ext mp4 
  exiftool '-QuickTime:Title<Title' -if '$title'  $1 -progress -r -ext mp4

}

# function ef-gif-meta-add(){
#   exiftool '-GIF:DateCreated<DateCreated' $1 -progress -r -ext gif
#   exiftool '-DateTimeOriginal<DateCreated' $1 -progress -r -ext gif
#   exiftool '-GIF:Description<Description' -if '$description' $1 -progress -r -ext gif
#   exiftool '-GIF:Title<Title' -if '$title'  $1 -progress -r -ext gif
# }
function ef-mov-tidy(){
  exiftool '-directory<ImageUniqueID' -if '$ImageUniqueID' $1 -progress -r
  mkdir mov
  fd -e mov -x  mv {//} mov
}
function ef-time-fix(){
  exiftool '-XMP:DateCreated<DateTimeOriginal' -if '$DateTimeOriginal' $1 -progress -r
  exiftool -DateTimeOriginal=  -if '$XMP:DateCreated eq $DateTimeOriginal' $1 -progress -r
  exiftool '-CreateDate<DateCreated' $1 -progress -r -ext mp4
  exiftool '-FileCreateDate<DateCreated' "$1" -progress -r -ext gif
}
function ef-description-fix(){
  exiftool '-XMP:Description<ImageDescription' -if '$ImageDescription' -if 'not $Description' -r $1 -progress
  exiftool -ImageDescription=  -if '$ImageDescription eq $Description' -r $1 -progress
}

function ef-unique-id-fix-for-weibo(){
  exiftool $1 '-ImageUniqueID<${BaseURL;m/https:\/\/weibo.com\/(\d*)\/([a-zA-Z0-9]+)/;$_=$2}' \
   -r -progress -if '$BaseURL'
}

function ef-filename-restore(){
exiftool  '-filename<${ImageSupplierID}_${ImageUniqueID}%+2c%E' -d %Y%m%d -progress $1
}


function ef-title-gen(){
exiftool '-xmp:Caption<$Artist' -if '$Artist' -if 'not $Title'  $1 -r -progress
exiftool '-xmp:Caption<$ImageSupplierName' -if 'not $Artist' -if 'not $Title'  $1 -r -progress
exiftool '-xmp:Caption<$Caption-$DateCreated' -d %y-%m-%d -if 'not $Title'  $1 -r -progress
}

function ef-title-add(){
  exiftool '-xmp:Title<$Caption' -if 'not $Title' -if '$Caption' $1 -progress  -r
}

function ef-title-clean(){
  exiftool -xmp:Title= -if '$Title eq $Caption' -if '$Title' -if '$Caption' $1 -progress -r
  exiftool -xmp:Caption=   -if 'not $Title' -if '$Caption' $1 -progress -r
}

function ef-description-gen-v0.0(){
  exiftool -if 'not $Description' "$1" -r -progress '-xmp:UserComment<${ImageSupplierName}' -if 'not $Artist'
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${Artist}-${Source}' -if '$Artist' -if 'not $ImageCreatorID' 
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${Artist}${/}${ImageCreatorID}' -if '$ImageCreatorID' -if 'not $BaseUrl' 
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${Artist}${/}${BaseURL}' -if '$BaseUrl' -if 'not $BlogTitle' 
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${Artist}${/}${BlogTitle}${/}${BaseURL}' -if '$BlogTitle' 

}
function ef-description-gen(){
  # shellcheck disable=SC2016
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${ImageSupplierName}-${Artist}' -if 'not $Source'
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${Source}-${Artist}' -if '$Source' 

  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${xmp:UserComment}-${Creator}' -if '$Creator' 

  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${xmp:UserComment}${/}${ImageCreatorID}' -if '$ImageCreatorID' -if 'not $BaseUrl' -if 'not $BlogUrl' 
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${xmp:UserComment}${/}${BlogUrl}' -if '$BlogUrl' -if 'not $BlogTitle' 
  exiftool -if 'not $Description' $1 -r -progress '-xmp:UserComment<${xmp:UserComment}${/}${BlogTitle}${/}${BlogURL}' -if '$BlogTitle' 

}

function ef-fix-blog-url(){
  exiftool -if '$xmp:BaseUrl' "$1" -r -progress '-xmp:BlogUrl<BaseUrl' 
  exiftool -if '$BaseUrl eq $Blogurl' "$1" -r -progress -BaseUrl= 
}

function ef-description-add(){
# shellcheck disable=SC2016
exiftool '-xmp:Description<$xmp:UserComment' -if 'not $xmp:Description'  -if '$xmp:UserComment' $1 -progress -r
}

function ef-description-clean(){
  exiftool -xmp:Description= -if '$Description eq $UserComment' -if '$Description' -if '$UserComment' $1 -progress -r
  exiftool -xmp:UserComment=   -if 'not $Description' -if '$UserComment' $1 -progress -r
}
# clean
function ef-clean(){
  mkdir -p ~/exif_trash
  fd -e mov_original -e jpg_original -e jpeg_original -e xmp_original -e png_original -e mp4_original -e gif_original -x mv -v -- {} ~/exif_trash
  fd original_original -x mv -v -- {} ~/exif_trash
  rmdir-empty 
  rmdir-empty
  rmdir-empty
}

function ef-get-video-info-from-directory(){
  exiftool '-Artist<${Directory;m/..(.+)\/(.+)/;$_=$1}' '-AssetID<${Directory;m/(.+)\/(.+)/;$_=$2}' -r $1 -progress -ext mp4 -api largefilesupport=1 -if "\$filename !~ /^\./"
}

function ef-get-video-poster-info-from-directory(){
  exiftool '-Artist<${Directory;m/..(.+)\/(.+)/;$_=$1}' '-AssetID<${Directory;m/(.+)\/(.+)/;$_=$2}' -r $1 -progress -ext jpg -if "\$filename !~ /^\./"
}

#######################################################################
#                       get info from file name                       #
#######################################################################

# function ef-get-id-from-directory-for-weibo(){
#   fd -td --base-directory "$1" --exact-depth 1 -x exiftool -ImageSupplierID={} -ImageSupplierName=Weibo -progress -r {} -if "\$filename !~ /^\./"
# }
# function  ef-get-series-from-filename-for-weibo(){
#   exiftool -m -d "%Y%m%d" -progress -r "$1" \
#     '-SeriesNumber<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$3}' \
#    -if 'not $SeriesNumber' \
# }
# function  ef-get-info-from-filename-for-weibo(){
#   exiftool -m -d "%Y%m%d" -progress -r "$1" \
#     '-XMP:DateCreated<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$1}' \
#     '-BaseUrl<https://weibo.com/$ImageSupplierID/${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$2}' \
#     '-SeriesNumber<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$3}' \
#     -Status=updated -if 'not $Status' \
#     '-Subject-=Weibo' '-Subject+=Weibo' 
# }
function  ef-get-info-from-filename-for-twitter() {
  exiftool -m -d "%Y%m%d_%H%M%S" -progress -r "$1"  \
    '-XMP:DateCreated<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="$3"}' \
    '-BaseUrl<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="https://twitter.com/$1/status/$2"}' \
    '-SeriesNumber<${Filename;m/(.*)-(.*)-(.*)-(vid|img|gif)([0-9]+).([a-z1-9]+)/;$_="$5"}' \
    '-ImageSupplierName=Twitter' \
    '-ImageSupplierID<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="$1"}' \
    -Status=updated -if 'not $Status'
}

function  ef-get-info-from-filename-for-pixiv() {
  exiftool -m -d "%Y%m%d" -progress -r "$1" \
    '-SeriesNumber<${Filename;m/(\d+)_p(\d*).([a-z1-9]+)/;$_=$2}'
}
function ef-set-desc-as-url(){
  exiftool -m -progress -r "$1" \
    '-ImageDescription<BaseUrl' -if '$BaseUrl' -if 'not $ImageDescription' -progress
}

#######################################################################
#                          generate xmp info                          #
#######################################################################



# generate xmp from weibo user-id
# function ef-gen-xmp-for-weibo(){
#   for id in "$@"; do
#     xmp_file="$CRAWLER_INFO_HOME/Weibo/$id.xmp" 
#     exiftool -ImageCreatorID=https://weibo.com/u/$id \
#       -ImageSupplierID=$id \
#       -ImageSupplierName=Weibo \
#       $xmp_file \
#       -progress
#   done
# }

function ef-gen-xmp-for-instagram(){
  for id in "$@"; do
    xmp_file="$CRAWLER_INFO_HOME/Instagram/$id.xmp" 
    echo $id $xmp_file
    exiftool -ImageCreatorID=https://instagram.com/$id \
      -ImageSupplierID=$id \
      -ImageSupplierName=Instagram \
      $xmp_file \
      -progress
    exiftool '-Artist<ImageSupplierID' -if 'not $Artist' $xmp_file
    exiftool '-Identifier<ImageSupplierID' -if 'not $Identifier' $xmp_file
  done
}
# # generate xmp from twitter filename
# function ef-gen-xmp-for-twitter(){
#   for file in "$@"; do
#     user=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$1"'`
#     post=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$2"'`
#     date=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$3"'`
#     img_id=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$4"'`
#     xmp_file="$CRAWLER_INFO_HOME/DataBase-Twitter/$user.xmp"
#     xmp_db_dir="$CRAWLER_INFO_HOME/Twitter"
#     if [ ! -e $xmp_file ]; then
#       exiftool -ImageCreatorID="https://twitter.com/$user" \
#         -ImageSupplierName="Twitter" \
#         -ImageSupplierID="$user" \
#         "$xmp_file" \
#         -progress

#       exiftool -Artist=$user $xmp_file -if 'not $Artist'
#       exiftool -Identifier=$user $xmp_file -if 'not $Identifier'

#       exiftool -o . -directory=$xmp_db_dir '-filename<${Identifier}-${Artist}%E' $xmp_file
#       exiftool -o . -directory=$xmp_db_dir '-filename<${ImageSupplierID}%E' $xmp_file

#     fi
#   done
# }

#######################################################################
#                             Update info from xmp                        #
#######################################################################



# update info by directory
function ef-update-info-by-dir {
 exiftool -tagsfromfile "$CRAWLER_INFO_HOME/XMP-Pointer/%D.xmp" -progress -overwrite_original_in_place -r $1 -m -xmp:all
}
# update info by file meta
function ef-update-info-by-file-meta(){
  for file in "$@"; do
    SupplierID=$(\exiftool -s3 -ImageSupplierID -- $file )
    SupplierName=$(\exiftool -s3 -ImageSupplierName -- $file )
    if [[ $SupplierID ]] &&  [[ $SupplierName ]]; then
      exiftool -tagsfromfile $CRAWLER_INFO_HOME/XMP-Pointer/$SupplierID.xmp -overwrite_original_in_place -progress -m -xmp:all -- $file 
    fi
  done
}

# generate database
function ef-gen-xmp-pointer(){
  cd $CRAWLER_INFO_HOME && rm -r  XMP-Pointer
  fd -td -x exiftool -xmp:source={} {} -overwrite_original_in_place
  all_dir=(`fd -td --exact-depth=1 `)
  echo $all_dir
  exiftool -o . -directory=XMP-Pointer '-filename<${Identifier}-${Artist}%E' $all_dir -if '$Identifier'
  exiftool -o . -directory=XMP-Pointer '-filename<${Identifier}%E' $all_dir -if '$Identifier'
  exiftool -o . -directory=XMP-Pointer '-filename<${ImageSupplierID}%E' $all_dir
  exiftool -o . -directory=XMP-Pointer '-filename<${Artist}%E' Friends
  exiftool -o . -directory=XMP-Pointer '-filename<${Artist}%E' $all_dir
}




#######################################################################
#                   Organize Filename                          #
#######################################################################



function ef-testname(){
  exiftool '-testname<${Artist}-${XMP:DateCreated}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename $1 -if '$SeriesNumber' -r
  exiftool '-testname<${Artist}-${XMP:DateCreated}%+2c%E' -d %y-%m-%d -fileorder XMP:DateCreated -fileorder filename $1 -if ' not $SeriesNumber' -r
}

function ef-rename-without-series(){
  exiftool '-filename<${Artist}-${XMP:DateCreated}%+2c%E' -d %y-%m-%d -fileorder XMP:DateCreated -fileorder filename  -if ' not $SeriesNumber' -r $1 -progress 
}

function ef-rename(){
  exiftool '-filename<${Artist}-${XMP:DateCreated}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename  -if '$SeriesNumber' -r  $1 -progress
}

function ef-rename-with-title(){
  exiftool '-filename<${Title}-${XMP:DateCreated}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename  -if '$SeriesNumber' -r  $1 -progress
  exiftool '-filename<${Title}-${XMP:DateCreated}%+2c%E' -d %y-%m-%d -fileorder XMP:DateCreated -fileorder filename  -if 'not $SeriesNumber' -r $1 -progress 
}

function ef-rename-new-dir(){
  for file in "$@"; do
    exiftool '-directory<new/${Identifier}-${Artist}' -r $file -progress -if '$Identifier' -if 'not $Artist eq $Identifier' 
    exiftool '-directory<new/${Identifier}' -r $file -progress -if '$Identifier' -if '$Artist eq $Identifier' 
    exiftool '-directory<new/${ImageSupplierID}' -r $file -progress -if 'not $Artist' -if '$ImageSupplierID'
  done
}

function ef-rename-dir(){
  for file in "$@"; do
    exiftool '-directory<${Artist}' -r $file -progress  -if '$Artist' 
  done
}

function ef-rename-dir-with-identifier(){
  for file in "$@"; do
    exiftool '-directory<${Identifier}-${Artist}' -r $file -progress -if '$Identifier' -if 'not $Artist eq $Identifier' 
    exiftool '-directory<${Identifier}' -r $file -progress -if '$Identifier' -if '$Artist eq $Identifier' 
  done

}

function ef-rename-dir-with-id(){
  for file in "$@"; do
    exiftool '-directory<${ImageSupplierID}' -r $file -progress -if '$ImageSupplierID'
  done

}


function ef-testname-xmp(){
  for file in "$@"; do
    exiftool '-testname<${Identifier}-${Artist}.xmp'  $file -progress -if '$Identifier' -if 'not $Artist eq $Identifier' 
    exiftool '-testname<${Identifier}.xmp'  $file -progress -if '$Identifier' -if '$Artist eq $Identifier' 
  done
}



function ef-rename-xmp(){
  for file in "$@"; do
    exiftool '-filename<${Identifier}-${Artist}.xmp'  -progress -if '$Identifier' -if 'not $Artist eq $Identifier' -- $file 
    exiftool '-filename<${Identifier}.xmp'  -progress -if '$Identifier' -if '$Artist eq $Identifier' --  $file   
  done
}



#######################################################################
#                                Alias                                #
#######################################################################


alias exiftool='exiftool -progress -if "\$filename !~ /^\./"'
alias exiftool-print="exiftool -fileorder filename -@ ~/.config/photo_args.txt"
alias ep=exiftool-print
alias ef=exiftool
alias efo='exiftool -overwrite_original_in_place -P -progress'
alias exiftool-default='exiftool -progress -overwrite_original_in_place -P'
alias exiftool-rename='exiftool-default "-filename<\$Title-\${XMP:DateCreated}" -d   "%y-%m-%d%%-2c.%%e"  -if \$Title -if \$XMP:DateCreated'
alias exiftool-time-weibo='exiftool-default "-XMP:DateCreated<\${Filename;s/_.*//}" -d "%Y%m%d" -if "not \$XMP:DateCreated" '
alias exiftool-time-ins='exiftool-default "-XMP:DateCreated<\${Filename;s/\ .*//}" -d "%Y-%m-%d"'


