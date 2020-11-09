accessing
event: anEventModel
	event := FMMultivalueLink
		on: self
		update: #aggregatePublishers
		from: self event
		to: anEventModel