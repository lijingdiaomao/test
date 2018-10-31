#!/usr/bin/bash
export CUDA_VISIBLE_DEVICES=
if [ ! -f "$1" ];then
  echo "请检查输入文件是否存在!!!"
else
  input=$1 
  tmp=${input%%.*}
#  echo $tmp
  fileName=${tmp#*/}
#  echo $fileName
fi
if [ -f "pinyin/"${fileName}".pinyin" ];then
  rm "pinyin/"${fileName}".pinyin"
fi
perl tools/filter_pinyin.pl "$1" "pinyin/"${fileName}".pinyin"
wc -l "pinyin/"${fileName}".pinyin"
if [ -f "tfrlist/"${fileName}".tfrlist" ];then
  rm "tfrlist/"${fileName}".tfrlist"
fi
perl tools/idpinyin_tfrlist.pl "$1" "$2" "tfrlist/"${fileName}".tfrlist"
wc -l "tfrlist/"${fileName}".tfrlist"

if [ -f "cmvn/"${fileName}".cmvn" ];then
  rm "cmvn/"${fileName}".cmvn"
fi
python tools/cmvn_count_tfr.py "tfrlist/"${fileName}".tfrlist" "cmvn/"${fileName}".cmvn"
