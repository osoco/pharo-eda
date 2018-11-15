projecting
projectFilteredEvents: anEventCollection usingBlock: aBlock
	anEventCollection
		keysAndValuesDo: [ :index :event | 
			| aProjection |
			aProjection := self
				projectEvent: event
				atIndex: index
				ofTotalCount: anEventCollection size.
			aBlock value: aProjection value: event value: index ]