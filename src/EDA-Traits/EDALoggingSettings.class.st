Class {
	#name : #EDALoggingSettings,
	#superclass : #Object,
	#classInstVars : [
		'debugEnabled',
		'infoEnabled',
		'errorEnabled',
		'warningEnabled',
		'loggingLevel',
		'traceEnabled'
	],
	#category : #'EDA-Traits'
}

{ #category : #accessing }
EDALoggingSettings class >> debugEnabled [
	^ debugEnabled
]

{ #category : #accessing }
EDALoggingSettings class >> debugEnabled: aBoolean [
	debugEnabled := aBoolean.
	aBoolean
		ifTrue: [ self infoEnabled: true ]
]

{ #category : #'class initialization' }
EDALoggingSettings class >> doInitialize [
	self loggingLevel: 'debug'

]

{ #category : #accessing }
EDALoggingSettings class >> errorEnabled [
	^ errorEnabled
]

{ #category : #accessing }
EDALoggingSettings class >> errorEnabled: aBoolean [
	errorEnabled := aBoolean
]

{ #category : #accessing }
EDALoggingSettings class >> infoEnabled [
	^ infoEnabled
]

{ #category : #accessing }
EDALoggingSettings class >> infoEnabled: aBoolean [
	infoEnabled := aBoolean.
	aBoolean
		ifTrue: [ self warningEnabled: true ]
]

{ #category : #'class initialization' }
EDALoggingSettings class >> initialize [
	self doInitialize
]

{ #category : #accessing }
EDALoggingSettings class >> levels [
	^ #('trace' 'debug' 'info' 'warning' 'error')
]

{ #category : #accessing }
EDALoggingSettings class >> loggingLevel [
	^ loggingLevel
]

{ #category : #accessing }
EDALoggingSettings class >> loggingLevel: aLevel [
	| failed |
	failed := true.
	self traceEnabled: (aLevel = 'trace').
	self debugEnabled: (self traceEnabled or: [ (aLevel = 'debug') ]).
	self infoEnabled: (self debugEnabled or: [ (aLevel = 'info') ]).
	self warningEnabled: (self infoEnabled or: [  (aLevel = 'warning') ]).
	self errorEnabled: (self warningEnabled or: [ (aLevel = 'error') ]).
	failed := (self traceEnabled or: [ self debugEnabled or: [ self infoEnabled or: [ self warningEnabled or: [ self errorEnabled  ] ] ] ]) not.
	failed
		ifTrue: [ EDAInvalidLoggingLevel signal ]
		ifFalse: [ loggingLevel := aLevel ]

]

{ #category : #accessing }
EDALoggingSettings class >> traceEnabled [
	^ traceEnabled
]

{ #category : #accessing }
EDALoggingSettings class >> traceEnabled: aBoolean [
	traceEnabled := aBoolean.
	aBoolean
		ifTrue: [ self debugEnabled: true ]
]

{ #category : #accessing }
EDALoggingSettings class >> warningEnabled [
	^ warningEnabled
]

{ #category : #accessing }
EDALoggingSettings class >> warningEnabled: aBoolean [
	warningEnabled := aBoolean.
	aBoolean
		ifTrue: [ self errorEnabled: true ]
]
