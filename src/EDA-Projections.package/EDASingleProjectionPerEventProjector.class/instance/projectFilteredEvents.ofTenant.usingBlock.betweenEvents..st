projecting
projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock betweenEvents: iterationBlock
	| projectionLogic |
	projectionLogic := [ :index :event | 
	| aProjection |
	self
		logEvent: event id
		ofTenant: aTenant
		ofEventClass: event class
		atPosition: index
		ofTotal: anEventCollection size
		projectedIn: self class projectionClass.
	aProjection := self
		projectEvent: event
		atIndex: index
		ofTotalCount: anEventCollection size.
	aBlock value: aProjection value: event value: index.
	iterationBlock value: index value: event value: aProjection ].
	self class headlessMode
		ifTrue: [ anEventCollection keysAndValuesDo: projectionLogic ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: projectionLogic
				displayingProgress: [ :index :event | 
					'Processing event ' , index greaseString , '/'
						, anEventCollection size greaseString , ' : '
						, event class greaseString , ' (' , event id greaseString , ')' ] ]