instance creation
fromExampleFile: aFile version: version appName: appName aggregate: aggregate commandNameResolver: aCommandNameResolver andEventNameResolver: anEventNameResolver
	| result |
	result := self new
		commandFile: aFile;
		appName: appName;
		aggregate: aggregate;
		version: version.
	result commandNameResolver: aCommandNameResolver.
	result eventNameResolver: anEventNameResolver.
	result commandRaw: result readCommandExampleFile.
	result commandJson: (NeoJSONReader fromString: result commandRaw).
	result
		commandName: (result commandNameFor: ((result commandJson at: #meta) at: #type) usingCommandNameResolver: aCommandNameResolver).
	result eventName: (result eventNameFor: result commandName usingEventNameResolver: anEventNameResolver).
	result
		eventFile:
			aFile parent parent parent / 'events' / aFile parent basename
				/ (result upcasedToDotSeparated: result eventName , '.example.json').
	result eventRaw: result readEventExampleFile.
	result eventJson: (NeoJSONReader fromString: result eventRaw).
	^ result