Class {
	#name : #EDAErrorsGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #'code generation' }
EDAErrorsGenerator >> createAggregateDoesNotExistErrorClass [
	| cls attributes |
	cls := (self appName , self aggregate capitalized , 'DoesNotExist' ) asSymbol.
	attributes := OrderedCollection new.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) ].
	^ EDAAggregateRootDoesNotExist
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)
]

{ #category : #'code generation' }
EDAErrorsGenerator >> createInvalidAggregateErrorClass [
	| cls attributes |
	cls := (self appName , 'Invalid' , self aggregate capitalized) asSymbol.
	attributes := OrderedCollection new.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) ].
	^ EDADomainException
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)
]

{ #category : #'code generation' }
EDAErrorsGenerator >> createInvalidCommandErrorClass [
	| cls attributes |
	cls := (self appName , 'Invalid' , (self toCamelCase: self commandName))
		asSymbol.
	attributes := OrderedCollection new.
	(self classExists: cls)
		ifTrue:
			[ attributes := self allAttributesOf: (self class environment at: cls) ].
	^ EDADomainException
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)
]

{ #category : #protected }
EDAErrorsGenerator >> description [
	^ 'Error classes for ' , self aggregate greaseString
]

{ #category : #protected }
EDAErrorsGenerator >> doGenerate [
	<doc: 'Generates error classes'>
	"self createInvalidAggregateErrorClass.
	self createAggregateDoesNotExistErrorClass"
	self createInvalidCommandErrorClass
]
