Class {
	#name : #EDAEventHandler,
	#superclass : #EDAHandler,
	#category : #'EDA-Handlers-Events'
}

{ #category : #handling }
EDAEventHandler >> buildAggregateRootsFrom: anEvent [
	^ ((self retrieveAggregateRootClasses: anEvent)
		collect:
			[ :c | self buildAggregateRootsFrom: anEvent andAggregateRootClass: c ])
		flattened
]

{ #category : #handling }
EDAEventHandler >> buildAnticorruptionLayersFrom: anEvent [
	^ (self retrieveAnticorruptionLayerClasses: anEvent) collect: [ :c | c new ]
]

{ #category : #handling }
EDAEventHandler >> delegateHandlingOfEvent: anEvent to: anInstance [
	self subclassResponsibility
]

{ #category : #handling }
EDAEventHandler >> handle: anEvent withErrorStrategy: strategy [
	^ self handlerMethod methodClass isAggregateRoot ifTrue: [ self letAggregateRootsHandle: anEvent withErrorStrategy: strategy ] ifFalse: [ self letAnticorruptionLayersHandle: anEvent withErrorStrategy: strategy ]

]

{ #category : #handling }
EDAEventHandler >> letAggregateRootsHandle: anEvent withErrorStrategy: strategy [
	| processedEvents |
	processedEvents := OrderedCollection new.
	[ | aggregateRoots handlingResult producedEvents |
	aggregateRoots := self buildAggregateRootsFrom: anEvent.
	aggregateRoots
		do: [ :aggregateRoot | 
			handlingResult := self
				delegateHandlingOfEvent: anEvent
				to: aggregateRoot.
			producedEvents := handlingResult isCollection
				ifTrue: [ handlingResult ]
				ifFalse: [ OrderedCollection with: handlingResult ].
			processedEvents
				addAll:
					(self
						processGeneratedEvents: producedEvents
						for: anEvent
						onAggregateRoot: aggregateRoot) ] ]
		on: Error - Break
		do:
			[ :exception | self manageError: exception for: anEvent usingErrorStrategy: strategy ].
	eventBus produceEvents: processedEvents.
	^ processedEvents
]

{ #category : #handling }
EDAEventHandler >> letAnticorruptionLayersHandle: anEvent withErrorStrategy: strategy [
	| projections |
	projections := OrderedCollection new.
	[ | anticorruptionLayers handlingResult producedProjections |
	anticorruptionLayers := self buildAnticorruptionLayersFrom: anEvent.
	anticorruptionLayers
		do: [ :anticorruptionLayer | 
			handlingResult := self
				delegateHandlingOfEvent: anEvent
				to: anticorruptionLayer.
			producedProjections := handlingResult isCollection
				ifTrue: [ handlingResult ]
				ifFalse: [ OrderedCollection with: handlingResult ].
			projections
				addAll:
					(self
						processGeneratedProjections: producedProjections
						for: anEvent
						onAnticorruptionLayer: anticorruptionLayer) ] ]
		on: Error - Break
		do:
			[ :exception | self manageError: exception for: anEvent usingErrorStrategy: strategy ].
	^ projections
]

{ #category : #handling }
EDAEventHandler >> retrieveAggregateRootClasses: anEvent [
	^ self retrieveTargetClasses: anEvent inAndBelow: EDAAggregateRoot
]

{ #category : #handling }
EDAEventHandler >> retrieveAnticorruptionLayerClasses: anEvent [
	^ self retrieveTargetClasses: anEvent inAndBelow: EDAAnticorruptionLayer
]

{ #category : #handling }
EDAEventHandler >> retrieveTargetClasses: anEvent inAndBelow: aClass [
	^ (((Pragma
		allNamed: #useAsEventHandlerFor:
		inAndBelow: aClass)
		select: [ :p | (p argumentAt: 1) = anEvent class greaseString ])
		collect: [ :p | p methodClass ]) asSet
]
