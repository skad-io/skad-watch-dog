if [ -e "/var/www/html.headlessModeFiles" ]; then
        mv /var/www/html /var/www/html.headlessModeOnSoHideTheseOriginalFiles
        mv /var/www/html.headlessModeFiles /var/www/html
else
        echo "Already in headless mode"
fi
