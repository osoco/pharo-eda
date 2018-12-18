instance creation
fromExampleFile: aFile version: version appName: appName aggregate: aggregate
	| result |
	result := self new
		eventFile: aFile;
		appName: appName;
		aggregate: aggregate;
		version: version.
	result eventRaw: result readEventExampleFile.
	result eventJson: (NeoJSONReader fromString: result eventRaw).
	result eventName: ((result eventJson at: #meta) at: #type).
	^ result