code generation
generateDefaultCommandBuilderInitializeCommandBuildersMethod
	| result commands |
	result := self generateDefaultCommandBuilderInitializeCommandBuildersMethodName , String cr.
	result := result , '    commandDictionary := {'.
	commands := self retrieveImplementedCommandsFor: self appName.
	commands keys asOrderedCollection
		doWithIndex: [ :key :i |
			i > 1
				ifTrue: [ result := result , '.' ].
			result := result , String cr , '        (#' , key , ' -> ' , (self removeClassLiteralFromMetaClassName: (commands at: key) name) , ')' ].
	result := result , '} asDictionary'.
	^ result