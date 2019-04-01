delegated
retrieveDomainTestEventClass
	| cls result |
	cls := self class environment at: self retrieveDomainTestEventClassName ifAbsent: [ nil ].
	result := cls ifNotNil: [ :c | c asSymbol class ] ifNil: [ self createDomainTestEventClass ].
	^ result