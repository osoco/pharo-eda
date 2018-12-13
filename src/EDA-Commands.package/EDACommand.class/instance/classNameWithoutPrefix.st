helpers
classNameWithoutPrefix
	^ self class name asString allButFirst: (self classPrefix) size