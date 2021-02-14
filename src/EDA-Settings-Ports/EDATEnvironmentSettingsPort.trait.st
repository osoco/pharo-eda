Trait {
	#name : #EDATEnvironmentSettingsPort,
	#traits : 'EDATSettingsPort',
	#classTraits : 'EDATSettingsPort classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDATEnvironmentSettingsPort >> availableEnvironments [
	self subclassResponsibility
]

{ #category : #testing }
EDATEnvironmentSettingsPort >> supportsMultiple [
	self subclassResponsibility
]
