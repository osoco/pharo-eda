Trait {
	#name : #EDATByPriorityAdapter,
	#traits : 'EDATPortResolver',
	#classTraits : 'EDATPortResolver classTrait',
	#category : #'EDA-Settings-Adapters-ByPriority'
}

{ #category : #logic }
EDATByPriorityAdapter >> resolveSettingsPort: aPort [
	| candidates candidate |
	candidates := (self availableAdapters: aPort)
		sorted.
	candidate := candidates
		ifEmpty: [ nil ]
		ifNotEmpty: [ :col | col first ].
	^ candidate ifNil: [ nil ] ifNotNil: [ :c | c withApp: self ]
]
