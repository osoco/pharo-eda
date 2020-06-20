persistence
selectMany: aClass where: aBlock sortBy: sortBlock
	^ self selectManyOperation
		queryClass: self class;
		where: aBlock;
		sortBlock: sortBlock;
		execute