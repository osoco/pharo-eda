Class {
	#name : #EDAEventGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #'code generation' }
EDAEventGenerator >> createEventClass [
	| cls attributes parent |
	cls := self retrieveEventClassName asSymbol.
	attributes := self
		retrieveEventAttributesBut: self class skippedEventAttributes.
	(self classExists: cls)
		ifTrue: [ attributes := self
				allAttributesOf: (self class environment at: cls)
				including: attributes ].
	parent := self isDeletedEvent
		ifTrue: [ EDADeleteCommandResultEvent ]
		ifFalse: [ EDACommandResultEvent ].
	parent
		subclass: cls
		uses: ATSTEvent
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassAccessors [
	| eventClass |
	eventClass := self class environment at: self retrieveEventClassName asSymbol.
	(self generateAccessorsFor: eventClass attributes:(self retrieveEventAttributesBut: self class skippedEventAttributes))
		associationsDo: [ :assoc | 
			self
				compile: assoc key
				sourceCode: assoc value
				inClass: eventClass
				classifiedAs: self protocol ]
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassAggregateRootClassMethod [
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'aggregateRootClass'
		sourceCode: self generateEventClassAggregateRootClassMethod
		inClass: cls class
		classifiedAs: 'meta'
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassBuilderMethod [
	| methodAssoc |
	self isDeletedEvent ifTrue: [ ^ self ].
	methodAssoc := self generateEventClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: (self class environment at: self retrieveEventClassName asSymbol) class
		classifiedAs: self protocol
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassEqualsMethod [
	| cls attributes |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	attributes := OrderedCollection withAll: self retrieveEventAttributes.
	attributes add: 'aggregateRootClass'.
	^ self
		compile: 'semanticEquals:'
		sourceCode: (self generateEqualsMethodFor: attributes)
		inClass: cls
		classifiedAs: self protocol
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassHashMethod [
	| cls attributes |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	attributes := OrderedCollection withAll: self retrieveEventAttributes.
	attributes add: 'aggregateRootClass'.
	^ self
		compile: 'semanticHash'
		sourceCode: (self generateHashMethodFor: attributes)
		inClass: cls
		classifiedAs: self protocol
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassInitializeMethod [
	| cls |
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'initialize'
		sourceCode: self generateEventInitializeMethod
		inClass: cls class
		classifiedAs: 'initialization'
]

{ #category : #'code generation' }
EDAEventGenerator >> createEventClassLatestVersionClassMethod [
	| cls |
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	cls class
		compile: self generateEventClassLatestVersionMethod
		classified: self protocol
]

{ #category : #protected }
EDAEventGenerator >> description [
	^ 'Event for ' , self eventName greaseString.

]

{ #category : #protected }
EDAEventGenerator >> doGenerate [
	self createEventClass.
	self createEventClassAccessors.
	self createEventClassBuilderMethod.
	self createEventClassEqualsMethod.
	self createEventClassHashMethod.
	self createEventClassLatestVersionClassMethod
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassAggregateRootClassMethod [
	| result methodName cr |
	cr := Character cr.
	methodName := 'aggregateRootClass'.
	result := WriteStream with: String new.
	result nextPutAll: methodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: self aggregate;
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassBuilderMethod [
	| result methodName method attrs cr cls |
	cr := Character cr.
	methodName := self generateEventClassBuilderMethodName.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'the').
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	attrs := self
		allAttributesOf: cls
		including: (self retrieveEventAttributesBut: self class skippedEventAttributes).
	method nextPut: cr.
	method nextPutAll: self generateSignature.
	method
		nextPutAll: '	| result | ';
		nextPut: cr.
	method nextPutAll: '	result := super '.
	method
		nextPutAll: (self generateEventClassBuilderMethodNameWithArgPrefix: 'the');
		nextPut: $.;
		nextPut: cr.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	theAttrs at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | result ';
				nextPutAll: attr;
				nextPutAll: ': v ].' ].
	method nextPut: cr.
	method nextPutAll: '	^ result'.
	result := {(methodName -> method contents)} asDictionary.
	^ result
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassBuilderMethodName [
	^ 'ofTenant:withAggregateId:commandId:andAttributes:'
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassBuilderMethodNameWithArgPrefix: prefix [
	^ 'ofTenant: ' , prefix , 'Tenant withAggregateId: ' , prefix
		, 'Id commandId: ' , prefix , 'CommandId andAttributes: ' , prefix
		, 'Attrs'
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassLatestVersionMethod [
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result nextPutAll: self generateEventClassLatestVersionMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
			nextPutAll: self version greaseString;
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventClassLatestVersionMethodName [
	^ 'latestVersion'
]

{ #category : #'code generation' }
EDAEventGenerator >> generateEventInitializeMethod [
	| result methodName cr |
	cr := Character cr.
	methodName := 'initialize'.
	result := WriteStream with: String new.
	result nextPutAll: methodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	super initialize.';
		nextPut: cr.
	result
		nextPutAll: '	self aggregateRootClass: #';
		nextPutAll: self appName;
		nextPutAll: self aggregate;
		nextPut: $.;
		nextPut: cr.
	^ result contents
]
