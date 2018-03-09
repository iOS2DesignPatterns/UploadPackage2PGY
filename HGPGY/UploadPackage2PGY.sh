
if [ "$#" -eq "2" ]; then

    # 构建 .xcarchive 文件
    xcodebuild archive -project "$1".xcodeproj -scheme "$1" -configuration Release -archivePath "$1".xcarchive

    # 通过 .xcarchive 文件 导出 .ipa 的包
    xcodebuild -exportArchive -archivePath "$1".xcarchive -exportPath "$1".ipa -exportOptionsPlist ExportOptions.plist

    # 将 .ipa 的包上传至蒲公英平台
    curl -F "file=@$1.ipa/$1.ipa" \
    -F "uKey=8e117ad6b8f7b4dae90eaa5d83f3572b" \
    -F "_api_key=7511c8d362ad4497eaa80179d0695a34" \
    -F "updateDescription=$2" \
    https://www.pgyer.com/apiv1/app/upload

else 
    # 错误信息提示
    echo '输入正确的命令:'
    echo "bash $0 项目名称 更新描述"
    echo "sh   $0 项目名称 更新描述"
    echo ".    $0 项目名称 更新描述"

fi
