Class {
	#name : #EDAAggregateContractCheckerGenerator,
	#superclass : #AbstractEDAGenerator,
	#traits : 'EDATCheckerGenerator',
	#classTraits : 'EDATCheckerGenerator classTrait',
	#category : 'EDA-Tools'
}

{ #category : #'instance creation' }
EDAAggregateContractCheckerGenerator class >> fromExampleFile: aFile version: version appName: appName aggregate: aggregate [
	| result |
	result := self new
		commandFile: aFile;
		appName: appName;
		aggregate: aggregate;
		version: version.
	result commandRaw: result readCommandExampleFile.
	result commandJson: (NeoJSONReader fromString: result commandRaw).
	result commandName: ((result commandJson at: #meta) at: #type).
	^ result
]

{ #category : #'code generation' }
EDAAggregateContractCheckerGenerator >> checkerMethod [
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self checkerMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	self assert: ((';
		nextPutAll: self retrieveAggregateClassName;
		nextPutAll:
			' thoroughWhichSelectorsReferTo: #ofTenant:withAggregateId:commandId:andAttributes:) select: [ :methodName | methodName = ''handle';
		nextPutAll: (self underscoreSeparatedToCamelCase: commandName);
		nextPutAll: ':'']) isNotEmpty.';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDAAggregateContractCheckerGenerator >> checkerMethodName [
	^ 'testHandle' , (self underscoreSeparatedToCamelCase: commandName) , 'UsesTheExpectedEventBuilderV' , (self version asString)
]
