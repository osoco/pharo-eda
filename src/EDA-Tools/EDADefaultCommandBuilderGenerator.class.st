Class {
	#name : #EDADefaultCommandBuilderGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #'code generation' }
EDADefaultCommandBuilderGenerator >> createDefaultCommandBuilderInitializeCommandBuilders [
	^ self
		compile: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName
		sourceCode: (self generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: self appName)
		inClass: (self class environment at: (appName , 'DefaultCommandBuilder') asSymbol)
		classifiedAs: self protocol
]

{ #category : #protected }
EDADefaultCommandBuilderGenerator >> description [
	^ 'DefaultCommandBuilder'
]

{ #category : #protected }
EDADefaultCommandBuilderGenerator >> doGenerate [
	self
		logDebugMessage:
			'** Generating DefaultCommandBuilder >> initializeCommandBuilders for '
				, self aggregate greaseString , ', version ' , self version greaseString.
	self createDefaultCommandBuilderInitializeCommandBuilders
]

{ #category : #'code generation' }
EDADefaultCommandBuilderGenerator >> generateDefaultCommandBuilderInitializeCommandBuildersMethodFor: anAppName [
	| result commands cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateDefaultCommandBuilderInitializeCommandBuildersMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	commandDictionary := {'.
	commands := self retrieveImplementedCommandsFor: anAppName.
	commands keys asOrderedCollection
		keysAndValuesDo: [ :i :key | 
			i > 1
				ifTrue: [ result nextPut: $. ].
			result
				nextPut: cr;
				nextPutAll: '		(#';
				nextPutAll: key;
				nextPutAll: ' -> ';
				nextPutAll: (self removeClassLiteralFromMetaClassName: (commands at: key) name);
				nextPut: $) ].
	result
		nextPut: cr;
		nextPutAll: '	} asDictionary'.
	^ result contents
]

{ #category : #'code generation' }
EDADefaultCommandBuilderGenerator >> generateDefaultCommandBuilderInitializeCommandBuildersMethodName [
	^ 'initializeCommandBuilders'
]
