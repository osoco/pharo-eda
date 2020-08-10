accessing
scopeKey
	^ self scopeContext
		ifNil: [ nil ]
		ifNotNil: [ :ctx |
			self
				extractScopeKey: (ctx at: 'scopes')
				target: (ctx at: 'scope' ifAbsent: [ nil ])
				accummulator: OrderedCollection new ]