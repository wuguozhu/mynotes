

# Git正确使用姿势(官方文档的实践)

### Git原理

`Git`是什么？简单说`Git`是一个分布式版本管理工具，概念这个东西说多可以说很多，简短也可以一句话说完。

`Git`整体可以分为三部分：工作区、暂存区和分支，在我们的git工作目录下，有一个`.git`文件，这个文件就是我们常说的版本库，要注意的是`Git`是通过快照的方式保存版本的，和传统版本管理工具不同，git不保存不同版本之间的差异，只以快照的方式保存修改后的文件，如果文件没有被修改，git就不会保存，这也是git比传统工具更高效的原因，但也有一个缺点，由于每次保存的都是快照，相当于把修改后的文件复制一份保存起来，这难免会造成空间浪费，因此版本提交多了之后，`.git`文件会变得很大。
Git有三个主要状态，您的文件可以驻留在：`已提交`，`已修改`和`已暂存`：

- `已提交`:意味着数据安全地存储在本地数据库中。
- `已修改`:意味着已更改文件但尚未将其提交到您的数据库。
- `已暂存`:意味着已在其当前版本中标记了已修改的文件，以进入下一个提交快照。

![areas](.image/Git.assets/areas.png)

**工作区**
 工作区就是我们工作的文件夹目录
 **暂存区**
 Git和其它版本管理工具一个不同之处就在于，git有一个暂存区，当我们执行`git add`命令的时候，我们实际上就是把修改后的文件放入到这个暂存区，而不是直接发布版本
 **分支**
 分支区域存放的是我们发布的各个版本，每次执行`git commit`操作时，git会生成一个hash值作为版本号，然后把暂存区的文件放入分支区域，也就是发布了一个版本，因为一个代码仓库一般会有好几个分支，所以这个提交的分支仅仅指向你当前正在使用的那个。换句话说，暂存区就是为版本发布做准备的，提交之后暂存区的就被清空了。

```sh
$ git add 	    ## 添加修改后的文件到暂存区
$ git commit    ## 提交文件到分支
$ git status    ## 查看当前文件状态
```

### 项目初始化过程

```sh
Command line instructions
# Git global setup //Git全局设置
git config --global user.name "wuguozhu"
git config --global user.email "wugzhu@outlook.com"

# Git setup //Git设置(只对当前项目有效)
git config user.name "wuguozhu"
git config user.email "wugzhu@outlook.com"

# Create a new repository //创建一个新的仓库
git clone http://192.168.6.126/cmo-iot/web-demo.git
cd web-demo
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

# Existing folder or Git repository  //已存在的目录或者项目初始化仓库
cd existing_folder
git init
git remote add origin http://192.168.6.126/cmo-iot/web-demo.git
git add .
git commit
git push -u origin master
```

### Git正确的使用姿势

```sh
#git 使用的正确姿势
git clone gitlab@192.168.6.126:mintaka/sell-deploy-mz.git
cd sell-deploy-mz/
git checkout develop
git add .
git commit -m 'feat(*): create flume configuration and shell to receive kafka messages Closes JIRAID-72'
git push -u origin develop
```

### Git正确的提交姿势

type用于说明 commit 的类别，只允许使用下面7个标识。
```sh
feat：    新功能（feature）
fix：     修补bug
docs：    文档（documentation）
style：   格式（不影响代码运行的变动）
refactor：重构（即不是新增功能，也不是修改bug的代码变动）
test：    增加测试
chore：   构建过程或辅助工具的变动
```

### Git命令详解
```sh
git init    ## 初始化项目
git clone   ## 克隆项目
git status  ## git状态查看(新文件，文件修改)
git add     ## 添加需要跟踪的文件
git commit  ## 提交更新
git push    ## 推送到远程仓库
git pull    ## 同步到本地仓库
git diff    ## 文件or 分支对比
git checkout## 切换or新建分支
git merge   ## 合并"分支"
git log     ## 历史日志(提交记录)
git reset   ## 版本"回退"
git reflog  ## 回到删除的未来版本
```
以上命令详细实践将在下面列出.

如果本文对您有所帮助，请给个`start`不胜感激，谢谢！

#### 在现有目录中初始化仓库

`git init`

