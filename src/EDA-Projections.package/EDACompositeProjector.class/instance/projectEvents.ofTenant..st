api
projectEvents: anEventCollection ofTenant: aTenant
	self projectors
		do: [ :projector | projector projectEvents: anEventCollection ofTenant: aTenant]