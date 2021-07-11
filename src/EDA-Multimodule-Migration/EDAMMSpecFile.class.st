Class {
	#name : #EDAMMSpecFile,
	#superclass : #Object,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #reading }
EDAMMSpecFile >> readFile: aFileReference [
	| result |
	result := OrderedCollection new.
	aFileReference
		readStreamDo: [ :stream | 
			[ stream atEnd ]
				whileFalse: [ | row |
					row := ',' split: stream nextLine.
					result
						add:
							(Dictionary new
								add: 'input package' -> row first;
								add: 'input class' -> row second;
								add: 'output module' -> row third;
								add: 'output package' -> row fourth;
								add: 'output class' -> row fifth;
								yourself) ] ].
	^ result
]
