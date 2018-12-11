helper
retrieveImplementedCommandsFor: appName
	"Finds all pragmas like [appName]CommandName: #[COMMAND_NAME]"

	| cmds |
	cmds := {} asDictionary.
	EDACommand
		allSubclassesDo: [ :cls | (Pragma allNamed: (appName asLowercase , 'CommandName:') asSymbol in: cls class) do: [ :pragma | cmds at: (pragma arguments at: 1) put: pragma methodClass ] ].
	^ cmds