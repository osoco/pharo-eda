instance creation
fromExampleFile: aFile appName: appName aggregate: aggregate
	| result |
	result := EDAGenerator new
		commandFile: aFile;
		appName: appName;
		aggregate: aggregate.
	result commandRaw: result readCommandExampleFile.
	result commandJson: (NeoJSONReader fromString: result commandRaw).
	result commandName: ((result commandJson at: #meta) at: #type).
	result fixCommandName.
	result eventName: result retrieveEventName.
	result eventFile: aFile parent parent / 'events' / (result toDotSeparated: result eventName , '.example.json').
	result eventRaw: result readEventExampleFile.
	result eventJson: (NeoJSONReader fromString: result eventRaw).
	^ result