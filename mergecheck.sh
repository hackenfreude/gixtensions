#!/usr/bin/env bash

remote_master='origin/master'
remote_master_head=$(git log ${remote_master} -n 1 --pretty=format:'%H')

remote_release='origin/release'
remote_release_head=$(git log ${remote_release} -n 1 --pretty=format:'%H')

echo -e 'master HEAD:\t'${remote_master_head}
echo -e 'release HEAD:\t'${remote_release_head}

git merge-base --is-ancestor ${remote_master_head} ${remote_release_head}
result=$?

if [[ ${result} == 0 ]]
then
	echo 'safe to merge: '${remote_master}' is ancestor of '${remote_release}
elif [[ ${result} == 1 ]]
then
	echo 'DO NOT MERGE: '${remote_master}' is NOT an ancestor of '${remote_release}
else
	echo 'unable to validate ancestry... proceed with EXTREME caution'
fi
