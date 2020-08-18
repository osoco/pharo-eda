api
findAllOfTenant: aTenant withApplyEventsBlock: aBlock
	| result events aux aggregateClass |
	result := OrderedCollection new.
	aggregateClass := self aggregateClass.
	events := self findAllEventsOfTenant: aTenant.
	aux := self groupEventsByAggregateRootId: events.
	aux
		keysAndValuesDo: [ :key :eventList | 
			| aggregate |
			aggregate := aggregateClass new.
			aBlock value: aggregate value: eventList.
			result add: aggregate ].
	^ result