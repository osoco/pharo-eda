helpers
classPrefix
	^ (self class name regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast