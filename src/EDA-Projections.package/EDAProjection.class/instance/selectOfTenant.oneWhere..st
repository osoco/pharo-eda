persistence
selectOfTenant: aTenant oneWhere: aDictionary
	^ self class repository selectOfTenant: aTenant one: self class where: aDictionary