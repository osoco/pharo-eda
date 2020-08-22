helpers
isCreate
	^ self classNameWithoutPrefix
	= ('Create' , self aggregateRootClassNameWithoutPrefix)