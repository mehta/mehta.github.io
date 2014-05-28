#!/bin/bash

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '</head>'
echo '<body>'
echo 'done'
echo '</body>'
echo '</html>'

GIT_REPO=https://github.com/mehta/mehta.github.io.git
TMP_GIT_CLONE=/home/www-data/tmp/your_git_repo
PUBLIC_WWW=/var/www/web
MAILGUN_KEY=xxxxx

git clone $GIT_REPO $TMP_GIT_CLONE
jekyll build -s $TMP_GIT_CLONE -d $PUBLIC_WWW
rm -Rf $TMP_GIT_CLONE

curl -s --user '$MAILGUN_KEY' \
    https://api.mailgun.net/v2/abhinavmehta.com/messages \
    -F from='Zeus <zeus@abhinavmehta.com>' \
    -F to='mail@abhinavmehta.com' \
    -F subject='.:: abhinavmehta.com got updated ::.' \
    -F text='Abhinav --- we just updated your blog server.'

exit 0
