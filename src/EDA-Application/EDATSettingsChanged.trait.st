Trait {
	#name : #EDATSettingsChanged,
	#category : #'EDA-Application'
}

{ #category : #'instance creation' }
EDATSettingsChanged classSide >> with: anAdapter on: anEDAApplication [
	^ self new
		adapter: anAdapter;
		edaApplication: anEDAApplication;
		yourself
]

{ #category : #accessing }
EDATSettingsChanged >> adapter [
	self subclassResponsibility
]

{ #category : #accessing }
EDATSettingsChanged >> adapter: anAdapter [
	self subclassResponsibility
]

{ #category : #accessing }
EDATSettingsChanged >> edaApplication [
	self subclassResponsibility
]

{ #category : #accessing }
EDATSettingsChanged >> edaApplication: anEDAApplication [
	self subclassResponsibility
]
