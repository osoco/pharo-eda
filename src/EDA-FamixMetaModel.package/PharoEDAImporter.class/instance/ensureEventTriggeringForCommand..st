public-entity-creation
ensureEventTriggeringForCommand: anEDACommandModel
	| someEventTriggerings |
	^ eventTriggerings
		at: anEDACommandModel
		ifAbsent: [ someEventTriggerings := self
				createEventTriggerings: anEDACommandModel.
			someEventTriggerings
				ifNotEmpty: [ someEventTriggerings do: [ :each | self addEntity: each ] ].
			someEventTriggerings ]