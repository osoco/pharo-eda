Trait {
	#name : #EDATCommandListenerSettingsPort,
	#traits : 'EDATSettingsPort',
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
