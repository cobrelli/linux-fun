#! /bin/bash
find  ~tkt_cam/public_html/ -regextype posix-extended -regex '.*/2011'$(date +%m%d)'[0-9]{4}.jpg' | wc -l
