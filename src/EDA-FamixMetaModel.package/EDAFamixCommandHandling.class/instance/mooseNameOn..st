accessing
mooseNameOn: aStream
	self command ifNotNil: [ aStream nextPutAll: self command name ].
	aStream nextPutAll: ' -> '.
	self aggregate ifNotNil: [ aStream nextPutAll: self aggregate name ]