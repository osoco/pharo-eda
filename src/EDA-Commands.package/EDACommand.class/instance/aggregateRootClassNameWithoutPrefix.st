helpers
aggregateRootClassNameWithoutPrefix
	^ self class aggregateRootClass asString allButFirst: self classPrefix size