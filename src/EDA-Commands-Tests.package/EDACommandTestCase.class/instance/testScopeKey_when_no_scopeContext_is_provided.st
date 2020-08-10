tests
testScopeKey_when_no_scopeContext_is_provided
	| command |
	command := EDACommand new.
	self assert: command scopeKey isNil