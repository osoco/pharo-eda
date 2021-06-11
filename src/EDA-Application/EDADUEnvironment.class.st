"
* Class: EDADUEnvironment

Customization of DUEnvironment to be able to find configuration settings from other independent images, belonging to the same project.

* Responsibility:

Provide access to additional json files from other images under the same parent root.
"
Class {
	#name : #EDADUEnvironment,
	#superclass : #DUEnvironment,
	#traits : 'EDACLanguageHelper + EDACLogging',
	#classTraits : 'EDACLanguageHelper classTrait + EDACLogging classTrait',
	#classVars : [
		'CurrentEnvironment'
	],
	#category : #'EDA-Application'
}

{ #category : #accessing }
EDADUEnvironment class >> at: aSymbol ifAbsent: aBlock [
	"read in the json file the current value for the environment"

	| value |
	value := self envVarDictionary at: aSymbol ifAbsent: aBlock.
	self logDebugMessage: 'config/' , self currentEnvironment greaseString , '.json: ''' , aSymbol greaseString , ''' -> ''' , value greaseString , ''''.
	^ value
]

{ #category : #accessing }
EDADUEnvironment class >> currentEnvironment [
	| aux |
	aux := CurrentEnvironment.
	(aux isNil or: [ aux isEmpty ]) ifTrue: [ aux := super currentEnvironment ].
	(aux isNil or: [ aux isEmpty ]) ifTrue: [ aux := 'development' ].
	self currentEnvironment: aux.
	^ CurrentEnvironment

]

{ #category : #accessing }
EDADUEnvironment class >> currentEnvironment: aString [
	| previousEnvironment |
	previousEnvironment := CurrentEnvironment.
	CurrentEnvironment := aString.
	(previousEnvironment isNil or: [ previousEnvironment = aString ])
		ifTrue: [ ^ self ].
	EDASSettings resetSettings.
	self reloadSettingBrowser


]

{ #category : #'class initialization' }
EDADUEnvironment class >> doInitialize [
]

{ #category : #private }
EDADUEnvironment class >> envVarDictionary [
	| result |
	result := Dictionary new.
	self envVarDictionaryFiles do: [ :envFile |
		envFile exists 
			ifTrue: [ result := result union: (NeoJSONReader on: envFile readStream) parseMap ]].
	
	result ifEmpty: [ NotFound signal: (self envVarDictionaryFiles asCommaString) ]
			 ifNotEmpty: [ :n | ^n ]
]

{ #category : #private }
EDADUEnvironment class >> envVarDictionaryFiles [
	^ { FileLocator imageDirectory fullPath asFileReference 
		/ 'config' 
		/ (self currentEnvironment , '.json').
	  	"This leads to key conflicts. It was an initial attempt to support
		running more than one application in the same image.
		If that approach is resumed, this could be used as a reminder
		of the initial steps. Meanwhile it skips reading config
		files from other images since the keys in the json files
		are not unique.
		FileLocator imageDirectory parent
		/ 'game-core'
		/ 'config' 
		/ (self currentEnvironment , '.json').
		FileLocator imageDirectory parent
		/ 'game-image-processor'
		/ 'config' 
		/ (self currentEnvironment , '.json')."
		} asOrderedCollection.
]

{ #category : #accessing }
EDADUEnvironment class >> environment [
	(environment isNil or: [ environment isEmpty ])
		ifTrue: [ environment := nil.
			environment := super environment ].
	self logInfoMessage: 'Running in ', environment printString.
	^ environment
]

{ #category : #api }
EDADUEnvironment class >> environments [
	^ (FileLocator imageDirectory fullPath asFileReference / 'config') allChildren
		select: [ :f | f basename endsWith: '.json' ]
		thenCollect: [ :f | self removeSuffix: '.json' from: f basename ]
]

{ #category : #helper }
EDADUEnvironment class >> isSettingBrowserOpen [
	^ self currentWorld submorphs anySatisfy: [ :w | w model class = SettingBrowser ]
]

{ #category : #helper }
EDADUEnvironment class >> reloadSettingBrowser [
	((World submorphs select: [ :w | (w model printString = 'a SettingBrowser') ])) do: [ :w | w delete ].
	SettingBrowser open.
]
