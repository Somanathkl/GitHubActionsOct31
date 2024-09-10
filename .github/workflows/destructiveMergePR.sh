TargetBranchPath="TargetBranchpath"
#cd $TargetBranchPath
currentBranch=$(git branch | grep "*" | cut -d " " -f 2)
checkOutBranch=$(git log | grep commit | HEAD -3 | tail -1 | cut -d " " -f 2)
git checkout $checkOutBranch
Destination=DestructivePRFiles
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
git checkout $currentBranch
cd $Destination"/"package
mv package.xml destructiveChanges.xml
cd ..
cd ..
mv $Destination/package/destructiveChanges.xml package/ 