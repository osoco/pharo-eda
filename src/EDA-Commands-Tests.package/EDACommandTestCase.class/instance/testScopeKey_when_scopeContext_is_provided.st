tests
testScopeKey_when_scopeContext_is_provided
	| expected actual scopeContext scopes tenant group subgroup command |
	subgroup := Dictionary new.
	subgroup at: 'id' put: 'subgroup-1'.
	group := Dictionary new.
	group at: 'id' put: 'group-1'.
	group at: 'subgroup' put: subgroup.
	tenant := Dictionary new.
	tenant at: 'id' put: 'tenant-1'.
	tenant at: 'group' put: group.
	scopes := Dictionary new.
	scopes at: 'tenant' put: tenant.
	scopeContext := Dictionary new.
	scopeContext at: 'scopes' put: scopes.
	scopeContext at: 'scope' put: 'group'.
	command := EDACommand new.
	command scopeContext: scopeContext.
	actual := command scopeKey.
	expected := OrderedCollection with: 'tenant-1' with: 'group-1'.
	self assert: expected equals: actual