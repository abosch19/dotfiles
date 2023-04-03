ip() {
 ifconfig en0 | awk '$1 == "inet" {print $2}'
}

killport() {
 kill -6 $(lsof -t -i:$1 | awk '{print $2}')
}
