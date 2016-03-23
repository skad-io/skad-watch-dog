echo 'Run this as root to get the full list of available networks'
iwlist wlan0 scan | grep 'ESSID\|Quality'
