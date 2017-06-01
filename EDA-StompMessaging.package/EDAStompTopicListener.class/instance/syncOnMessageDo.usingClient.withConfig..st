enumerating
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	aClient
		runWith: [ :message | 
			self logInit: message body greaseString usingClient: aClient withConfig: conf.
			[ aBlock value: message body greaseString.
			conf ack = #'client-individual'
				ifTrue: [ aClient writeWithReceipt: message ackFrame ].
			self logFinish: message body greaseString usingClient: aClient withConfig: conf ]
				on: Error
				do: [ :ex | 
					Transcript
						cr;
						print: '<< Error consuming message: ';
						print: ex description;
						cr.
					conf ack = #'client-individual'
						ifTrue: [ | nack |
							nack := message nackFrame.
							nack headers at: 'requeue' put: 'False'.
							aClient writeWithReceipt: nack ] ] ]