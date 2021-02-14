Trait {
	#name : #EDAEnvironmentSettingsPort,
	#traits : 'EDASettingsPort',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDAEnvironmentSettingsPort >> availableEnvironments [
	self subclassResponsibility
]

{ #category : #testing }
EDAEnvironmentSettingsPort >> supportsMultiple [
	self subclassResponsibility
]
