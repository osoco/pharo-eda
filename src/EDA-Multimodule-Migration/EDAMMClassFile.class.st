Class {
	#name : #EDAMMClassFile,
	#superclass : #Object,
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #reading }
EDAMMClassFile >> readClassNamed: aClassName inPackage: aPackageName inFolder: aFolder [
	^ ((TonelReader on: aFolder asFileReference fileName: aPackageName)
		definitions select: [ :def | def className = aClassName ])
]

{ #category : #writing }
EDAMMClassFile >> writeClassNamed: aString withDefinitions: aCollection inFolder: aFileReference [
	^ (aFileReference / aString , 'st')
		writeStreamDo: [ :stream | 
			| writer classDefinition |
			writer := TonelWriter new.
			classDefinition := (aCollection
				select: [ :def | def isClassDefinition ]) first.
			writer writeClassDefinition: classDefinition on: stream.
			(aCollection
				select: [ :def | 
					def isMethodDefinition
						and: [ def className = classDefinition className and: [ def classIsMeta ] ] ])
				collect:
					[ :def | writer writeMethodDefinition: def parent: classDefinition on: stream ].
			(aCollection
				select: [ :def | 
					def isMethodDefinition
						and: [ def className = classDefinition className
								and: [ def classIsMeta not ] ] ])
				collect:
					[ :def | writer writeMethodDefinition: def parent: classDefinition on: stream ] ];
		yourself
]
