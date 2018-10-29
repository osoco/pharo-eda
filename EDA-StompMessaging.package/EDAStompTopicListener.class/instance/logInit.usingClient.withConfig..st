initialization
logInit: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: '>> Processing incoming message: ', message, ' from ', aConfig queue, '.'
