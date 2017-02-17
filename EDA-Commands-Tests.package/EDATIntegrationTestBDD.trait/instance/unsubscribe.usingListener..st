as yet unclassified
unsubscribe: id usingListener: aListener
	| frame client |
	client := aListener client.
	[
	(frame := StampUnsubscribeFrame new) id: id.
	client writeWithReceipt: frame ]
		ensure: [
			client
				ifNotNil:
					[ [ client close ]
						on: ConnectionTimedOut
							do: [
								"nothing"
								 ];
						on: StampError
							do: [
								"nothing"
								 ] ] ]