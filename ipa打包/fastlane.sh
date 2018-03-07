#!/bin/bash
#Fir Token
Fir_token=554c539d32252425f397dbf39e1831d9
#设置超时
export FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT=120

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下

project_path=$1
# project_path=/Users/mac/Desktop/2017/ios/HiDoc
project_name=$(basename $project_path)
#输出文件位置
project_out_path=$(pwd)/fastlane
#取当前时间字符串添加到文件结尾
now=$(date +"%Y-%m-%d-%H:%M:%S")

#指定项目的scheme名称
scheme=$(basename $project_path)
#指定要打包的配置名
configuration=${scheme}
#bundle ID 
bundle_id="PRODUCT_BUNDLE_IDENTIFIER=com.cybeye.ZhaoShang \
		   PROVISIONING_PROFILE=ZhaoShangDis"
#plist 文件路径
export_options="$(pwd)/ExportPlist/ExportOptions_${scheme}.plist"

#指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development, 和developer-id，即xcodebuild的method参数
export_method="app-store"

#指定项目地址
workspace_path="$project_path/$scheme.xcworkspace"
#指定输出路径
output_path="$project_out_path"
#指定输出归档文件地址
archive_path="$output_path/${scheme}_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/${scheme}_${now}.ipa"
#指定输出ipa名称
ipa_name="${scheme}_${now}.ipa"
#获取执行命令时的commit message
commit_msg=$2




#输出设定的变量值
echo "===workspace path: ${workspace_path}==="
echo "===archive path: ${archive_path}==="
echo "===ipa path: ${ipa_path}==="
echo "===export method: ${export_method}==="
echo "===commit msg: $2==="

#先清空前一次build
fastlane gym --workspace ${workspace_path} \
 	--scheme ${scheme} --clean \
	--configuration  ${configuration} \
	--xcargs ${bundle_id} \
	--archive_path ${archive_path} \
	--export_options ${export_options} \
	--output_directory ${output_path} \
	--output_name ${ipa_name}

#上传到fir
fir publish ${ipa_path} -T Fir_token -c "${commit_msg}"

#输出总用时
echo "===Finished. Total time: ${SECONDS}s==="