# DevPodTestGo
测试提交到官网Pod


1:在github个人账户下创建一个新的代码仓库

2:使用github客户端将本仓库拷贝到本地

3:将要提交的文件放在本地仓库中

4:创建podspec文件

pod spec create ProductName

5：命令进行验证

pod lib lint ProductName.podspec

6：注册CocoaPods账号，邮件验证(如果已经注册了，就不需要)

pod trunk register xxx@xx.com '名称' --description='提交描述'

7：检查账号是否创建成功

pod trunk me

8：检测文件格式的有效性

pod spec lint --allow-warnings

9：提交上传

pod trunk push ProductName.podspec --allow-warnings

10：验证是否上传成功

pod search ProductName

注意：release版本不能带v. 直接如：0.0.1 否则会报，查找不到版本：

[iOS] unknown: Encountered an unknown error ([!] /usr/bin/git clone https://github.com/wujunyang/testCocoaPod.git /var/folders/qw/nrvzl2sj2l98qgpyqq6b3qvh0000gn/T/d20161101-11140-19txqzy --template= --single-branch --depth 1 --branch 0.0.1

注意：命名最好是有代表性，避免跟别人一样，否则会导致上传失败

成功后显示如下：

-> ProductName (0.0.1) A short description of ProductName. pod 'ProductName', '~> 0.0.1'

Homepage: https://github.com/xxx/ProductName
Source: https://github.com/xxx/ProductName.git
Versions: 0.0.1 [master repo]
