lifecycle
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	aClient
		runWith: [ :message | 
			self logInit: message body asString usingClient: aClient withConfig: conf.
			[ aBlock value: message body asString ]
				on: Error
				do: [ :ex | 
					Transcript
						cr;
						show: 'Error consuming message: ' , ex description;
						cr ].	"transcript and ignore"
			conf ack = #'client-individual'
				ifTrue: [ aClient writeWithReceipt: message ackFrame ].
			self logFinish: message body asString usingClient: aClient withConfig: conf ]