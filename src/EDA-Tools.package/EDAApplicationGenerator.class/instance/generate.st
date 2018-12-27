api
generate
	self logDebugMessage: '** Generating EDAApplication >> registerCommandBuilders for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createEDAApplicationRegisterCommandBuilders