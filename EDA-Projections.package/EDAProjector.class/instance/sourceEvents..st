event retrieval
sourceEvents: anEventStore
	| eventTypes aux result |
	eventTypes := ((Pragma allNamed: 'projectionForEvents:' in: ATSApplicationsPassedToRoundIdProjector)
		collect: [ :p | p arguments first ]) flattened.
	aux := OrderedCollection new.
	eventTypes do: [ :t | aux addAll: (anEventStore findEventsOfType: t asClass) ].
	result := self removeDuplicatesIn: aux matching: [ :first :second | (first class = second class) and: [ first id = second id ] ].
	^ result