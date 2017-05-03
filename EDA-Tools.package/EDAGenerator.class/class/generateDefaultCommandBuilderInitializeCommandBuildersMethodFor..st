code generation - DefaultCommandBuilder
generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: appName
	| result commands cr generator |
	generator := self new.
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName;
		nextPut: cr.
	result nextPutAll: generator generateSignature.
	result nextPutAll: '	commandDictionary := {'.
	commands := generator retrieveImplementedCommandsFor: appName.
	commands keys asOrderedCollection
		keysAndValuesDo: [ :i :key |
			i > 1
				ifTrue: [ result nextPut: $. ].
			result
				nextPut: cr;
				nextPutAll: '		(#';
				nextPutAll: key;
				nextPutAll: ' -> ';
				nextPutAll:
					(generator
						removeClassLiteralFromMetaClassName: (commands at: key) name);
				nextPut: $) ].
	result
		nextPut: cr;
		nextPutAll: '	} asDictionary'.
	^ result contents