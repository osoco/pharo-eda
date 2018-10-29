initialization
logFinish: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: '<< Finished processing message: ', message, ' from ', aConfig queue, '.'