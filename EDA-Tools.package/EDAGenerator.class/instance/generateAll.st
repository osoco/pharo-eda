api
generateAll
	Transcript
		print: '** Generation started for ';
		print: self aggregate;
		cr;
		flush.
	self generateAllButIntegrationTest.
	self generateIntegrationTest