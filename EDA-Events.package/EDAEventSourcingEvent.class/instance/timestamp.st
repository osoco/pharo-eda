accessing
timestamp
    timestamp ifNil: [ timestamp := DateAndTime now ].
	^ timestamp