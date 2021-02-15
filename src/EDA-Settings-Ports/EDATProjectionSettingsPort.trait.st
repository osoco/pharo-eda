Trait {
	#name : #EDATProjectionSettingsPort,
	#traits : 'EDATSettingsPort',
	#category : #'EDA-Settings-Ports'
}

{ #category : #accessing }
EDATProjectionSettingsPort >> concurrentSynchronization [ 
	self subclassResponsibility
]

{ #category : #accessing }
EDATProjectionSettingsPort >> headlessMode [
	self subclassResponsibility
]

{ #category : #accessing }
EDATProjectionSettingsPort >> projectionSynchronizationEnabled [
	self subclassResponsibility
]

{ #category : #accessing }
EDATProjectionSettingsPort >> strategy [
	self subclassResponsibility
]
