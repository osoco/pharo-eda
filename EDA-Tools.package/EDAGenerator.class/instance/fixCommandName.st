accessing
fixCommandName
	| cmd |
	cmd := self commandName.
	self flag: #TODO. "Fix the command types"
	cmd = 'CONTEST_CREATED'
		ifTrue: [ self commandName: 'CREATE_CONTEST' ]