Trait {
	#name : #EDATLoggingSettingsPort,
	#traits : 'EDATSettingsPort',
	#classTraits : 'EDATSettingsPort classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDATLoggingSettingsPort >> loggingLevel [
	self subclassResponsibility
]
