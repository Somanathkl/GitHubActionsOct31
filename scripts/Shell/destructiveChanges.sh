count=$(gh pr view 24 --json commits | jq -r '.commits[] | "commit "+.oid' | grep -c "commit")
echo $count
count=$((count+1))
echo $count
commit=$(git log -n $count --skip 1 --pretty=format:"%H" | tail -1)
echo $commit
Destination=DestructivePRFiles
TargetBranchPath=$1
if [ ! -d $Destination ];
then
    mkdir $Destination
fi
IFS=''
while read -r line
do
    cp --parents $TargetBranchPath/$line $Destination
done < delta-destructive-sf.txt
echo "Building Package.xml"
sf project generate manifest --source-dir "$Destination/$TargetBranchPath/force-app/main/default" --output-dir $Destination"/"package/
echo "Finished Building Package.xml"
cd $Destination"/"package
mv package.xml destructiveChanges.xml
cd ..
cd ..
mv $Destination/package/destructiveChanges.xml package/ 