
alias weibo-download='workon crawler && python -m weibo_spider --output_dir="$HOME/Cooper/TimeLine/new" --config_path="$XDG_CONFIG_HOME/crawler-weibo/config.json" '

export CRAWLER_INFO_HOME=$XDG_CONFIG_HOME/crawler-info
alias rmdir-empty='fd -H .DS_Store -x rm -v -- {}; fd -te -td -x grmdir -v -- {}'

# clean
function ef-clean(){
  fd -e mov_original -e jpg_original -e xmp_original -e png_original -e mp4_original -e gif_original -x rm -v -- {}
  rmdir-empty 
  rmdir-empty
  rmdir-empty
}


# generate xmp from weibo user-id
function ef-gen-xmp-for-weibo(){
  exiftool -ImageCreatorID=https://weibo.com/u/$1 \
    -ImageSupplierID=$1 \
    -ImageSupplierName=Weibo \
    "$CRAWLER_INFO_HOME/DataBase-Weibo/$1.xmp" \
    -progress
}

# generate xmp from twitter filenae
function ef-gen-xmp-for-twitter(){
  file=$1
  user=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$1"'`
  post=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$2"'`
  date=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$3"'`
  img_id=`echo $file | perl -pe 'm/(.*)-(.*)-(.*)-(.*).([a-z0-9]*)/;$_="$4"'`
  exiftool -ImageCreatorID="https://twitter.com/$user" \
    -ImageSupplierName="Twitter" \
    -ImageSupplierID="$user" \
    "$CRAWLER_INFO_HOME/DataBase-Twitter/$user.xmp" \
    -progress
}

# generate database
function ef-gen-xmp-database(){
  cd $CRAWLER_INFO_HOME && rm -r  Weibo && rm -r Twitter
  db_dir=(`fd -td DataBase`)
  exiftool -o . '-directory<${ImageSupplierName}' '-filename<${Identifier}-${Artist}%E' $db_dir
  exiftool -o . '-directory<${ImageSupplierName}' '-filename<${ImageSupplierID}%E' $db_dir
}


# update info by directory
function ef-update-info-by-dir-for-weibo(){
 exiftool -tagsfromfile "$CRAWLER_INFO_HOME/Weibo/%D.xmp" -progress -overwrite_original_in_place -r $1
}


# update info by directory
function ef-update-info-by-dir-for-twitter(){
 exiftool -tagsfromfile "$CRAWLER_INFO_HOME/Twitter/%D.xmp" -progress -overwrite_original_in_place -r $1
}


# get info from filename for crawler downloaded image
function  ef-get-info-from-filename-for-weibo(){
  exiftool -m -d "%Y%m%d" -progress -r $1 \
    '-DateTimeOriginal<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$1}' \
    '-BaseUrl<https://weibo.com/$ImageSupplierID/${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$2}' \
    '-SeriesNumber<${Filename;m/(\d*)_([^\W_]+)_?(\d*).([a-z1-9]+)/;$_=$3}' \
    '-Title<$Artist' \
    '-ImageDescription<BaseUrl' \
    '-Subject-=Weibo' '-Subject+=Weibo' 
}
function  ef-get-info-from-filename-for-twitter(){
  exiftool -m -d "%Y%m%d_%H%M%S" -progress -r $1 \
    '-DateTimeOriginal<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="$3"}' \
    '-BaseUrl<${Filename;m/(.*)-(.*)-(.*)-(.*)/;$_="https://twitter.com/$1/status/$2"}' \
      '-SeriesNumber<${Filename;m/(.*)-(.*)-(.*)-(.*).([a-z1-9]+)/;$_="$4"}'  '-Subject-=Weibo' '-Subject+=Weibo' 

}

# update single file info from database
function _update_img_meta(){
  SupplierID=$(\exiftool -s3 -ImageSupplierID -- $1)
  SupplierName=$(\exiftool -s3 -ImageSupplierName -- $1)
  if [[ $SupplierID ]] &&  [[ $SupplierName ]]; then
    exiftool -tagsfromfile $CRAWLER_INFO_HOME/$SupplierName/$SupplierID.xmp -overwrite_original_in_place -progress -- $1
  fi
}
function _wb_info_update_pipe(){
  while read -r file; do
    _update_img_meta $file
  done
}
function _wb_info_update_args(){
  for file in "$@"; do
    _update_img_meta $file
  done
}
function wb-info-update(){
  if [[ $# != 0 ]]; then
    _wb_info_update_args $@
  else
    _wb_info_update_pipe 
  fi
}

alias exiftool='exiftool -progress '
alias exiftool-print="exiftool -fileorder filename -@ ~/.config/photo_args.txt"
alias ep=exiftool-print
alias ef=exiftool
alias efo='exiftool -overwrite_original_in_place -P -progress'
alias exiftool-default='exiftool -progress -overwrite_original_in_place -P'
alias exiftool-rename='exiftool-default "-filename<\$Title-\${DateTimeOriginal}" -d   "%y-%m-%d%%-2c.%%e"  -if \$Title -if \$DateTimeOriginal'
alias exiftool-time-weibo='exiftool-default "-DateTimeOriginal<\${Filename;s/_.*//}" -d "%Y%m%d" -if "not \$DateTimeOriginal" '
alias exiftool-time-ins='exiftool-default "-DateTimeOriginal<\${Filename;s/\ .*//}" -d "%Y-%m-%d"'


