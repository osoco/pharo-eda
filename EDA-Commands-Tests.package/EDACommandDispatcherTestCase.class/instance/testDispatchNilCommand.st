tests
testDispatchNilCommand
	|   |
	self should: [ dispatcher dispatch: nil ] raise: EDACommandError