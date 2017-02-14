persistence
selectOneWhere: aDictionary
	^ Repository selectOne: self class where: aDictionary
