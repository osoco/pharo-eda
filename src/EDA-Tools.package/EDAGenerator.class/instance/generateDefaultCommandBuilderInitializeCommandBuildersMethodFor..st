code generation - DefaultCommandBuilder
generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: anAppName
	| result commands cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	commandDictionary := {'.
	commands := self retrieveImplementedCommandsFor: anAppName.
	commands keys asOrderedCollection
		keysAndValuesDo: [ :i :key | 
			i > 1
				ifTrue: [ result nextPut: $. ].
			result
				nextPut: cr;
				nextPutAll: '		(#';
				nextPutAll: key;
				nextPutAll: ' -> ';
				nextPutAll: (self removeClassLiteralFromMetaClassName: (commands at: key) name);
				nextPut: $) ].
	result
		nextPut: cr;
		nextPutAll: '	} asDictionary'.
	^ result contents