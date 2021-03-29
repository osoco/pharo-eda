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

	| map builder name |
	map := NeoJSONReader fromString: json.
	name := self retrieveCommandName: map.
	builder := EDACommandBuilderRegistry uniqueInstance lookupBuilder: name.
	builder
		ifNil: [ self
				logErrorMessage: 'Received unsupported ' , name greaseString
				andThrow: EDAInvalidCommandMessage ].
	^ builder buildWith: map
]

{ #category : #parsing }
EDAJsonCommandMaterializer >> retrieveCommandName: aCommandMap [
	^ (aCommandMap at: #meta) at: #type
]
