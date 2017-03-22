code generation
generateEDAApplicationRegisterCommandBuildersMethod
	| result commands |
	result := self generateEDAApplicationRegisterCommandBuildersMethodName , String cr.
	result := result , '    EDACommandBuilderRegistry'.
	commands := self retrieveImplementedCommandsFor: self appName.
	commands keys asOrderedCollection
		doWithIndex: [ :key :i | 
			i > 1
				ifTrue: [ result := result , ';' ].
			result := result , String cr , '        addBuilder: ' , self appName , 'DefaultCommandBuilder new' , String cr , '            forCommand: #' , key ].
	^ result