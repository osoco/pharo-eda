Trait {
	#name : #EDATPortSettingsPort,
	#traits : 'EDATSettingsPort',
	#classTraits : 'EDATSettingsPort classTrait',
	#category : #'EDA-Settings-Ports'
}

{ #category : #accessing }
EDATPortSettingsPort >> edaApplication [
	self subclassResponsibility
]

{ #category : #accessing }
EDATPortSettingsPort >> edaApplication: anEDAApplication [
	self subclassResponsibility
]

{ #category : #testing }
EDATPortSettingsPort >> isReadOnly [
	^ false
]

{ #category : #testing }
EDATPortSettingsPort >> supportsMultiple [
	^ false
]
