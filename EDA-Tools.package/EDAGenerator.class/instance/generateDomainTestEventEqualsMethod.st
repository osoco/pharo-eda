code generation - domain test
generateDomainTestEventEqualsMethod
	| result cr eventAttributes |
	eventAttributes := self
		allAttributesOf: self retrieveDomainTestEventClass
		including: (self retrieveEventAttributesBut: self class skippedEventAttributes).
	result := WriteStream with: String new.
	cr := Character cr.
	result
		nextPutAll: '= anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: self retrieveEventClassName;
		nextPutAll: ' = anInstance class and: [';
		nextPut: cr.
	result
		nextPutAll: '		(self attribute: self aggregateRootClass matches: anInstance aggregateRootClass) and: [';
		nextPut: cr.
	result
		nextPutAll: '			(self attribute: self id matches: anInstance id) and: [';
		nextPut: cr.
	result
		nextPutAll: '				(self attribute: self aggregateRootVersion matches: anInstance aggregateRootVersion) and: [';
		nextPut: cr.
	result
		nextPutAll: '					(self attribute: self timestamp matches: anInstance timestamp) and: [';
		nextPut: cr.
	result nextPutAll: '						(self attribute: self commandId matches: anInstance commandId) '.
	eventAttributes isNotEmpty
		ifTrue: [ result
				nextPutAll: 'and: [';
				nextPut: cr.
			result
				nextPutAll: '							';
				nextPutAll: (self generateDomainTestEventEqualsAndBlockRecursively: (self retrieveEventAttributesBut: self class skippedEventAttributes));
				nextPut: cr.
			result
				nextPutAll: '						]';
				nextPut: cr ].
	result
		nextPutAll: '					]';
		nextPut: cr.
	result
		nextPutAll: '				]';
		nextPut: cr.
	result
		nextPutAll: '			]';
		nextPut: cr.
	result
		nextPutAll: '		]';
		nextPut: cr.
	result
		nextPutAll: '	]';
		nextPut: cr.
	^ result contents