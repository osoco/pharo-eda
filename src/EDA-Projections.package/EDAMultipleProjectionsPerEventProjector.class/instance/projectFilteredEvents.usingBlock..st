projection retrieval
projectFilteredEvents: anEventCollection usingBlock: aBlock
	| projectionLogic |
	projectionLogic := [ :index :event | 
	| aProjectionCollection |
	self
		logEvent: event id
		ofEventClass: event class
		atPosition: index
		ofTotal: anEventCollection size
		projectedIn: self class projectionClass.
	aProjectionCollection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
	aBlock value: aProjectionCollection value: event value: index ].
	self class headlessMode
		ifTrue: [ anEventCollection keysAndValuesDo: projectionLogic ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: projectionLogic
				displayingProgress: [ :index :event | 
					'Processing event ' , index greaseString , '/' , anEventCollection size greaseString , ' : ' , event class name greaseString , ' ('
						, event id greaseString , ')' ] ]