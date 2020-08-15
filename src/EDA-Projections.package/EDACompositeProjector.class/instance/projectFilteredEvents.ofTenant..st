api
projectFilteredEvents: anEventCollection ofTenant: aTenant
	self projectors
		do: [ :projector | projector projectFilteredEvents: anEventCollection ofTenant: aTenant]