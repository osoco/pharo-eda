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
								add: 'input module' -> row first;
								add: 'input package' -> row second;
								add: 'input class' -> row third;
								add: 'output module' -> row fourth;
								add: 'output package' -> row fifth;
								add: 'output class' -> row sixth;
								yourself) ] ].
	^ result
]
