

# 蒲公英账号信息 (在实际项目中, 可以换成自己的, 当然可以使用我的这个,在上传成功之后, 会有一个蒲公英的 URL)
pgyuKey="8e117ad6b8f7b4dae90eaa5d83f3572b"
pgy_api_key="7511c8d362ad4497eaa80179d0695a34"

if [ "$#" -eq "2" ]; then
    # 每次打包自动修改 build , 将其设置成当前的时间, 精确到秒
    date2Build=`date "+%Y%m%d%H%M%S"`
    # 路径可根据实际项目做配置
    InfoPlistFile="./$1/Info.plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $date2Build" $InfoPlistFile

    if [ -d "$1".xcworkspace ];then
      echo "Pod 项目打包中..."
      # 构建 .xcarchive 文件
      xcodebuild archive -workspace "$1".xcworkspace -scheme "$1" -configuration Release -archivePath "$1".xcarchive
    else
      echo "项目打包中..."
      # 构建 .xcarchive 文件
      xcodebuild archive -project "$1".xcodeproj -scheme "$1" -configuration Release -archivePath "$1".xcarchive
    fi

    # .ipa 的文件夹
    ipaFolder="../$1"_"$date2Build"

    # 通过 .xcarchive 文件 导出 .ipa 的包
    xcodebuild -exportArchive -archivePath "$1".xcarchive -exportPath "$ipaFolder".ipa -exportOptionsPlist ExportOptions.plist

    # 将 .ipa 的包上传至蒲公英平台
    curl -F "file=@$ipaFolder.ipa/$1.ipa" \
    -F "uKey=$pgyuKey" \
    -F "_api_key=$pgy_api_key" \
    -F "updateDescription=$2" \
    https://www.pgyer.com/apiv1/app/upload

    # 删除中间文件
    rm -r "$1".xcarchive
else 
    # 错误信息提示
    echo '输入正确的命令:'
    echo "bash $0 项目名称 更新描述"
    echo "sh   $0 项目名称 更新描述"
    echo ".    $0 项目名称 更新描述"
fi
