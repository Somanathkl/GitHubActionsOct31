Destination=PRFiles
if [ ! -d 'PRFiles' ];
then
    mkdir $Destination
fi
IFS=''
while read -r line; do
temp=$(echo $line | grep "objectTranslations")
if [ ! -z $temp ];
then
    flag=1
else
    flag=0
fi
if [ $flag -eq 1 ]; then
    newpath=$(echo $line | sed 's/\/[^/]*$//')
    folder=$(echo $line | awk -F/ '{print $(NF-1)}')
    newpath=$newpath"/"$folder".objectTranslation-meta.xml"
    cp --parents $newpath $Destination
fi
cp --parents $line $Destination
done < "delta-salesforce.txt"
echo "Building Package.xml"
sf project generate manifest --source-dir "$Destination/force-app/main/default" --output-dir package/