logging
logEvent: eventId ofEventClass: eventClass atPosition: index ofTotal: total projectedIn: projectionClass
	self logInfoMessage: '[' , index greaseString , '/' , total greaseString , '] ' , projectionClass greaseString , ' <- ', eventClass greaseString , ' (' , eventId greaseString , ')'