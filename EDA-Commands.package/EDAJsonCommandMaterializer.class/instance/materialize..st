parsing
materialize: json
    "Returns a command instance from given JSON representation"
	| map builder |
	map := NeoJSONReader fromString: json.
	builder := EDACommandBuilderRegistry lookupBuilder: (map at: #name).
	^ builder buildWith: map
