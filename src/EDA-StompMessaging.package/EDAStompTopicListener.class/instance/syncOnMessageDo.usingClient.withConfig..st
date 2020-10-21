enumerating
syncOnMessageDo: aBlock usingClient: aClient withConfig: conf
	[ aClient
		runWith: [ :message | 
			| text |
			text := message body greaseString.
			self
				logInit: message body greaseString
				usingClient: aClient
				withConfig: conf.
			[ | ack |
			aBlock value: text.
			ack := conf ack.
			ack = #'client-individual'
				ifFalse: [ self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'ACK was ''';
										nextPutAll: conf ack greaseString;
										nextPutAll: ''' in ';
										nextPutAll: conf class greaseString;
										nextPutAll: '. Resetting it to client-individual.' ]).
					ack := #'client-individual' ].
			ack = #'client-individual'
				ifTrue: [ self logDebugMessage: 'Sending ACK...'.
					aClient writeWithReceipt: message ackFrame.
					self logDebugMessage: 'ACK sent.' ]
				ifFalse: [ self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'Skipping ACK (type is ''';
										nextPutAll: conf ack greaseString;
										nextPut: $' ]) ].
			self
				logFinish: message body greaseString
				usingClient: aClient
				withConfig: conf ]
				on: Error - Break
				do: [ :ex | 
					((ex isKindOf: StampError) and: ex messageText = 'AMQP channel died')
						ifTrue: [ ex signal ].
					self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'Error consuming message: ';
										nextPutAll: ex description greaseString;
										nextPutAll: ' (';
										nextPutAll: thisContext stack last greaseString;
										nextPut: $) ]).
					conf ack = #'client-individual'
						ifTrue: [ | nack |
							self
								logDebugMessage:
									(String
										streamContents: [ :s | 
											s
												nextPutAll: 'Sending NACK message... ';
												nextPutAll: text greaseString;
												nextPut: $. ]).
							nack := message nackFrame.
							nack headers at: 'requeue' put: 'False'.
							aClient writeWithReceipt: nack.
							self
								logDebugMessage:
									(String
										streamContents: [ :s | 
											s
												nextPutAll: 'NACK message sent ';
												nextPutAll: text greaseString;
												nextPut: $. ]) ].
					self
						manageError: ex
						forMessage: text
						usingErrorStrategy: EDACommandConsumingErrorBehavior strategy ] ] ]
		on: PrimitiveFailed
		do: [ :ex | self logErrorMessage: ex greaseString ]