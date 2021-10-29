array_var=()

function handleDescription()
{
description=$1
echo $description
sumString=""
declare -i i=1
str=$(echo $description | cut -d' ' -f $i)
strTranfer=$(echo $str | tr [:lower:] [:upper:])
while [ $str == $strTranfer ]
do
if [ $i -eq 1 ]
then
sumString="$str"
else
sumString="$sumString $str"
fi
array_var+=("$str")
i=$i+1
str=$(echo $description | cut -d' ' -f $i)
strTranfer=$(echo $str | tr [:lower:] [:upper:])
echo "$str $strTranfer"
done
majorDescriptors=$(echo $sumString | cut -d';' -f 2)
majorDescriptors=$(echo $majorDescriptors | sed -e "s/ -//")
echo $majorDescriptors


}
#FOO=" ahihi hihihi "
#FOO_NO_EXTERNAL_SPACE=$(echo -e ${FOO} | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
#echo $FOO_NO_EXTERNAL_SPACE

declare -i count_tcp=10
declare -i count_udp=20
declare -i count_icmp=30
declare -i i=30
sum=$(( ($count_icmp + $count_udp + $count_icmp )* 100 / $i ))

echo $sum

div=$(($count_udp / $count_udp))
echo $div
read "ahihi" s
#declare -i percent= 0
#percent=$sum/$i
#percent= $percent * 100

#echo $percent