enumerating
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	aClient
		runWith: [ :message | 
			self logInit: message body greaseString usingClient: aClient withConfig: conf.
			[ | text |
				text := message body greaseString.
				aBlock value: text.
				(conf ack = #'client-individual')
					ifTrue: [
						Transcript
							print: 'DEBUG: ACK sent.';
							cr.
						aClient writeWithReceipt: message ackFrame
					] ifFalse: [ 
						Transcript
							print: 'DEBUG: Skipping ACK (type is ''client-individual'').';
							cr.
					].
				self logFinish: message body greaseString usingClient: aClient withConfig: conf
			]
			on: Error
			do: [ :ex | 
				Transcript
					cr;
					print: '<< Error consuming message: ';
					print: ex description;
					cr;
					print: thisContext stackList last
					cr.
				(conf ack = #'client-individual')
					ifTrue: [ | nack |
						Transcript
							print: 'DEBUG: NACK message ';
							print: message id;
							cr.
						nack := message nackFrame.
						nack headers at: 'requeue' put: 'False'.
						aClient writeWithReceipt: nack
					]
			]
		]