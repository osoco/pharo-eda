regex logic
at: key
	^ self at: key ifAbsent: [ ^ key -> '(.*)' ]