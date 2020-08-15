projecting
projectFilteredEvents: anEventCollection ofTenant: aTenant
	anEventCollection isEmpty
		ifTrue: [ self
				logInfoMessage:
					'No events to project to '
						, self class projectionClass name greaseString , '.' ]
		ifFalse: [ self
				logInfoMessage:
					'Begin projecting ' , anEventCollection size greaseString
						, ' events in ' , self class projectionClass name greaseString
						, '.'.
			self
				projectFilteredEvents: anEventCollection ofTenant: aTenant
				usingBlock: [ :projection :event :index |  ].
			self
				logInfoMessage:
					'End projecting ' , anEventCollection size greaseString
						, ' events in ' , self class projectionClass name greaseString
						, '.' ]