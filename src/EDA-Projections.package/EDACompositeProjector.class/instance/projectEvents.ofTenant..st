api
projectEvents: anEventCollection ofTenant: aTenant
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector
		ifNotNil: [ :p | p projectEvents: anEventCollection ofTenant: aTenant ]