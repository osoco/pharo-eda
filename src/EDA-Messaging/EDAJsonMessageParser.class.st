Class {
	#name : #EDAJsonMessageParser,
	#superclass : #EDAMessageParser,
	#traits : 'EDATJsonHelper',
	#classTraits : 'EDATJsonHelper classTrait',
	#category : #'EDA-Messaging-Parsers'
}

{ #category : #testing }
EDAJsonMessageParser >> messageSupported [
	| result |
	[
		self parseJson: self message.
		result := true
	 ]
on: Error - Break do: [ result := false ].
^ result
]

{ #category : #testing }
EDAJsonMessageParser >> parse [
	^ self parseJson: (self message)
]
