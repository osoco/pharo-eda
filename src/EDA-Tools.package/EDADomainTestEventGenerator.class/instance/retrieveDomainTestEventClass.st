delegated
retrieveDomainTestEventClass
	| cls result |
	cls := self class environment at: self retrieveDomainTestEventClassName ifAbsent: [ nil ].
	result := cls ifNotNil: [ :c | c ] ifNil: [ self createDomainTestEventClass ].
	^ result