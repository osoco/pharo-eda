initialization
logFinish: message usingClient: aClient withConfig: aConfig
	Transcript print: 'Received message ', message , ' from ', aConfig queue; cr; flush.