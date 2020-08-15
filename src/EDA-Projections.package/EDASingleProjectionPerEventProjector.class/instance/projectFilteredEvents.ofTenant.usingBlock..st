projecting
projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock
	^ self
		projectFilteredEvents: anEventCollection
		ofTenant: aTenant
		usingBlock: aBlock
		betweenEvents: self iteratingBlock