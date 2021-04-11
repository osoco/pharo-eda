Class {
	#name : #EDAEventHandler,
	#superclass : #EDAHandler,
	#traits : 'EDATAggregateRootHandler',
	#classTraits : 'EDATAggregateRootHandler classTrait',
	#category : #'EDA-Handlers-Events'
}

{ #category : #handling }
EDAEventHandler >> buildAggregateRootsFrom: anEvent [
	^ (self retrieveAggregateRootClasses: anEvent) collect: [ :c | 
	self
		buildAggregateRootFrom: anEvent
		andAggregateRootClass: c ]
]

{ #category : #handling }
EDAEventHandler >> delegateHandlingOfEvent: anEvent to: anInstance [
	self subclassResponsibility
]

{ #category : #handling }
EDAEventHandler >> handle: anEvent withErrorStrategy: strategy [
	| processedEvents |
	processedEvents := OrderedCollection new.
	[ | aggregateRoots handlingResult producedEvents |
	aggregateRoots := self buildAggregateRootsFrom: anEvent.
	aggregateRoots
		do: [ :aggregateRoot | 
			handlingResult := self
				delegateHandlingOfEvent: anEvent
				toAggregate: aggregateRoot.
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
		do: [ :exception | 
			self
				manageError: exception
				forCommand: anEvent
				usingErrorStrategy: strategy ].
	eventBus produceEvents: processedEvents.
	^ processedEvents
]

{ #category : #handling }
EDAEventHandler >> retrieveAggregateRootClasses: anEvent [
	^ ((Pragma
		allNamed: #useAsEventHandlerFor:
		inAndBelow: EDAAggregateRoot) collect: [ :p | p methodClass ]) asSet
]
