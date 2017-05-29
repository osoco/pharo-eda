initialization
logFinish: message usingClient: aClient withConfig: aConfig
	Transcript
		print: '<< Finished processing message: ';
		print: message;
		print: ' from ';
		print: aConfig queue;
		cr;
		flush