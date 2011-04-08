# ChronoTweet v0.30
# http://seeseekey.net
#
# Installation
# http://pypi.python.org/pypi/simplejson installieren (apt-get install python-simplejson)
# http://code.google.com/p/httplib2/ installieren (apt-get install python-httplib2)
# https://github.com/simplegeo/python-oauth2 installieren (apt-get install python-oauth2 //ab natty)
# apt-get install python-setuptools
# git clone https://github.com/simplegeo/python-oauth2.git
# cd python-oauth2
# python setup.py build
# python setup.py install
# http://code.google.com/p/python-twitter/ installieren
# wget http://python-twitter.googlecode.com/files/python-twitter-0.8.1.tar.gz
# tar -xf python-twitter-0.8.1.tar.gz
# cd python-twitter-0.8.1
# python setup.py build
# python setup.py install
# https://twitter.com/apps/new - register app
#
# edit get_access_token.py and add consumer key and secret
# execute the script and paste the generated ids into the vars
#
# chrono_tweet - Dateirechte 700
# crontab -e
# */1 *    * * *   python /root/chronotweet/chronotweet.py

# Import
import time
import twitter

# Optionen
twitter_account_name = "seeseekey"

twitter_consumer_key = ""
twitter_consumer_secret = ""
twitter_access_token_key = ""
twitter_access_token_secret = ""

remove_time_in_seconds = 151200 # 42 Stunden

hashtag_sensitive=False
hashtag="#ChronoTweet"

# Programmlogik
api = twitter.Api(consumer_key=twitter_consumer_key, consumer_secret=twitter_consumer_secret, access_token_key=twitter_access_token_key, access_token_secret=twitter_access_token_secret) 

stati = api.GetUserTimeline(twitter_account_name, 99999999)

for s in stati: #Fuer jeden Status
	currentTime = time.mktime(time.localtime(time.time()))
	createTime = s.GetCreatedAtInSeconds()
	diffTime = currentTime-createTime
	
	if diffTime > remove_time_in_seconds: #Wenn Zeit groesser remove_time_in_seconds
	
		if hashtag_sensitive==True:
			if s.text.find(hashtag) != -1: #Wenn ChronoTweet
				print(s.id)
				api.DestroyStatus(s.id)
		else:
			print(s.id)
			api.DestroyStatus(s.id)