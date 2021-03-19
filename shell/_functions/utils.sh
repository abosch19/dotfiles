ip() {
 ifconfig en0 | awk '$1 == "inet" {print $2}'
}

killport() {
 kill -6 $(lsof -i tcp:$1 | awk '{print $2}')
}
