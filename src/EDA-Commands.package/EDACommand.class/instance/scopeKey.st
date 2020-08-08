accessing
scopeKey
	^ self
		extractScopeKey: (self scopeContext at: 'scopes')
		target: (self scopeContext at: 'scope' ifAbsent: [ nil ])
		accummulator: OrderedCollection new