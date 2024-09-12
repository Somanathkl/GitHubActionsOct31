PR_NUM=$(git log origin/main -1 --pretty=format:"%s" | cut -d "#" -f 2 | cut -d " " -f 1)
echo $PR_NUM
count=$(gh pr view $PR_NUM --json commits | jq -r '.commits[] | "commit "+.oid' | grep -c "commit")
echo $count
count=$((count+1))
echo $count
commit=$(git log -n $count --skip 1 --pretty=format:"%H" | tail -1)
echo $commit
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