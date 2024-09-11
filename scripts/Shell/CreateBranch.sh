commit=$(git log -n 1 --skip 1 --pretty=format:"%H")
# git branch DestructiveBranch12 $commit
# git push origin DestructiveBranch12

branch=$(git branch --list | grep "DestructiveBranch12")
if [ ! -z $branch ];
then
    echo "Branch Exists"
    git branch -d DestructiveBranch12
    git push origin -d DestructiveBranch12
fi
git branch DestructiveBranch12 $commit
git push origin DestructiveBranch12