code generation - EDAApplication
generateEDAApplicationRegisterCommandBuildersMethod
	| result commands |
	result := WriteStream with: String new.
	result
		nextPutAll: self generateEDAApplicationRegisterCommandBuildersMethodName;
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	EDACommandBuilderRegistry'.
	commands := self retrieveImplementedCommandsFor: self appName.
	commands keys asOrderedCollection
		doWithIndex: [ :key :i | 
			i > 1
				ifTrue: [ result nextPut: $; ].
			result
				nextPut: Character cr;
				nextPutAll: '		addBuilder: ';
				nextPutAll: self appName;
				nextPutAll: 'DefaultCommandBuilder new';
				nextPut: Character cr;
				nextPutAll: '		forCommand: #';
				nextPutAll: key ].
	^ result contents