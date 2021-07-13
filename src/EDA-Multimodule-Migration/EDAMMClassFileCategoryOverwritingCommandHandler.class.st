Class {
	#name : #EDAMMClassFileCategoryOverwritingCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#instVars : [
		'category'
	],
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'instance creation' }
EDAMMClassFileCategoryOverwritingCommandHandler class >> withCatalog: aString [
	^ self new category: aString; yourself
]

{ #category : #accessing }
EDAMMClassFileCategoryOverwritingCommandHandler >> category [
	^ category
]

{ #category : #accessing }
EDAMMClassFileCategoryOverwritingCommandHandler >> category: aString [
	category := aString
]

{ #category : #'command handling' }
EDAMMClassFileCategoryOverwritingCommandHandler >> handleCommand: aCommand within: aContext [
	| result |
	result := false.
	(self inputValid: aCommand within: aContext)
		ifTrue: [ | classDefinition definitions newDefinitions className |
			className := aCommand at: 'class'.
			definitions := aContext at: className.
			classDefinition := (definitions
				select: [ :def | def isClassDefinition ]) first.
			newDefinitions := OrderedCollection
				with:
					(EDAMMClassDefinitionWrapper
						for: classDefinition
						andCategory: self category).
			newDefinitions
				addAll: (definitions reject: [ :def | def isClassDefinition ]).
			aCommand at: className put: newDefinitions ].
	^ result
]

{ #category : #'command checking' }
EDAMMClassFileCategoryOverwritingCommandHandler >> inputValid: aCommand within: aContext [
	| result |
	result := aCommand includesKey: 'class'.
	result
		ifTrue: [ | className |
			className := aCommand at: 'class'.
			result := className isNotNil
				and: [ aContext includesKey: className ].
			result
				ifTrue: [ | definitions classDefinitions |
					definitions := aContext at: className.
					classDefinitions := definitions
						select: [ :def | def isClassDefinition ].
					result := classDefinitions isNotEmpty ] ].
	^ result
]
