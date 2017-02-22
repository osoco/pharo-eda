writing
write: frame
	(frame respondsTo: #contentType)
		ifTrue: [ frame contentType = 'text/plain'
				ifTrue: [ frame contentType: 'application/json' ] ].
	self halt.
	super write: frame