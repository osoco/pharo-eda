Trait {
	#name : #EDAEnvironmentSettingsPort,
	#traits : 'EDASettingsPort',
	#classTraits : 'EDASettingsPort classTrait',
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
