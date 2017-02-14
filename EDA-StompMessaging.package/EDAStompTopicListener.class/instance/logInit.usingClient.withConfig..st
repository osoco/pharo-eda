initialization
logInit: message usingClient: aClient withConfig: aConfig
	Transcript print: 'Receiving message ', message , ' from ', aConfig queue; cr; flush.