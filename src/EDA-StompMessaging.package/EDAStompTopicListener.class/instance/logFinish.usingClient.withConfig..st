initialization
logFinish: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: '<< Finished processing message: ', message greaseString , ' from ', aConfig queue greaseString , '.'