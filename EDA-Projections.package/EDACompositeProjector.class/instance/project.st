api
project
	Smalltalk isHeadless ifTrue: [ 	self projectors
		do: [ :projector | projector project ]
 ] ifFalse: [ 
	self projectors
		do: [ :projector | projector project ]
		displayingProgress: [ :projector | 'Projection ' , projector class projectionClass greaseString ] ]