persistence
selectOfTenant: aTenant manyWhere: aDictionary
	^ self class repository selectOfTenant: aTenant many: self class where: aDictionary