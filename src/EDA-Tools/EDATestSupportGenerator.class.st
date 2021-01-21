Class {
	#name : #EDATestSupportGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #asserting }
EDATestSupportGenerator class >> shouldRunAfter: anotherGenerator [
	^ anotherGenerator = EDADomainTestEventGenerator
]

{ #category : #'code generation' }
EDATestSupportGenerator >> createTestHelperBuildEventClassMethod [
	| method |
	method := self generateTestHelperBuildEventClassMethod.
	method
		associationsDo: [ :assoc | 
			^ self
				compile: assoc key
				sourceCode: assoc value
				inClass: (self class environment at: self retrieveTestHelperTraitName asSymbol) class
				classifiedAs: self protocol ]
]

{ #category : #protected }
EDATestSupportGenerator >> description [
	^ 'helper methods for testing ' , self aggregate greaseString
]

{ #category : #protected }
EDATestSupportGenerator >> doGenerate [
	self createTestHelperBuildEventClassMethod
]

{ #category : #'code generation' }
EDATestSupportGenerator >> generateTestHelperBuildEventClassMethod [
	| result methodName method attrs cr |
	cr := Character cr.
	methodName := self generateTestHelperBuildEventClassMethodName.
	method := WriteStream with: String new.
	method nextPutAll: (self generateTestHelperBuildEventClassMethodNameWithArgPrefix: 'new').
	method nextPutAll: self generateSignature.
	attrs := self retrieveEventAttributesBut: self class skippedEventAttributes.
	method nextPut: cr.
	method
		nextPutAll: '	| result | ';
		nextPut: cr.
	method
		nextPutAll: '	result := self new.';
		nextPut: cr.
	method
		nextPutAll: '	result id: UUID new asString.';
		nextPut: cr.
	method
		nextPutAll: '	result commandId: newCommandId.';
		nextPut: cr.
	method nextPutAll: '	result timestamp: DateAndTime now asUTC.'.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	result ';
				nextPutAll: attr;
				nextPutAll: ': new';
				nextPutAll: attr capitalized;
				nextPut: $. ].
	method nextPut: cr.
	method nextPutAll: '	^ result'.
	result := Dictionary new.
	result at: methodName put: method contents.
	^ result
]

{ #category : #'code generation' }
EDATestSupportGenerator >> generateTestHelperBuildEventClassMethodName [
	^ 'ofTenant:withAggregateId:commandId:andAttributes:'
]

{ #category : #'code generation' }
EDATestSupportGenerator >> generateTestHelperBuildEventClassMethodNameWithArgPrefix: prefix [
	^ 'ofTenant: ' , (prefix , 'Tenant') , ' withAggregateId: '
		, (prefix , 'Id') uncapitalized , ' commandId: '
		, (prefix , 'CommandId') uncapitalized , ' andAttributes: '
		, (prefix , 'Attributes') uncapitalized
]

{ #category : #delegated }
EDATestSupportGenerator >> retrieveTestHelperTraitName [
	| delegate |
	delegate := EDATestTraitGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate retrieveTestHelperTraitName
]
