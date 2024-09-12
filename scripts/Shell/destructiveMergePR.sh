Destination=DestructivePRFilesMerge
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
git branch -d DestructiveBranch12
git push origin -d DestructiveBranch12