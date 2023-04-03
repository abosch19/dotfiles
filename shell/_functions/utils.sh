ip() {
 ifconfig en0 | awk '$1 == "inet" {print $2}'
}

killport() {
  if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi

    port=$1
    pid=$(lsof -t -i:$port)

    if [ -z "$pid" ]; then
        echo "No process running on port $port"
        return 1
    fi

    echo "Killing process $pid on port $port"
    kill -9 "$pid"
}
