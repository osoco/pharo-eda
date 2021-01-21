Class {
	#name : #EDACompositeProjector,
	#superclass : #EDAProjector,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'projectorsByTenant'
	],
	#classInstVars : [
		'concurrentSynchronization',
		'executions'
	],
	#category : 'EDA-Projections-Projectors'
}

{ #category : #api }
EDACompositeProjector class >> annotateDuration: aDuration forProjector: aProjector [
	self executions at: aProjector put: aDuration.
	self
		logInfoMessage:
			'Projection of ' , aProjector greaseString , ' took '
				, aDuration greaseString
]

{ #category : #accessing }
EDACompositeProjector class >> concurrentSynchronization [
	^ concurrentSynchronization
]

{ #category : #accessing }
EDACompositeProjector class >> concurrentSynchronization: aFlag [
	concurrentSynchronization := aFlag
]

{ #category : #'class initialization' }
EDACompositeProjector class >> doInitialize [
	super doInitialize.
	self concurrentSynchronization: false.
	self executions: Dictionary new
]

{ #category : #accessing }
EDACompositeProjector class >> executions [
	^ executions
]

{ #category : #accessing }
EDACompositeProjector class >> executions: aDict [
	executions := aDict
]

{ #category : #'class initialization' }
EDACompositeProjector class >> initialize [
	self doInitialize
]

{ #category : #design }
EDACompositeProjector class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
EDACompositeProjector class >> ofTenant: aTenant withAllProjectorsAndEventStore: anEventStore [
	| result |
	result := self ofTenant: aTenant withEventStore: anEventStore.
	result projectorsByTenant
		at: aTenant
		put:
			((EDAProjector allSubclasses
				select:
					[ :class | class ~= self and: [ class isAbstract not and: [ class isEnabled ] ] ])
				collect:
					[ :projectorClass | projectorClass ofTenant: aTenant withEventStore: anEventStore ]).
	^ result
]

{ #category : #ordering }
EDACompositeProjector class >> order [
	^ -1
]

{ #category : #accessing }
EDACompositeProjector class >> projectionClass [
	^ self shouldBeImplemented
]

{ #category : #api }
EDACompositeProjector >> delegateProjectionTo: aProjector ofTenant: aTenant [
	| start end |
	start := DateAndTime now.
	aProjector projectOfTenant: aTenant.
	end := DateAndTime now.
	self class
		annotateDuration: end - start
		forProjector: aProjector class greaseString
]

{ #category : #api }
EDACompositeProjector >> projectEvents: anEventCollection ofTenant: aTenant [
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector
		ifNotNil: [ :p | p projectEvents: anEventCollection ofTenant: aTenant ]
]

{ #category : #api }
EDACompositeProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant [
	| projectors |
	projectors := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projectors do:
		 [ :p | p projectFilteredEvents: anEventCollection ofTenant: aTenant ]
]

{ #category : #api }
EDACompositeProjector >> projectInParallelOfTenant: aTenant [
	| semaphore |
	semaphore := Semaphore new.
	(self projectorsByTenant: aTenant)
		ifEmpty: [ self logErrorMessage: 'No projector for tenant ' , aTenant ]
		ifNotEmpty: [ :specificProjectors |
			self class headlessMode
				ifTrue: [ specificProjectors
						do:
							[ :projector |
							self delegateProjectionTo: projector ofTenant: aTenant.
							semaphore signal ] fork ]
				ifFalse: [ specificProjectors
						do: [ :projector |
							[ self delegateProjectionTo: projector ofTenant: aTenant.
							semaphore signal ] fork ]
						displayingProgress:
							[ :projector | 'Projection ' , projector class projectionClass greaseString ].
					specificProjectors size timesRepeat: [ semaphore wait ] ] ]
]

{ #category : #api }
EDACompositeProjector >> projectOfTenant: aTenant [
	| start end |
	(self class synchronizationInProgressOfTenant: aTenant)
		ifTrue: [ ^ self ].
	self class synchronizationInProgressOfTenant: aTenant is: true.
	start := DateAndTime now.
	self class concurrentSynchronization
		ifTrue: [ self projectInParallelOfTenant: aTenant ]
		ifFalse: [ self projectSequentiallyOfTenant: aTenant ].
	end := DateAndTime now.
	self class
		annotateDuration: end - start
		forProjector: self class greaseString.
	self class synchronizationInProgressOfTenant: aTenant is: false
]

{ #category : #api }
EDACompositeProjector >> projectSequentiallyOfTenant: aTenant [
	(self projectorsByTenant: aTenant)
		ifEmpty: [ self logErrorMessage: 'No projector for tenant ' , aTenant ]
		ifNotEmpty: [ :projectors |
			self class headlessMode
				ifTrue: [ projectors
						do:
							[ :projector | self delegateProjectionTo: projector ofTenant: aTenant ] ]
				ifFalse: [ projectors
						do:
							[ :projector | self delegateProjectionTo: projector ofTenant: aTenant ]
						displayingProgress:
							[ :projector | 'Projection ' , projector class projectionClass greaseString ] ] ]
]

{ #category : #accessing }
EDACompositeProjector >> projectorsByTenant [
	projectorsByTenant ifNil: [ projectorsByTenant := Dictionary new ].
	^ projectorsByTenant
]

{ #category : #accessing }
EDACompositeProjector >> projectorsByTenant: aTenant [
	| result |
	result := self projectorsByTenant at: aTenant ifAbsent: [ OrderedCollection new ].
	self projectorsByTenant at: aTenant put: result.
	^ result
]
