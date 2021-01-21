Class {
	#name : #EDACompositeGenerator,
	#superclass : #EDAGenerator,
	#instVars : [
		'generatorClasses'
	],
	#category : 'EDA-Tools'
}

{ #category : #protected }
EDACompositeGenerator >> description [
	^ 'Composite generator for ', self generatorClasses
]

{ #category : #protected }
EDACompositeGenerator >> doGenerate [
	^ nil
]

{ #category : #api }
EDACompositeGenerator >> generate [
	| generators |
	generators := self generatorClasses collect: [ :generatorClass |
		 generatorClass
				fromExampleFile: self commandFile
				version: self version
				appName: self appName
				aggregate: self aggregate
				commandNameResolver: self commandNameResolver
				andEventNameResolver: self eventNameResolver ].
	generators
		keysAndValuesDo: [ :index :generator | 
			generator generate ]
		displayingProgress:
			[ :index :generator | generator buildMessage ]
]

{ #category : #accessing }
EDACompositeGenerator >> generatorClasses [
	^ generatorClasses
]

{ #category : #accessing }
EDACompositeGenerator >> generatorClasses: aCollection [
	generatorClasses := aCollection
]

{ #category : #initialization }
EDACompositeGenerator >> initialize [
	self
		generatorClasses: (self sortGeneratorClasses: EDAGenerator allSubclasses)
]

{ #category : #initialization }
EDACompositeGenerator >> sortGeneratorClasses: aCollection [
	^ (aCollection reject: [ :cls | cls = self class ]) asSortedCollection: [ :first :second | (first shouldRunAfter: second) not ]
]
