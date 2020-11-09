printing
mooseNameOn: aStream
	self aggregate  ifNotNil: [ aStream nextPutAll: self aggregate  name ].
	aStream nextPutAll: ' -> '.
	self event  ifNotNil: [ aStream nextPutAll: self event  name ]