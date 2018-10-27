#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import sys
import commands

# APP 名称 比如(AppStoreDev)
AppNmae = '请输入你 APP的名称, 不待.app'
# 证书编号
CertificateNumber = '请输入你的证书编号'
# 签名文件的路径
EntitlementPath = '请输入你的签名文件的路径'

# 当前文件夹的绝对路径 会在第一个参数中带进来
CurAbsolutePath = sys.argv[1]

# 拼成 Frameworks 的路径
FrameworksPath = CurAbsolutePath + '/' + AppNmae + '.app/Frameworks/'

# 执行终端指令
def hg_commands(cmd):
    lc = commands.getstatusoutput('' + cmd)
    print(lc)

# 需要签名的文件
files = []
# 获取所有需要重签名的动态库文件路径
for parent, dirnames, filenames in os.walk(FrameworksPath):
	for filename in filenames:
		# 模板字符串
		template = FrameworksPath + filename + '.framework/' + filename
		# 拼接成完整的路径
		resulteFile = parent + '/' + filename
		# 判断是否与模板字符一致
		if template == resulteFile:
			files.append(resulteFile)

# 给动态库文件签名
for file in files:
	hg_commands('codesign -fs ' + CertificateNumber + ' ' + file)


# 签名整个 .app 文件
hg_commands('/usr/bin/codesign --force --sign ' + CertificateNumber + ' --entitlements ' + EntitlementPath + ' --timestamp=none ' + CurAbsolutePath + '/' + AppNmae + '.app')

# 完事!!!
print('签名完毕')
