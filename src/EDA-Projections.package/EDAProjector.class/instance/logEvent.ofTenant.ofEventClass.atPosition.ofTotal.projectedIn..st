logging
logEvent: eventId ofTenant: aTenant ofEventClass: eventClass atPosition: index ofTotal: total projectedIn: projectionClass
	self
		logInfoMessage:
			'[' , aTenant greaseString , ':' , index greaseString , '/' , total greaseString , '] '
				, projectionClass greaseString , ' <- ' , eventClass greaseString
				, ' (' , eventId greaseString , ')'