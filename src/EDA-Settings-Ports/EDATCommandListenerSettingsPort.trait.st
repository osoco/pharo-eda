Trait {
	#name : #EDATCommandListenerSettingsPort,
	#traits : 'EDATSettingsPort',
	#classTraits : 'EDATSettingsPort classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDATCommandListenerSettingsPort >> restartOnCommandConsumingErrors [
	self subclassResponsibility
]

{ #category : #testing }
EDATCommandListenerSettingsPort >> strategy [
	self subclassResponsibility
]
