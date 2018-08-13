#!/bin/sh
 
#
# Examples of Parsing an Nginx Access Log w/ Awk
#
# Hat tip:
# https://easyengine.io/tutorials/nginx/log-parsing/
#
# --------------------------------------
# Expected Nginx Access Log File Format
# --------------------------------------
#
# log_format  main  '$remote_addr - $remote_user [$time_local] $scheme $host "$request" '
#     '$status $body_bytes_sent "$http_referer" '
#     '"$http_user_agent" "$http_x_forwarded_for"';
#
 
ACCESS_LOG=/var/log/nginx/access.log
 
list_all_by_response_code()
{
    awk '{print $11}' "${ACCESS_LOG}" \
        | sort \
        | uniq -c \
        | sort -rn
}
 
list_by_response_code()
{
    local response_code=$1
 
    awk -v var=$response_code '($11 ~ var)' "${ACCESS_LOG}" \
        | awk '{print $9}' \
        | sort \
        | uniq -c \
        | sort -rn
}
 
list_top_requests()
{
    awk -F\" '{print $2}' "${ACCESS_LOG}" \
        | awk '{print $2}' \
        | sort \
        | uniq -c \
        | sort -r
}
 
list_top20_requests()
{
    awk -F\" '{print $2}' "${ACCESS_LOG}" \
        | awk '{print $2}' \
        | sort \
        | uniq -c \
        | sort -r \
        | head -20
}
 
list_requests_with_gt5_hits()
{
    awk -F\" '{print $2}' "${ACCESS_LOG}" \
        | awk '{print $2}' \
        | sort \
        | uniq -c \
        | sort -r \
        | awk '$1 > 5'
}
 
list_top_requests_by_keyword()
{
    local keyword=$1
 
    awk -v var=$keyword -F\" '($2 ~ var){print $2}' "${ACCESS_LOG}" \
        | awk '{print $2}' \
        | sort \
        | uniq -c \
        | sort -r
}
 
list_missing_php_requests()
{
    awk '($11 ~ 404)' "${ACCESS_LOG}" \
        | awk -F\" '($2 ~ "^GET .*\.php")' \
        | awk '{print $9}' \
        | sort \
        | uniq -c \
        | sort -r \
        | head -n 20
}
 
main()
{
    # list_all_by_response_code
    # list_by_response_code 404
    # list_top_requests
    # list_top20_requests
    # list_requests_with_gt5_hits
    # list_top_requests_by_keyword sql
    # list_missing_php_requests
}

main