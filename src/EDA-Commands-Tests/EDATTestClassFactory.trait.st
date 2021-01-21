"
A EDATTestClassFactory is a trait.

"
Trait {
	#name : #EDATTestClassFactory,
	#category : 'EDA-Commands-Tests'
}

{ #category : #accessing }
EDATTestClassFactory >> classFactory [
	^ classFactory
]

{ #category : #accessing }
EDATTestClassFactory >> classFactory: anObject [
	classFactory := anObject
]

{ #category : #'class-factory' }
EDATTestClassFactory >> newClass [
	^ self newSubclassOf: Object 
		instanceVariableNames: '' 
		classVariableNames: ''
]

{ #category : #'class-factory' }
EDATTestClassFactory >> newClassName: nameString [
	^ self
		newSubclassNamed: nameString
		of: Object
		instanceVariableNames: ''
		classVariableNames: ''
]

{ #category : #'class-factory' }
EDATTestClassFactory >> newSubclassNamed: nameString of: aClass  instanceVariableNames: ivNamesString classVariableNames: classVarsString [
	| class |
	SystemAnnouncer uniqueInstance suspendAllWhile: [
		class := aClass
			subclass: nameString asSymbol
			instanceVariableNames: ivNamesString
			classVariableNames:  classVarsString
			category: self classFactory defaultCategory
	].
	self classFactory createdClasses add: class.
	^ class
]

{ #category : #'class-factory' }
EDATTestClassFactory >> newSubclassOf: aClass instanceVariableNames: ivNamesString classVariableNames: classVarsString [ 
	^ self classFactory silentlyNewSubclassOf: aClass instanceVariableNames: ivNamesString classVariableNames:  classVarsString
]

{ #category : #running }
EDATTestClassFactory >> setUpClassFactory [
	self classFactory: ClassFactoryForTestCase new
]

{ #category : #running }
EDATTestClassFactory >> tearDownClassFactory [
	self classFactory cleanUp
]
