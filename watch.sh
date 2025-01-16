#!/bin/zsh

source ~/.zshrc


echo "Script started at: $(TZ='Asia/Tehran' date '+%Y-%m-%d %H:%M:%S') (Iran Time)" >> ~/watchTower/watch.log

watch_sync_programs
watch_enum_all
watch_ns_all
watch_http_all
#watch_nuclei_all

echo "Script ended at: $(TZ='Asia/Tehran' date '+%Y-%m-%d %H:%M:%S') (Iran Time)" >> ~/watchTower/watch.log
