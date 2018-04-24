# UploadPackage2PGY
通过脚本实现自动打包到上传蒲公英。

![这就是全自动的打包到上传的脚本](https://upload-images.jianshu.io/upload_images/1198135-c052d7e474bc58f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 用法
在当前项目的目录中放入两个文件: UploadPackage2PGY.sh 与 ExportOptions.plist . 其中 ExportOptions.plist 是根据项目而定的, 一般可以使用Xcode打包自动生成的那个文件即可.

直接在终端输入： 
sh UploadPackage2PGY.sh <项目名称> <更新日志>

比如:
sh UploadPackage2PGY.sh HGPGY 在使用高大上的脚本做打包上传.



#### 详情请参考我的简书：：https://www.jianshu.com/p/7fe1c8b44023

