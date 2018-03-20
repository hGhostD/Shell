Fir_token="554c539d32252425f397dbf39e1831d9"
# 参数传递目标工程 和 版本号
rootPath=$1
version=$2
# 工程名默认与文件夹同名
project_name=$(basename $rootPath)
# scheme 默认与工程名同名
scheme_name=$project_name
# 打包时间 设置为 build 号码
BuildDate=$(date +%Y%m%d%H%M)

# Info.plist 文件路径
infoPath=$project_name/Info.plist

# 指定项目地址
workspace_path="$rootPath/$scheme_name.xcworkspace"
# 指定输出路径
output_path=$(pwd)/build
# 指定输出归档文件地址
archive_path="$output_path/archive/${scheme_name}_${BuildDate}.xcarchive"
# 指定输出ipa地址
ipa_path="$output_path/$scheme_name"
# 指定输出ipa名称
ipa_name="${scheme_name}_${BuildDate}.ipa"

echo "============================ 正在 修改Build ============================"
cd $rootPath
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version" $infoPath || exit
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BuildDate" $infoPath || exit
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!! 修改 完成 ${version} ${BuildDate}   !!!!!!!!!!!!!!!!!!!!!!!!!!!!"

echo "============================ 开始打包 ipa 文件 ============================"
echo ${scheme_name}
fastlane fir scheme:"${scheme_name}" \
			 buildDate:"${BuildDate}" \
			 archive_path:"${archive_path}" \
			 outPath:"${ipa_path}" \
			 ipa_name:"${ipa_name}"

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!! 打包完成 !!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 上传到fir
# echo "============================ 开始上传 ipa 文件 ============================"
# fir publish "${ipa_path}/${ipa_name}" -T "${Fir_token}" -c
# echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!! 上传完成 !!!!!!!!!!!!!!!!!!!!!!!!!!!!"
