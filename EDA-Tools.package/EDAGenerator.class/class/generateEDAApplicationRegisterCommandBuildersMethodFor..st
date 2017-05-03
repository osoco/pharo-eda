code generation - EDAApplication
generateEDAApplicationRegisterCommandBuildersMethodFor: appName
	| result commands cr generator |
	generator := self new.
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateEDAApplicationRegisterCommandBuildersMethodName;
		nextPut: cr.
	result nextPutAll: self new generateSignature.
	result nextPutAll: '	| builder |'; nextPut: cr.
	result nextPutAll: '	builder := ATSDefaultCommandBuilder new.'; nextPut: cr.
	result nextPutAll: '	EDACommandBuilderRegistry'; nextPut: cr.
	commands := generator retrieveImplementedCommandsFor: appName.
	commands keys asOrderedCollection
		keysAndValuesDo: [ :i :key | 
			i > 1
				ifTrue: [ result nextPut: $; ; nextPut: cr ].
			result
				nextPutAll: '		addBuilder: builder forCommand: #';
				nextPutAll: key ].
	^ result contents