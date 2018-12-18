projection retrieval
projectFilteredEvents: anEventCollection usingBlock: aBlock
	Smalltalk isHeadless
		ifTrue: [ anEventCollection
				keysAndValuesDo: [ :index :event | 
					| aProjectionCollection |
					aProjectionCollection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
					aBlock value: aProjectionCollection value: event value: index ] ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: [ :index :event | 
					| aProjectionCollection |
					aProjectionCollection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
					aBlock value: aProjectionCollection value: event value: index ]
				displayingProgress: [ :index :event | 
					'Processing event ' , index greaseString , '/' , anEventCollection size greaseString , ' : ' , event class name greaseString
						, ' (' , event id greaseString, ')' ] ]