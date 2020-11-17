view
commandTriggersForEvent
	^ self commandTriggers collect: [ :commandTrigger | commandTrigger command ]