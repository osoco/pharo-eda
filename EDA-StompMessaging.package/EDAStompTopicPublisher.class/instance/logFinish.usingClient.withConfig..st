logging
logFinish: message usingClient: aClient withConfig: aConfig
	Transcript print: 'Published message ', message , ' in ', aConfig destination; cr; flush.