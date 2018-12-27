code generation
generate
	self logDebugMessage: 'Generating helper methods for testing ', self aggregate greaseString, ', version ', self version greaseString.
	self createTestEventBuildEventClassMethod.
	self createTestHelperBuildEventClassMethod