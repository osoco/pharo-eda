parsing
eventClassPrefix: aClass
	^ (aClass asString regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast