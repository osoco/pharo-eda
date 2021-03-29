Extension { #name : #Pragma }

{ #category : #'*EDA-Application' }
Pragma class >> allNamed: aSymbol inAndBelow: aClass [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol."

	^ Array
		streamContents: [ :stream | 
			aClass
				withAllSubclassesDo: [ :class | 
					self
						withPragmasIn: class
						do: [ :pragma | 
							pragma selector = aSymbol
								ifTrue: [ stream nextPut: pragma ] ].
					aClass = class
						ifTrue: [ ^ stream contents ] ] ]
]
