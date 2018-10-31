#!/bin/bash

#filename=`pwd | awk -F / '{print $6}'`
#echo "${filename[*]}"

#usage  rename.sh rename path 436 org

suffix="abc"
for dir in $(ls `$2`)
do
	[ -d $dir ] && old_dir=${dir}'/'
#	[ -d $dir ] && echo "$2""/""$1""/"
#	[ -d $dir ] && echo "/mnt/hotnas/asr/tfr_""$3""/""$4""/"
	[ -d $dir ] && mv $old_dir $1
	[ -d $dir ] && nohup cp -r "$($2)""/""$1""/" "/mnt/hotnas/asr/tfr_""$3""/""$4""/" &
	#echo ""$($2)""/""$1""/""
	#echo ""/mnt/hotnas/asr/tfr_""$3""/""$4""/""

	[ -f $dir ] && suffix="${dir#*.}"
	if [ "$suffix" = "cmvn" ];then
	  mv $dir "$1"".""$suffix"
	  cp "$1"".""$suffix" "/mnt/hotnas/asr/tfr_describ/""$3""/3_cmvn/"
	  echo "$1"".""$suffix"
	fi
	result=$(echo "$suffix"|grep "pinyin")
	if [[ "$suffix" =~ "pinyin_" ]]
	then
	  mv $dir "$1"".""$suffix"
	  cp "$1"".""$suffix" "/mnt/hotnas/asr/tfr_describ/""$3""/2_pinyin/""$1"".""pinyin"
	fi
        if [[ "$suffix" =~ "pinyinW" ]]
        then
          mv $dir "$1"".""$suffix"
          cp "$1"".""$suffix" "/mnt/hotnas/asr/tfr_describ/""$3""/4_idpinyin/""$1"".""pinyin"
        fi

done
