Trait {
	#name : #EDATEnvironmentSettingsPort,
	#traits : 'EDATSettingsPort',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDATEnvironmentSettingsPort >> availableEnvironments [
	self subclassResponsibility
]

{ #category : #testing }
EDATEnvironmentSettingsPort >> supportsMultiple: aSymbol [
	self subclassResponsibility
]
