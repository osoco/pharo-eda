Trait {
	#name : #EDATProjectionSettingsPort,
	#traits : 'EDATSettingsPort',
	#classTraits : 'EDATSettingsPort classTrait',
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
