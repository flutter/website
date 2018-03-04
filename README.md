# Flutter 官网中文版

尝鲜网址 [Flutter](http://doc.flutter-dev.cn)（后期可能会变）



## 翻译准备工作及步骤

安装 Jekyll 以及以下介绍中Github 提供的的工具。

[instructions](https://help.github.com/articles/using-jekyll-with-pages/)


1.确保安装了 [Ruby](https://www.ruby-lang.org/en/documentation/installation/) 且 Ruby 的版本应大于 2.2.2。

`ruby --version`

2.确保安装了 [Bundler](http://bundler.io/) 。

`gem install bundler`

3.安装依赖。

`bundle install`

4.fork 本项目。

5.去 qq 群 482462550 中向群主认领翻译任务。

6.由群主邀请进入 [flutter-dev](https://github.com/flutter-dev) 组织并指派任务给认领者。

7.认领者将 fork 的项目同步到本地并切换到 **zh-cn** 分支进行翻译。

8.本地查看翻译结果，在项目根目录下执行以下命令查看翻译后的效果。

`bundle exec jekyll serve` (或者 `jekyll serve -w --force_polling`)

9.完成翻译并确保翻译无误。

10.向 **zh-cn** 分支提交 pull request，由群主确认后进行 merge 。

11.由群主关闭对应翻译 issue 。

## 注意事项
1. 提交时，comment 的写法为 `transition + path ` 如：`transition website/index.md`
2. 专有名词，类名，关键字与约定俗成的单词或词组无需翻译。如：`Material Design`, `Widget` 等。
3. 当中英数字混合的时候，中文和英文与数字间应添加空格，如 Flutter 在 Github 上目前有 15269 个 star 。

## 任务认领及进度
| 任务文件 | url | 是否完成 | 译者 |
| ---------- | --- | ----------- | ----- |
| website/index.md |http://doc.flutter-dev.cn/  | ok | [_番茄沙司](https://github.com/ZhangQinglian) | 
| website/_includes/sidebar.html | http://doc.flutter-dev.cn/docs/ | ok | [_番茄沙司](https://github.com/ZhangQinglian) | 
| website/_includes/footer.html |http://doc.flutter-dev.cn/  |  ok | [\_番茄沙司](https://github.com/ZhangQinglian) | 
| website/get-started/codelab/index.md | http://doc.flutter-dev.cn/get-started/codelab/  | no | [MelonRice](https://github.com/MelonRice) | 
| website/get-started/setup_windows.md |  http://doc.flutter-dev.cn/setup-windows/  |  no  |  [gdmec07120731](https://github.com/gdmec07120731)  |
| website/bug_reports.md |http://doc.flutter-dev.cn/bug-reports/ | no | |
| website/bootstrap-into-dart.md  |  http://doc.flutter-dev.cn/bootstrap-into-dart/ | no | |
| website/android-release-build.md|  http://doc.flutter-dev.cn/android-release/ | no   |     |   
| website/404.md  | http://doc.flutter-dev.cn/404 | no   |     |   
| website/docs.md | http://doc.flutter-dev.cn/docs/ |  no  |     |   
|    |    |   |     |   
