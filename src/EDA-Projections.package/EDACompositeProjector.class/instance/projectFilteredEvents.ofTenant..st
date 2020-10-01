api
projectFilteredEvents: anEventCollection ofTenant: aTenant
	| projectors |
	projectors := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projectors do:
		 [ :p | p projectFilteredEvents: anEventCollection ofTenant: aTenant ]