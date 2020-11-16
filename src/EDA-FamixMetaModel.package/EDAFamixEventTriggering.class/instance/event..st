accessing
event: anEventModel
	event := FMMultivalueLink
		on: self
		update: #commandTriggers
		from: self event
		to: anEventModel