Class {
	#name : #EDAJsonCommandMaterializer,
	#superclass : #EDACommandMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #'delete logic' }
EDAJsonCommandMaterializer >> isDeleteCommand: aDict [
    "Checks whether is a delete command"
	| meta |
	meta := aDict at: #meta ifAbsent: [ nil ].
	^ meta
		ifNil: [ 
			false
		] ifNotNil: [ :m |
			| delete |
			delete := meta at: #delete ifAbsent: [ nil ].
			delete isNotNil and: [ delete ]
		]

]

{ #category : #parsing }
EDAJsonCommandMaterializer >> materialize: json [
    "Returns a command instance from given JSON representation"
	| map builder |
	map := NeoJSONReader fromString: json.
	builder := EDACommandBuilderRegistry lookupBuilder: (self retrieveCommandName: map).
	^ builder buildWith: map

]

{ #category : #parsing }
EDAJsonCommandMaterializer >> retrieveCommandName: aCommandMap [
	^ (aCommandMap at: #meta) at: #type
]
