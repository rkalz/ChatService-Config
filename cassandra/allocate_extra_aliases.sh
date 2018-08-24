if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo ifconfig lo0 alias 127.0.0.2 up
    sudo ifconfig lo0 alias 127.0.0.3 up
else
    sudo ip addr add 127.0.0.2 dev lo
    sudo ip addr add 127.0.0.3 dev lo
fi