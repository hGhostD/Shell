
#苹果iTunesconnect账户
Apple_accound=hyugecn@163.com
Apple_password=ppjm-cchn-hyoz-pmcp
Apple_ID=1230879053
#Fir.im 账户
Fir_Token=554c539d32252425f397dbf39e1831d9
Fir_AppID=c69c74b74b1c441e951a20ed801f8774
#参数传递目标工程
rootPath=$1
project_name=$(basename $rootPath)
#在当前位置创建build目录 用于放置ipa文件
buildPath=$(pwd)/build
IPAPATH=$buildPath/ipa
#打包时间
BuildDate=$(date +%Y%m%d%H%M)
#打包模式 Debug/Release
development_mode=Release

#plist文件所在路径
exportOptionsPlistPath=$(pwd)/exportOptions.plist

#导出.ipa文件所在路径
exportFilePath=$buildPath/ipa/${development_mode}
 
setupBuild() {
echo '============================ 正在 修改Build ============================' 
cd $rootPath/$project_name
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BuildDate" Other/Info.plist || exit
echo '============================ 修改完成 ============================'
}

productIPA() {
echo '============================ 正在 打包 ============================'
# mkdir -p $exportFilePath
# cd $rootPath
# ipa build -w $project_name.xcworkspace -s $project_name --clean \
# -d $exportFilePath -c $development_mode --verbose
# mv $project_name.ipa $IPAPATH/$development_mode
# rm $project_name.app.dSYM.zip
# rm -rf build

xcodebuild \
archive -workspace ${rootPath}/${project_name}.xcworkspace \
-scheme ${project_name} \
-configuration ${development_mode} \
-archivePath ${buildPath}/${project_name}.xcarchive -quiet  || exit

xcodebuild -exportArchive -archivePath ${buildPath}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportFilePath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

if [ -e $exportFilePath/$project_name.ipa ]
then
    echo "*** $project_name.ipa文件已导出 $exportFilePath ***"
    return 1
else
    echo "*** 创建.ipa文件失败 ***"
    return 0
fi

echo '============================ 打包完成 ============================'
}

uploadToFirIm() {
	echo '============================ 正在 上传 ============================' 
	fir login -T $Fir_Token
	fir publish $exportFilePath/$project_name.ipa
	echo '============================ 上传完成 ============================'
}

uploadToAppStore() {
echo '============================ 正在 上传 ============================'

ipa distribute:itunesconnect -f $exportFilePath/$project_name.ipa -a \
$Apple_accound -p $Apple_password -i $Apple_ID --upload --verbose

echo '============================ 上传完成 ============================'
}





main() {
	# #2修改Build
	setupBuild
	# #4打包iPA文件
	productIPA
  	#5上传
 	uploadToFirIm
 	# uploadToAppStore
}
main