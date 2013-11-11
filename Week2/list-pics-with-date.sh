#! /bin/bash
ls -R ~tkt_cam/public_html/ | grep '2011'$(date +%m%d)'[0-9]\{4\}.jpg'
