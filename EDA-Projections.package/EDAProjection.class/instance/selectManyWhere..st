persistence
selectManyWhere: aDictionary
	^ self class repository selectMany: self class where: aDictionary
