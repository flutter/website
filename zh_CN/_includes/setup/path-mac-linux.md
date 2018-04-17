### 更新你的路径

你只能在命令行中更新你当前会话窗口的 PATH 变量，如[克隆 Flutter 库](./#clone-the-repo)所示。当永久更新这个变量，这样子你就可以在任意终端会话中运行 `flutter` 命令了。

对于计算机来说，永久给全部终端会话修改这个变量这些操作都是不同的。通常，你会打开新窗口时将命令输入。举个例子：

1. 确定好放置 Flutter SDK 的目录，你会在步骤 3 用到它。
2. 打开（或者创建） `$HOME/.bash_profile` 这个文件或者文件名可能不同于你计算机的。
3. 添加下面命令行并将`[PATH_TO_FLUTTER_GIT_DIRECTORY]` 改为你克隆 Flutter 仓库的路径：

{% commandline %}
export PATH=[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin:$PATH
{% endcommandline %}

4. 运行 `source $HOME/.bash_profile` 刷新当前窗口。
5. 验证 `flutter/bin` 是否在你的路径上：

{% commandline %}
echo $PATH
{% endcommandline %}

更多的细节，可以参阅[ StackExchange 上的问题](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path)。
