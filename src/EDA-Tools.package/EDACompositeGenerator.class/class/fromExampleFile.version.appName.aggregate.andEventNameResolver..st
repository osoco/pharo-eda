instance creation
fromExampleFile: aFile version: version appName: appName aggregate: aggregate andEventNameResolver: resolver
	| result |
	result := self new
		commandFile: aFile;
		appName: appName;
		aggregate: aggregate;
		version: version.
	result commandRaw: result readCommandExampleFile.
	result commandJson: (NeoJSONReader fromString: result commandRaw).
	result commandName: ((result commandJson at: #meta) at: #type).
	result eventName: (result eventNameFor: result commandName usingEventNameResolver: resolver).
	result
		eventFile: aFile parent parent parent / 'events' / aFile parent basename / (result upcasedToDotSeparated: result eventName , '.example.json').
	result eventRaw: result readEventExampleFile.
	result eventJson: (NeoJSONReader fromString: result eventRaw).
	^ result