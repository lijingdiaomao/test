#!/usr/bin/bash
ruo=0
qi=0
ruoqi=0
while read i
do
 
  echo $i".pinyin"
  ruoT=`grep ruo "pinyin_id/"$i".pinyin"| wc -l`

  echo "ruo="$ruoT
  ruo=$(($ruo+$ruoT))

  qiT1=`grep "qi|" "pinyin_id/"$i".pinyin"| wc -l`
  echo "qi|="`grep "qi|" "pinyin_id/"$i".pinyin"| wc -l`
  qiT2=`grep "qi$" "pinyin_id/"$i".pinyin"| wc -l`
  echo "qi$="`grep "qi$" "pinyin_id/"$i".pinyin"| wc -l`
  qiT1T2=`grep "qi|" "pinyin_id/"$i".pinyin"|grep "qi$"|wc -l`
  echo "qi|+qi$="$qiT1T2
  echo "qi="$(($qiT1+qiT2-$qiT1T2))
  qi=$(($qi+$qiT1+qiT2-$qiT1T2))

  ruoqiT1=`grep "ruo|qi|" "pinyin_id/"$i".pinyin"| wc -l`
  echo "ruo|qi|="`grep "ruo|qi|" "pinyin_id/"$i".pinyin"| wc -l`
  ruoqiT2=$(($ruoqiT+`grep "ruo|qi$" "pinyin_id/"$i".pinyin"| wc -l`))
  echo "ruo|qi$="`grep "ruo|qi$" "pinyin_id/"$i".pinyin"| wc -l`
  ruoqiT1T2=`grep "ruo|qi$" "pinyin_id/"$i".pinyin" |grep "ruo|qi|"|wc -l`
  echo "ruo|qi|+ruo|qi$="$ruoqiT1T2
  echo "ruo|qi="$(($ruoqiT1+$ruoqiT2-$ruoqiT1T2))
  
 
  ruoqi=$(($ruoqi+$ruoqiT1+$ruoqiT2-$ruoqiT1T2))
  echo "total_ruoqi="$ruoqi
  #grep -rn "ruo\|qi\|" "pinyin_id/"$i".pinyin"

done<$1
echo "********************************"
echo "ruo="$ruo
echo "qi="$qi
echo "ruoqi="$ruoqi
