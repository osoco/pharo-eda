dependencies
declareMongotalkIn: spec
	spec
		baseline: 'MongoTalk'
		with: [ spec
				repository: 'github://pharo-nosql/mongotalk:master/mc' ].
	^ spec
