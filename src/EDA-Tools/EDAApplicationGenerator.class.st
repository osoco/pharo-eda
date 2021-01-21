Class {
	#name : #EDAApplicationGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #'code generation' }
EDAApplicationGenerator >> createEDAApplicationRegisterCommandBuilders [
	^ self
		compile: self generateEDAApplicationRegisterCommandBuildersMethodName
		sourceCode: (self generateEDAApplicationRegisterCommandBuildersMethodFor: self appName)
		inClass: (self class environment at: (appName , 'EDAApplication') asSymbol) class
		classifiedAs: self protocol
]

{ #category : #protected }
EDAApplicationGenerator >> description [
	^ 'EDAApplication'
]

{ #category : #protected }
EDAApplicationGenerator >> doGenerate [
	self createEDAApplicationRegisterCommandBuilders
]

{ #category : #'code generation' }
EDAApplicationGenerator >> generateEDAApplicationRegisterCommandBuildersMethodFor: anAppName [
	| result commands cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateEDAApplicationRegisterCommandBuildersMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| builder |';
		nextPut: cr.
	result
		nextPutAll: '	builder := ';
		nextPutAll: (self appName);
		nextPutAll: 'DefaultCommandBuilder new.';
		nextPut: cr.
	result
		nextPutAll: '	EDACommandBuilderRegistry';
		nextPut: cr.
	commands := self retrieveImplementedCommandsFor: anAppName.
	commands keys asOrderedCollection
		keysAndValuesDo: [ :i :key | 
			i > 1
				ifTrue: [ result
						nextPut: $;;
						nextPut: cr ].
			result
				nextPutAll: '		addBuilder: builder forCommand: #';
				nextPutAll: key ].
	^ result contents
]

{ #category : #'code generation' }
EDAApplicationGenerator >> generateEDAApplicationRegisterCommandBuildersMethodName [
	^ 'registerCommandBuilders'
]
