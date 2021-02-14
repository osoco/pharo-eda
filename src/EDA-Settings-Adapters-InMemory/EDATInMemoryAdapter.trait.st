Trait {
	#name : #EDATInMemoryAdapter,
	#category : #'EDA-Settings-Adapters-InMemory'
}

{ #category : #accessing }
EDATInMemoryAdapter classSide >> description [
	^ 'Manual'
]

{ #category : #testing }
EDATInMemoryAdapter >> isReadOnly [ 
	^ false
]
