Trait {
	#name : #EDASettingsPort,
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDASettingsPort classSide >> accepts: anEDAApplication [
	^ false
]

{ #category : #testing }
EDASettingsPort classSide >> withApp: anEDAApplication [
	^ self new
]

{ #category : #testing }
EDASettingsPort >> < anotherPort [
	^ self priority < anotherPort priority
]

{ #category : #testing }
EDASettingsPort >> > anotherPort [
	^ anotherPort < self
]

{ #category : #testing }
EDASettingsPort >> priority [
	self subclassResponsibility
]
