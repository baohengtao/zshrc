alias crawler-clean='fd -e txt -e log -x rm {} && rmdir-empty'
function ef-chrome(){
  url=$(\exiftool $1 -BaseUrl -s3)
  if [[ $url ]]; then
    echo url
    open -a 'Google Chrome' $url
  else
    echo 'Base URL not defined'
  fi
}

alias ec=ef-chrome

alias weibo-download='workon crawler && python -m weibo_spider --output_dir="$HOME/Cooper/TimeLine/new" --config_path="$XDG_CONFIG_HOME/crawler-weibo/config.json" '
alias weibo-csv-download='workon crawler && python -m weibo_spider --output_dir="$HOME/Cooper/TimeLine/csv-files" --config_path="$XDG_CONFIG_HOME/crawler-weibo/config-csv.json" '

export CRAWLER_INFO_HOME=$XDG_CONFIG_HOME/crawler-info
alias rmdir-empty='fd -H .DS_Store -x rm -v -- {}; fd -te -td -x grmdir -v -- {}'

# clean
function ef-clean(){
  fd -e mov_original -e jpg_original -e xmp_original -e png_original -e mp4_original -e gif_original -x rm -v -- {}
  fd original_original -x rm -v -- {}
  rmdir-empty 
  rmdir-empty
  rmdir-empty
}

#######################################################################
#                       get info from file name                       #
#######################################################################

function ef-get-id-from-directory-for-weibo(){
  fd -td --base-directory $1 --exact-depth 1 -x exiftool -ImageSupplierID={} -ImageSupplierName=Weibo -progress -r {} 
}
function  ef-get-info-from-filename-for-weibo(){
  exiftool -m -d "%Y%m%d" -progress -r $1 \
    '-DateTimeOriginal<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$1}' \
    '-BaseUrl<https://weibo.com/$ImageSupplierID/${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$2}' \
    '-SeriesNumber<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$3}' \
    -Status=updated -if 'not $Status' \
    '-Subject-=Weibo' '-Subject+=Weibo' 
}
function  ef-get-info-from-filename-for-twitter() {
  exiftool -m -d "%Y%m%d_%H%M%S" -progress -r $1  \
    '-DateTimeOriginal<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="$3"}' \
    '-BaseUrl<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="https://twitter.com/$1/status/$2"}' \
    '-SeriesNumber<${Filename;m/(.*)-(.*)-(.*)-(vid|img|gif)([0-9]+).([a-z1-9]+)/;$_="$5"}' \
    '-ImageSupplierName=Twitter' \
    '-ImageSupplierID<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="$1"}' \
    -Status=updated -if 'not $Status'
}
function  ef-get-info-from-filename-for-pixiv(){
  exiftool -m -d "%Y%m%d" -progress -r $1 \
    '-SeriesNumber<${Filename;m/(\d+)_p(\d*).([a-z1-9]+)/;$_=$2}' \
}
function ef-set-desc-as-url(){
  exiftool -m -progress -r $1 \
    '-ImageDescription<BaseUrl' -if '$BaseUrl' -if 'not $ImageDescription' -progress
}

#######################################################################
#                          generate xmp info                          #
#######################################################################



# generate xmp from weibo user-id
function ef-gen-xmp-for-weibo(){
  xmp_file="$CRAWLER_INFO_HOME/DataBase-Weibo/$1.xmp" 
  exiftool -ImageCreatorID=https://weibo.com/u/$1 \
    -ImageSupplierID=$1 \
    -ImageSupplierName=Weibo \
    $xmp_file \
    -progress
}

# # generate xmp from twitter filenae
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

# generate database
function ef-gen-xmp-database(){
  cd $CRAWLER_INFO_HOME && rm -r  Weibo && rm -r Twitter
  db_dir=(`fd -td DataBase`)
  exiftool -o . '-directory<${ImageSupplierName}' '-filename<${Identifier}-${Artist}%E' $db_dir
  exiftool -o . '-directory<${ImageSupplierName}' '-filename<${ImageSupplierID}%E' $db_dir
}


#######################################################################
#                             Update infor from xmp                        #
#######################################################################



# update info by directory
function ef-update-info-by-dir-for-weibo(){
 exiftool -tagsfromfile "$CRAWLER_INFO_HOME/Weibo/%D.xmp" -progress -overwrite_original_in_place -r $1
}
function ef-update-info-by-dir-for-twitter(){
 exiftool -tagsfromfile "$CRAWLER_INFO_HOME/Twitter/%D.xmp" -progress -overwrite_original_in_place -r  $1
}
# update info by file meta
function ef-update-info-by-file-meta(){
  for file in "$@"; do
    SupplierID=$(\exiftool -s3 -ImageSupplierID -- $file )
    SupplierName=$(\exiftool -s3 -ImageSupplierName -- $file )
    if [[ $SupplierID ]] &&  [[ $SupplierName ]]; then
      exiftool -tagsfromfile $CRAWLER_INFO_HOME/$SupplierName/$SupplierID.xmp -overwrite_original_in_place -progress -- $file
    fi
  done
}

#######################################################################
#                   Organize Filename                          #
#######################################################################



function ef-testname(){
  exiftool '-testname<${Artist}-${DateTimeOriginal}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename $1 -if '$SeriesNumber' -r
  exiftool '-testname<${Artist}-${DateTimeOriginal}%+2c%E' -d %y-%m-%d -fileorder DateTimeOriginal -fileorder filename $1 -if ' not $SeriesNumber' -r
}

function ef-rename(){
  exiftool '-filename<${Artist}-${DateTimeOriginal}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename  -if '$SeriesNumber' -r  $1 -progress
  exiftool '-filename<${Artist}-${DateTimeOriginal}%+2c%E' -d %y-%m-%d -fileorder DateTimeOriginal -fileorder filename  -if ' not $SeriesNumber' -r $1 -progress 
}
function ef-rename-with-title(){
  exiftool '-filename<${Title}-${DateTimeOriginal}%+2c-${SeriesNumber}%E' -d %y-%m-%d -fileorder filename  -if '$SeriesNumber' -r  $1 -progress
  exiftool '-filename<${Title}-${DateTimeOriginal}%+2c%E' -d %y-%m-%d -fileorder DateTimeOriginal -fileorder filename  -if 'not $SeriesNumber' -r $1 -progress 
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
    exiftool '-directory<${Identifier}-${Artist}' -r $file -progress -if '$Identifier' -if 'not $Artist eq $Identifier' 
    exiftool '-directory<${Identifier}' -r $file -progress -if '$Identifier' -if '$Artist eq $Identifier' 
    exiftool '-directory<${ImageSupplierID}' -r $file -progress -if 'not $Artist' -if '$ImageSupplierID'
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


alias exiftool='exiftool -progress '
alias exiftool-print="exiftool -fileorder filename -@ ~/.config/photo_args.txt"
alias ep=exiftool-print
alias ef=exiftool
alias efo='exiftool -overwrite_original_in_place -P -progress'
alias exiftool-default='exiftool -progress -overwrite_original_in_place -P'
alias exiftool-rename='exiftool-default "-filename<\$Title-\${DateTimeOriginal}" -d   "%y-%m-%d%%-2c.%%e"  -if \$Title -if \$DateTimeOriginal'
alias exiftool-time-weibo='exiftool-default "-DateTimeOriginal<\${Filename;s/_.*//}" -d "%Y%m%d" -if "not \$DateTimeOriginal" '
alias exiftool-time-ins='exiftool-default "-DateTimeOriginal<\${Filename;s/\ .*//}" -d "%Y-%m-%d"'


