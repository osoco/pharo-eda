lifecycle
close
	[ self client close ]
		on: StampError , PrimitiveFailed, ZnIncomplete
		do: [ :ex |
			self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Error closing Stamp connection: ';
								nextPutAll: ex greaseString ]) ]