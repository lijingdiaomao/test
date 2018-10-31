 #!/usr/bin/bash

while read i
do
  cat "pinyin_id/"$i >> $2

done<$1
