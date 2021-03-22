dependencies
declareObjectDiffIn: spec
	spec
		baseline: 'ObjectDiff'
		with: [ spec repository: 'github://rydnr/object-diff:main/src' ].
	^ spec