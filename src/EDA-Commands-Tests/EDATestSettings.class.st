"
Class: EDATestSettings 

Adds some explicit configuration settings for integration tests.

Responsibility:

Creates a new menu to explicitly configure test-specific settings.
"
Class {
	#name : #EDATestSettings,
	#superclass : #EDASettings,
	#category : 'EDA-Commands-Tests'
}

{ #category : #settings }
EDATestSettings class >> commandPublisherSettingsOn: aBuilder [
	(aBuilder group: #testCommandPublisher)
		label: 'Command Publisher' translated;
		description: 'Command Publisher (for integration tests)' translated;
		parent: #edatests.

	^ self stompPublisherSettingsOn: aBuilder withConfig: EDACommandStompTopicPublisher under: #testCommandPublisher populatedWithValuesFrom: 'testCommandPublisher'
		
]

{ #category : #initialization }
EDATestSettings class >> doInitialize [
	self duEnvironmentClass: EDATestDUEnvironment
]

{ #category : #settings }
EDATestSettings class >> edaTestSettingsOn: aBuilder [
	"<systemsettings>"
	(aBuilder group: #edatests)
		label: 'EDA Tests' translated;
		description: 'EDA tests';
		noOrdering;
		parent: #eda.
	self commandPublisherSettingsOn: aBuilder.
	self eventListenerSettingsOn: aBuilder.
	self queueCleaningSettingsOn: aBuilder
]

{ #category : #settings }
EDATestSettings class >> eventListenerSettingsOn: aBuilder [
	(aBuilder group: #testEventListener)
		label: 'Event Listener' translated;
		description: 'Event Listener (for integration tests)' translated;
		parent: #edatests.
	^ self
		stompListenerSettingsOn: aBuilder
		withConfig: EDATestEventStompTopicListener
		under: #testEventListener
		populatedWithValuesFrom: 'testEventListener'
]

{ #category : #initialization }
EDATestSettings class >> initialize [
	self doInitialize 
]

{ #category : #settings }
EDATestSettings class >> queueCleanerSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: config [
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'RabbitMQ host' translated;
		description: 'RabbitMQ host address' translated;
		order: 1;
		default: (config at: 'host').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'RabbitMQ HTTP port' translated;
		description: 'RabbitMQ HTTP port' translated;
		default: (config at: 'httpPort').
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'RabbitMQ user' translated;
		description: 'RabbitMQ admin username' translated;
		default: (config at: 'user').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'RabbitMQ password' translated;
		description: 'RabbitMQ admin password' translated;
		default: (config at: 'password')
]

{ #category : #settings }
EDATestSettings class >> queueCleaningSettingsOn: aBuilder [
	| extSettings |
	(aBuilder group: #testQueueCleaning)
		label: 'Queue cleaning' translated;
		description: 'Queue cleaning (for integration tests)' translated;
		parent: #edatests.
	extSettings := self retrieveSettingAsDict: 'queueCleaner'.
	^ self
		queueCleanerSettingsOn: aBuilder
		withConfig: EDAQueueCleaner
		under: #testQueueCleaning
		populatedWithValuesFrom: extSettings
]
