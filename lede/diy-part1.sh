#!/bin/bash
#

#切换成5.15内核
#git checkout -f 8cf859bf012c9619d56cf90e567a381edd1119d8
# 修改Makefile
#sed -i '/KERNEL_PATCHVER/d' ./target/linux/x86/Makefile
#sed -i '/^KERNEL_TESTING_PATCHVER/i KERNEL_PATCHVER:=5.15' ./target/linux/x86/Makefile

echo "run scripts update && install"

./scripts/feeds update -a
./scripts/feeds install -a
