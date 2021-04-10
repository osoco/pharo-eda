Class {
	#name : #EDAJsonEventMaterializer,
	#superclass : #EDAJsonMaterializer,
	#traits : 'EDATEventMaterializer',
	#classTraits : 'EDATEventMaterializer classTrait',
	#category : #'EDA-Events-Materializers'
}

{ #category : #parsing }
EDAJsonEventMaterializer >> materialize: json [
	"Returns a command or event instance from given JSON representation"

	| map builder name |
	map := NeoJSONReader fromString: json.
	name := self retrieveName: map.
	builder := self builderFor: name with: map.
	^ builder build
]