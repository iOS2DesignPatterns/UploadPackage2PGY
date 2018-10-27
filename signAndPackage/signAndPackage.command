 #!/bin/bash
 DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 运行终端的函数
function run {
	echo "Executing command: $@"
	$@
	if [[ $? != "0" ]]; then
		echo "Executing the above command has failed!"
		exit 1
	fi
}

# 主要是解压的时候用到
function run_at {
	pushd $1
	shift
	run $@
	popd
}

# 使用 python 自动签名
run "python ${DIR}/sign.py ${DIR}"

run "rm -rf ${DIR}/Target.ipa ${DIR}/Payload"
run "mkdir ${DIR}/Payload"

APP=$(find ${DIR} -type d | grep ".app$" | head -n 1)

run "cp -rf ${APP} ${DIR}/Payload"
run_at ${DIR} "zip -qr Target.ipa Payload"
run "rm -rf ${DIR}/Payload"

echo "==================CoderHG(done)=================="

exit;