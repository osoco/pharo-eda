Class {
	#name : #EDAJsonMaterializer,
	#superclass : #EDAMaterializer,
	#category : #'EDA-Messaging-Materializers'
}

{ #category : #'delete logic' }
EDAJsonMaterializer >> isDelete: aDict [
	"Checks whether is a delete command / event"

	| meta |
	meta := aDict at: #meta ifAbsent: [ nil ].
	^ meta
		ifNil: [ false ]
		ifNotNil: [ :m | 
			| delete |
			delete := meta at: #delete ifAbsent: [ nil ].
			delete isNotNil and: [ delete ] ]
]

{ #category : #parsing }
EDAJsonMaterializer >> materialize: json [
	"Returns a command or event instance from given JSON representation"

	| map builder name |
	map := NeoJSONReader fromString: json.
	name := self retrieveName: map.
	builder := self builderFor: name with: map.
	^ builder buildWith: map
]

{ #category : #parsing }
EDAJsonMaterializer >> retrieveName: aMap [
	^ (aMap at: #meta) at: #type
]
