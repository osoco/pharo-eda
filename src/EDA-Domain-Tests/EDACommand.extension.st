Extension { #name : #EDACommand }

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> attributesReceivedNotRequired [
	"Overwrite if necessary with a set including the attributes received not required as symbols"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ Set empty ]
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> instVarsNeededExceptionFor: aTest [
	^ aTest commandInstVarsNeededException
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> instVarsNeededMessageFor: aTest [
	^ aTest commandInstVarsNeededMessage
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> sampleFileNameForTest: aTest [
	"overwrite if the sample file name does not follow the default criteria
	e.g. <classPrefix>CommandNameUpperCamelCase -> command.name.upper.camel.case.example.json
	"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ aTest defaultSampleFileNameFor: self ]
]

{ #category : #'*EDA-Domain-Tests' }
EDACommand class >> sampleFilesPathForTest: aTest [
	^ aTest commandSampleFilesPath
]
