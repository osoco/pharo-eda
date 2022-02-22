Extension { #name : #EDACommand }

{ #category : #'*EDA-Domain-Tests' }
EDACommand >> asJsonMessage [
	^ (self class testMessageClass fromInstance: self) asJsonMessage
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> attributesReceivedNotRequired [
	"Overwrite if necessary with a set including the attributes received not required as symbols
	e.g. 
	| attributesReceivedNotRequired |
	attributesReceivedNotRequired := super attributesReceivedNotRequired.
	attributesReceivedNotRequired addAll: (Set with: #attribute1 with: #attribute2).
	^ attributesReceivedNotRequired
	"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ Set with: #aggregate with: #type with: #correlationId ]
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> sampleFileNameForTestMessage: aTestMessage [
	"overwrite if the sample file name does not follow the default criteria
	e.g. <classPrefix>CommandNameUpperCamelCase -> command.name.upper.camel.case.example.json
	Take care set your domain test package as method category extension
	"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ aTestMessage defaultSampleFileNameFor: self ]
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> sampleFilesPathForTestMessage: aTestMessage [
	^ aTestMessage commandSampleFilesPath
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> testMessageClass [
	^ EDATestCommandMessage
]
