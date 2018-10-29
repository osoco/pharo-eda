lifecycle
unsubscribe: id usingListener: aListener
	| frame client |
	client := aListener client.
	[ (frame := StampUnsubscribeFrame new) id: id.
	client writeWithReceipt: frame ]
		ensure: [ client
				ifNotNil: [ [ client close ]
						on: ConnectionTimedOut
							do: [ self logErrorMessage: 'Timeout while unsubscribing ' , id greaseString , '.' ];
						on: StampError
							do: [ self logErrorMessage: 'Cannot unsubscribe ', id greaseString , '.'
									 ] ] ]