if [ ! -e "/var/www/html.headlessModeFiles" ]; then
        mv /var/www/html /var/www/html.headlessModeFiles
        mv /var/www/html.headlessModeOnSoHideTheseOriginalFiles /var/www/html
else
        echo "Not in headless mode"
fi
