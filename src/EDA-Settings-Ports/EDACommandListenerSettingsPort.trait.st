Trait {
	#name : #EDACommandListenerSettingsPort,
	#traits : 'EDASettingsPort',
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDACommandListenerSettingsPort >> restartOnCommandConsumingErrors [
	self subclassResponsibility
]

{ #category : #testing }
EDACommandListenerSettingsPort >> strategy [
	self subclassResponsibility
]
