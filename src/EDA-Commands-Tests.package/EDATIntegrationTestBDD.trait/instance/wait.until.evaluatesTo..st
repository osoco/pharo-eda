helper
wait: maxWaitSeconds until: validateBlock evaluatesTo: expectedResult
	"Copied from GLMMorphicTest #wait:validateBlock:evaluatesTo:"
	| startTime result |
	startTime := Time millisecondClockValue // 1000.
	[result := validateBlock value = expectedResult] whileFalse:
			[(Time millisecondClockValue // 1000) - startTime > maxWaitSeconds ifTrue: [^result].
			(Delay forMilliseconds: 50) wait].
	^ result