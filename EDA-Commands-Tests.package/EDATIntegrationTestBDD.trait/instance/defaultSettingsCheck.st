lifecycle
defaultSettingsCheck
	self flag: #TODO.	"Very ugly hack to force the Settings framework to load config before run the tests."
	EDAStompTopicPublisher host ifNil: [ self loadSettings ].
	EDAStompTopicListener host ifNil: [ self loadSettings ].