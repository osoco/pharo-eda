enumerating
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	aClient
		runWith: [ :message | 
			self logInit: message body greaseString usingClient: aClient withConfig: conf.
			[ | text |
			text := message body greaseString.
			aBlock value: text.
			conf ack = #'client-individual'
				ifTrue: [ Transcript
						print: 'DEBUG: sending ACK...';
						cr.
					aClient writeWithReceipt: message ackFrame.
					Transcript
						print: 'DEBUG: ACK sent.';
						cr ]
				ifFalse: [ Transcript
						print: 'DEBUG: Skipping ACK (type is ''client-individual'').';
						cr ].
			self logFinish: message body greaseString usingClient: aClient withConfig: conf ]
				on: Error
				do: [ :ex | 
					((ex isKindOf: StampError) and: ex messageText = 'AMQP channel died')
						ifTrue: [ ex signal ].
					Transcript
						cr;
						print: '<< Error consuming message: ';
						print: ex description;
						cr;
						print: thisContext stack last;
						cr.
					conf ack = #'client-individual'
						ifTrue: [ | nack |
							Transcript
								print: 'DEBUG: sending NACK message... ';
								print: message;
								cr.
							nack := message nackFrame.
							nack headers at: 'requeue' put: 'False'.
							aClient writeWithReceipt: nack.
							Transcript
								print: 'DEBUG: NACK message sent ';
								print: message;
								cr. ] ] ]