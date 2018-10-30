logging
logInit: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: 'Publishing message in ', aConfig destination greaseString , '.'