Trait {
	#name : #EDATPortSettingsPort,
	#traits : 'EDATSettingsPort',
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
EDATPortSettingsPort >> isReadOnly: aSymbol [
	^ false
]

{ #category : #testing }
EDATPortSettingsPort >> supportsMultiple: aSymbol [
	^ false
]