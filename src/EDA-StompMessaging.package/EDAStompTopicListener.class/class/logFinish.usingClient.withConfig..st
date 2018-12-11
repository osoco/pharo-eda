accessing
logFinish: message usingClient: aClient withConfig: aConfig
	self logInfoMessage: 'Published message ', message greaseString , ' in ', aConfig destination greaseString , '.'