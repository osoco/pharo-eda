Trait {
	#name : #EDATSettingsPort,
	#category : #'EDA-Settings-Ports'
}

{ #category : #testing }
EDATSettingsPort classSide >> < anotherAdapterClass [
	^ self priority < anotherAdapterClass priority
]

{ #category : #testing }
EDATSettingsPort classSide >> <= anotherAdapterClass [
	^ self priority = anotherAdapterClass priority
		or: [ self < anotherAdapterClass ]
]

{ #category : #testing }
EDATSettingsPort classSide >> > anotherAdapterClass [
	^ anotherAdapterClass priority < self priority
]

{ #category : #testing }
EDATSettingsPort classSide >> >= anotherAdapterClass [
	^ self priority = anotherAdapterClass priority
		or: [ anotherAdapterClass < self ]
]

{ #category : #testing }
EDATSettingsPort classSide >> accepts: anEDAApplication [
	^ false
]

{ #category : #testing }
EDATSettingsPort classSide >> description [
	self subclassResponsibility 
]

{ #category : #testing }
EDATSettingsPort classSide >> priority [
	self subclassResponsibility
]

{ #category : #testing }
EDATSettingsPort classSide >> withApp: anEDAApplication [
	^ self new
		edaApplication: anEDAApplication;
		yourself
]
