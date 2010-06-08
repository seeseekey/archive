# ChronoTweet v0.30
# http://seeseekey.net
#
# Installation
# http://pypi.python.org/pypi/simplejson installieren (apt-get install python-simplejson)
# http://code.google.com/p/python-twitter/ installieren
# wget http://python-twitter.googlecode.com/files/python-twitter-0.6.tar.gz
# tar -xf python-twitter-0.6.tar.gz
# cd python-twitter-0.6
# python setup.py build
# python setup.py install
#
# chrono_tweet - Dateirechte 700
# crontab -e
# */1 *    * * *   python /root/chrono_tweet.py

# Import
import time
import twitter

# Optionen
twitter_account_name = "seeseekey"
twitter_account_password = "secret"

remove_time_in_seconds = 151200 # 42 Stunden

hashtag_sensitive=False
hashtag="#ChronoTweet"

# Programmlogik
api = twitter.Api(username=twitter_account_name, password=twitter_account_password)
stati = api.GetUserTimeline(twitter_account_name, 9999999)

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