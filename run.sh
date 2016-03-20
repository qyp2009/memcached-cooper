path=`dirname $0`
$path/memcached -u root -l 172.18.11.204 -p 11211 -t 4 -c 2048 -vvv
