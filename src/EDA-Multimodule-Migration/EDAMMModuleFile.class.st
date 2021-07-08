Class {
	#name : #EDAMMModuleFile,
	#superclass : #Object,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #reading }
EDAMMModuleFile >> readFile: aFileReference [
	| result |
	result := Dictionary new.
	aFileReference
		readStreamDo: [ :stream | 
			[ stream atEnd ]
				whileFalse: [ | row |
					row := ',' split: stream nextLine.
					result
						add:(row first ->row second)
								 ] ].
	^ result
]
