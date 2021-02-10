Trait {
	#name : #EDALoggingSettingsPort,
	#traits : 'EDASettingsPort',
	#classTraits : 'EDASettingsPort classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDALoggingSettingsPort >> loggingLevel [
	self subclassResponsibility
]
