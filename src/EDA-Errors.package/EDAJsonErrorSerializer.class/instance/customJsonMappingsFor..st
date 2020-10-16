customization
customJsonMappingsFor: aJsonWriter
	self print: Context inJsonWriter: aJsonWriter.
	EDADomainException
		allSubclassesDo: [ :cls | self printException: cls inJsonWriter: aJsonWriter ].
	EDACommand
		allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].
	EDAEventSourcingEvent
		allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].
		EDAAggregateRoot 
				allSubclassesDo: [ :cls | self print: cls inJsonWriter: aJsonWriter ].
