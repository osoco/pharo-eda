initialization
logInit: message usingClient: aClient withConfig: aConfig
	Transcript
		cr;
		print: '>> Processing incoming message: ';
		print: message;
		print: ' from ';
		print: aConfig queue;
		cr