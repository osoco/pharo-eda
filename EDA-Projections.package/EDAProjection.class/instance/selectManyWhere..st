persistence
selectManyWhere: aDictionary
	^ Repository selectMany: self class where: aDictionary
