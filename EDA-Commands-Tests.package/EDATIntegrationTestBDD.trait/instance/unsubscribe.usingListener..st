lifecycle
unsubscribe: id usingListener: aListener
	| frame client |
	client := aListener client.
	[ (frame := StampUnsubscribeFrame new) id: id.
	client writeWithReceipt: frame ]
		ensure: [ client
				ifNotNil: [ [ client close ]
						on: ConnectionTimedOut
							do: [ Transcript print: 'ERROR: Timeout while unsubscribing '; print: id greaseString; cr ];
						on: StampError
							do: [ Transcript print: 'ERROR: Cannot unsubscribe '; print: id greaseString; cr ] ] ]
