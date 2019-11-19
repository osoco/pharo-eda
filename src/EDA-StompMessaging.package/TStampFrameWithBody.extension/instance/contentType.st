*EDA-StompMessaging
contentType
	^ self headerAt: #'content-type' ifAbsent: [ self headerAt: #'Content-Type' ifAbsent: [ 'application/json' ]]