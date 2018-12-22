setup
setupEventStore: anEventStore
	anEventStore
		ifNotNil: [ :es | 
			self eventStore: es.
			self uniqueInstance: nil ]