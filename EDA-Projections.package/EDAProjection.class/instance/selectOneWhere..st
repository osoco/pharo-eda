persistence
selectOneWhere: aDictionary
	^ self class repository selectOne: self class where: aDictionary
