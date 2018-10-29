accessing
logFinish: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: 'Published message ', message , ' in ', aConfig destination, '.'