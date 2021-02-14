Trait {
	#name : #EDAProjectionSettingsPort,
	#traits : 'EDASettingsPort',
	#category : #'EDA-Settings-Ports'
}

{ #category : #accessing }
EDAProjectionSettingsPort >> concurrentSynchronization [ 
	self subclassResponsibility
]

{ #category : #accessing }
EDAProjectionSettingsPort >> headlessMode [
	self subclassResponsibility
]

{ #category : #accessing }
EDAProjectionSettingsPort >> projectionSynchronizationEnabled [
	self subclassResponsibility
]

{ #category : #accessing }
EDAProjectionSettingsPort >> strategy [
	self subclassResponsibility
]
