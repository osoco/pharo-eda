lifecycle
defaultSettingsCheck
	self flag: #TODO. "Very ugly hack to force the Settings framework to load config before run the tests."
	EDAStompTopicPublisher ifNil: [ self loadSettings ].
	EDAStompTopicPublisher host ifNil: [ self loadSettings ].	