Trait {
	#name : #EDASettingsPort,
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDASettingsPort classSide >> < anotherAdapterClass [
	^ self priority < anotherAdapterClass priority
]

{ #category : #testing }
EDASettingsPort classSide >> <= anotherAdapterClass [
	^ self priority = anotherAdapterClass priority
		or: [ self < anotherAdapterClass ]
]

{ #category : #testing }
EDASettingsPort classSide >> > anotherAdapterClass [
	^ anotherAdapterClass priority < self priority
]

{ #category : #testing }
EDASettingsPort classSide >> >= anotherAdapterClass [
	^ self priority = anotherAdapterClass priority
		or: [ anotherAdapterClass < self ]
]

{ #category : #testing }
EDASettingsPort classSide >> accepts: anEDAApplication [
	^ false
]

{ #category : #testing }
EDASettingsPort classSide >> description [
	self subclassResponsibility 
]

{ #category : #testing }
EDASettingsPort classSide >> priority [
	self subclassResponsibility
]

{ #category : #testing }
EDASettingsPort classSide >> withApp: anEDAApplication [
	^ self new
]
