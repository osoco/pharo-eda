Class {
	#name : #EDAJsonEventMaterializer,
	#superclass : #EDAJsonMaterializer,
	#traits : 'EDATEventMaterializer',
	#classTraits : 'EDATEventMaterializer classTrait',
	#category : #'EDA-Events-Materializers'
}

{ #category : #accessing }
EDAJsonEventMaterializer >> builderFor: aString with: aMap [
	| builder |
	builder := EDAEventBuilderRegistry uniqueInstance
		lookupBuilder: aString.
	builder
		ifNil: [ builder := EDAPragmaBasedEventBuilder newFor: aString with: aMap ].
	^ builder
]

{ #category : #parsing }
EDAJsonEventMaterializer >> materialize: json [
	"Returns a command or event instance from given JSON representation"

	| map builder name |
	map := NeoJSONReader fromString: json.
	name := self retrieveName: map.
	builder := self builderFor: name with: map.
	^ builder build
]
