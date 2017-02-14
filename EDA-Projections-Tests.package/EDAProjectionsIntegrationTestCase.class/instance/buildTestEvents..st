test - fixture
buildTestEvents: iterations
	| applicationId achievementKeyPrefix playerIdPrefix events |
	applicationId := 'test-app'.
	achievementKeyPrefix := 'test-achievement-key'.
	playerIdPrefix := 'test-player'.
	events := OrderedCollection new.
	1 to: iterations do: [ :i |
		|achievementKey playerId|
		achievementKey := achievementKeyPrefix , '-' , i asString.
		playerId := playerIdPrefix , '-' , i asString.
		events add: (GCApplicationCreated withCommandId: ('C', i asString) applicationKey: applicationId).
		events add: (GCAchievementTypeCreated withCommandId: 'command-1' applicationKey: applicationId key: achievementKey).
		events add: (GCNewPlayerCreated playerId: playerId on: applicationId).
		events
			add:
				(GCAchievementGranted
					key: achievementKey
					on: applicationId
					to: playerId
					at: DateAndTime now) ].
	^ events