accessing
initialize
	| result |
	result := super initialize.
	self pendingLog: OrderedCollection new.
	^ result