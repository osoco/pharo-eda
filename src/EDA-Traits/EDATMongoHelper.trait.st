Trait {
	#name : #EDATMongoHelper,
	#traits : 'EDATCollectionHelper',
	#category : #'EDA-Traits'
}

{ #category : #'repository configuration' }
EDATMongoHelper classSide >> configReplicationOnRepository: mongoRepository [
	self enableReplication
		ifNotNil: [ :replication | 
			| replicationDebugMessage |
			replicationDebugMessage := 'Non-configurable replication.'.
			replication
				ifTrue: [ [ mongoRepository enableReplication ]
						on: MessageNotUnderstood
						do: [ :ex |
							self logDebugMessage: replicationDebugMessage ] ]
				ifFalse: [ [ mongoRepository disableReplication ]
						on: MessageNotUnderstood
						do: [ :ex |
							self logDebugMessage: replicationDebugMessage ] ] ]
]

{ #category : #'repository configuration' }
EDATMongoHelper classSide >> configSingletonOnRepository: mongoRepository [.
	self enableSingleton ifNotNil: [ :singleton |
		singleton
			ifTrue: [ mongoRepository enableSingleton ]
			ifFalse: [ mongoRepository disableSingleton ] ].
]

{ #category : #'refresh settings' }
EDATMongoHelper classSide >> refreshVoyageSettingsOn: aRepository [
	aRepository username: self username.
	aRepository password: self password.
	aRepository debug: self debug.
	self configReplicationOnRepository: aRepository.
	aRepository ensuringCurrentOnSave: self ensuringCurrentOnSave.
	aRepository ensuringCurrentReferencesOnQueries: self ensuringCurrentReferencesOnQueries.
	aRepository lazySynchronize: self lazySynchronize.
	self configSingletonOnRepository: aRepository.
	aRepository wireProtocolEnabled: self wireProtocolEnabled
]

{ #category : #persistence }
EDATMongoHelper >> initBackendRepository [
	| result |
	result := self mongoRepositoryClass
		mongoUrls: (self csvToCollection: self class urls)
		database: self class databaseName
		username: self class username
		password: self class password.
	"result cache: EDAMongoNoCache new."
	result debug: self class debug.
		"self class enableReplication
		ifTrue: [ result enableReplication ]
		ifFalse: [ result disableReplication ]."
	self class enableSingleton
		ifTrue: [ result enableSingleton ]
		ifFalse: [ result disableSingleton ].
	result ensuringCurrentOnSave: self class ensuringCurrentOnSave.
	result
		ensuringCurrentReferencesOnQueries: self class ensuringCurrentReferencesOnQueries.
	result
		ensuringCurrentReferencesOnQueries: self class ensuringCurrentReferencesOnQueries.
	result lazySynchronize: self class lazySynchronize.
"	result wireProtocolEnabled: self class wireProtocolEnabled."
	^ result
]
