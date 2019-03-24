## 修改已经提交的Author和Email

#### 问题

项目中git初始化时未指定user和email，使用了默认的name和email设置，已经提交过N次，假设15次。但是我希望这个项目使用自己的name和email，而不是使用默认的。那么该如何修改N次已提交的name和email？

#### 解决方案

以上问题可以使用`git-filter-branch`解决,修改最近一次的commit info如下：

```sh
git commit --amend --author="userName <userEmail>"
```

注意不能缺少`< >`
此指令仅能更新最近的一次commit的用户名邮箱

那如果是批量怎么改呢？

```shell
$ cat util/change.sh
#!/bin/sh
git filter-branch --env-filter '
OLD_EMAIL="wuguozhu@richstonedt.com"
CORRECT_NAME="wuguozhu"
CORRECT_EMAIL="wugzhu@outlook.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

执行完成`change.sh`脚本后强推到远程仓库，命令如下：

`git push --force --tags origin 'refs/heads/master'`

```shell
Administrator@PC-201809202353 MINGW64 ~/Desktop/myspace/mynote (master)
$ sh change.sh
Rewrite 95f08d2ca391401d20a612361e0a6ae5fddbedd7 (1/21) (0 seconds passed, remaiRewrite 88d8ffa10476245bb0a34ebd4ae623dacdc6b84a (2/21) (2 seconds passed, remaiRewrite 29b3136c5a9f012d68be840e767c470f4de14735 (2/21) (2 seconds passed, remaiRewrite bd4934dbdb1595623bf9ac88d262e2be866880d5 (21/21) (50 seconds passed, remaining 0 predicted)
Ref 'refs/heads/master' was rewritten

Administrator@PC-201809202353 MINGW64 ~/Desktop/myspace/mynote (master)
$ git push --force --tags origin 'refs/heads/master'
Username for 'https://github.com': wuguozhu
Enumerating objects: 177, done.
Counting objects: 100% (177/177), done.
Delta compression using up to 2 threads
Compressing objects: 100% (139/139), done.
Writing objects: 100% (167/167), 3.62 MiB | 140.00 KiB/s, done.
Total 167 (delta 19), reused 155 (delta 18)
remote: Resolving deltas: 100% (19/19), completed with 2 local objects.
To https://github.com/wuguozhu/mynote.git
 + bd4934d...04325d2 master -> master (forced update)
```

脚本为当前目录下的`change.sh`

文章参考：

[Changing author info](https://help.github.com/en/articles/changing-author-info)

[git-filter-branch(1) Manual Page](http://schacon.github.io/git/git-filter-branch.html)

