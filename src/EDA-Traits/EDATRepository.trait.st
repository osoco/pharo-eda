Trait {
	#name : #EDATRepository,
	#category : 'EDA-Traits'
}

{ #category : #helpers }
EDATRepository >> groupEventsById: events [
	| result |
	result := Dictionary new.
	events
		do: [ :evt | 
			| list key |
			key := evt id.
			list := result at: key ifAbsent: [ OrderedCollection new ].
			list add: evt.
			result at: key put: list ].
	^ result
]
