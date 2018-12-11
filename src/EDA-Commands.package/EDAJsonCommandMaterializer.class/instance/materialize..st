parsing
materialize: json
    "Returns a command instance from given JSON representation"
	| map builder |
	map := NeoJSONReader fromString: json.
	builder := EDACommandBuilderRegistry lookupBuilder: (self retrieveCommandName: map).
	^ builder buildWith: map
