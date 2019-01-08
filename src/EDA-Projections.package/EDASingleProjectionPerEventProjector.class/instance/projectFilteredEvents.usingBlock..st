projecting
projectFilteredEvents: anEventCollection usingBlock: aBlock
	self class headlessMode
		ifTrue: [ anEventCollection
				keysAndValuesDo: [ :index :event | 
					| aProjection |
					aProjection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
					aBlock value: aProjection value: event value: index ] ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: [ :index :event | 
					| aProjection |
					aProjection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
					aBlock value: aProjection value: event value: index ]
				displayingProgress: [ :index :event | 
					'Processing event ' , index greaseString , '/' , anEventCollection size greaseString , ' : ' , event class greaseString , ' ('
						, event id greaseString , ')' ] ]