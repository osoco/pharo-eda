accessing
produceEvents: anEventCollection
	anEventCollection ifNotNil: [ anEventCollection do: [ :event | self produceEvent: event ]]