```
[root@hadoop1]~/sell# git init
Initialized empty Git repository in /root/sell/.git/
[root@hadoop1]~/sell# ll -a
total 12
drwxr-xr-x   3 root root 4096 Mar 24 20:12 .
dr-xr-x---. 42 root root 4096 Mar 24 20:11 ..
drwxr-xr-x   7 root root 4096 Mar 24 20:12 .git
[root@hadoop1]~/sell#
```

该命令将创建一个名为 `.git` 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。 但是，在这个时候，我们仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪。### 克

#### 克隆现有的仓库

`git clone`

如果你想获得一份已经存在了的 Git 仓库的拷贝，比如说，你想为某个开源项目贡献自己的一份力，这时就要用到 `git clone` 命令。把代码从远程仓库例如Github上拉下来进行开发然后再推回远程仓库；例如我现在要从github上把我的web项目sell拉下来。

```sh
[root@hadoop1]~# git clone https://github.com/wuguozhu/sell.git
Cloning into 'sell'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 159 (delta 0), reused 2 (delta 0), pack-reused 156
Receiving objects: 100% (159/159), 41.07 KiB | 0 bytes/s, done.
Resolving deltas: 100% (39/39), done.
[root@hadoop1]~# cd sell
[root@hadoop1]~/sell# ll
total 28
-rw-r--r-- 1 root root 6468 Mar 24 20:21 mvnw
-rw-r--r-- 1 root root 4994 Mar 24 20:21 mvnw.cmd
-rw-r--r-- 1 root root 2738 Mar 24 20:21 pom.xml
-rw-r--r-- 1 root root   25 Mar 24 20:21 README.md
drwxr-xr-x 4 root root 4096 Mar 24 20:21 src
[root@hadoop1]~/sell#
```

Git 克隆的是该 Git 仓库服务器上的几乎所有数据，而不是仅仅复制完成你的工作所需要文件。 当你执行 `git clone` 命令的时候，默认配置下远程 Git 仓库中的每一个文件的每一个版本都将被拉取下来。

Git 支持多种数据传输协议。 上面的例子使用的是 `https://` 协议，不过你也可以使用 `git://` 协议或者使用 SSH 传输协议，比如 `git@github.com:wuguozhu/sell.git` 

#### 检查当前文件状态

`git status`

要查看哪些文件处于什么状态，可以用 `git status` 命令。 如果在克隆仓库后立即使用此命令，会看到类似这样的输出：

```sh
[root@hadoop1]~/sell# git status
# On branch master
nothing to commit, working directory clean
[root@hadoop1]~/sell#
```

这说明当前的工作目录相当干净。换句话说，所有已跟踪文件在上次提交后都未被更改过。 此外，上面的信息还表明，当前目录下没有出现任何处于未跟踪状态的新文件，否则 Git 会在这里列出来。

```sh
[root@hadoop1]~/sell# echo "# 666 system" >> README
[root@hadoop1]~/sell# ll
total 4
-rw-r--r-- 1 root root 13 Mar 24 21:02 README
[root@hadoop1]~/sell# git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       README
nothing added to commit but untracked files present (use "git add" to track)
[root@hadoop1]~/sell#
```

 在状态报告中可以看到新建的 README 文件出现在 `Untracked files`(未跟踪文件) 下面。我们下面要用`git add`跟Git”说“我们要跟踪某个文件.

**跟踪新的文件**

`git add`

```
[root@hadoop1]~/sell# git add README
[root@hadoop1]~/sell# git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   README
#
[root@hadoop1]~/sell#
```

只要在 `Changes to be committed` 这行下面的，就说明是已暂存状态。 如果此时提交，那么该文件此时此刻的版本将被留存在历史记录中。

`git add` 命令使用文件或目录的路径作为参数；如果参数是目录的路径，该命令将递归地跟踪该目录下的所有文件。

**跟踪修改文件**

```sh
[root@hadoop1]~/sell# echo "hello git" >> README.md
[root@hadoop1]~/sell# git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   README.md
#
no changes added to commit (use "git add" and/or "git commit -a")
[root@hadoop1]~/sell#
```





参考文章：

[Git官方文档](https://git-scm.com/book/zh/v2)

[Git 提交的正确姿势：Commit message 编写指南](https://www.oschina.net/news/69705/git-commit-message-and-changelog-guide)

[阮一峰Git入门](http://www.ruanyifeng.com/blog/2014/06/git_remote.html)

[Git原理和用法](https://www.jianshu.com/p/181e8adb36a6)

感谢以上原创作者

