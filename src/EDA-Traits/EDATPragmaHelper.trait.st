Trait {
	#name : #EDATPragmaHelper,
	#category : #'EDA-Traits'
}

{ #category : #pragmas }
EDATPragmaHelper classSide >> retrievePragma: aSymbol inAndBelow: aClass [
	| candidates |
	candidates := self retrievePragmas: aSymbol inAndBelow: aClass.
	candidates size > 1
		ifTrue: [ | message |
			message := String new
				streamContents: [ :str | 
					str
						nextPutAll: 'More than one pragma <';
						nextPutAll: aSymbol greaseString;
						nextPutAll: '> found: '.
					candidates
						do: [ :c | str nextPutAll: c selector greaseString ]
						separatedBy: [ str nextPutAll: ', ' ] ].
			self errorClass signal: message ].
	^ candidates first
]

{ #category : #pragmas }
EDATPragmaHelper classSide >> retrievePragma: aSymbol with: aValue inAndBelow: aClass [
	| candidates |
	candidates := self retrievePragmas: aSymbol with: aValue inAndBelow: aClass.
	candidates size > 1
		ifTrue: [ | message |
			message := String new
				streamContents: [ :str | 
					str
						nextPutAll: 'More than one pragma <';
						nextPutAll: aSymbol greaseString;
						nextPut: Character space;
						nextPutAll: aValue greaseString;
						nextPutAll: '> found: '.
					candidates
						do: [ :c | str nextPutAll: c selector greaseString ]
						separatedBy: [ str nextPutAll: ', ' ] ].
			self errorClass signal: message ].
	^ candidates first
]

{ #category : #pragmas }
EDATPragmaHelper classSide >> retrievePragmas: aSymbol inAndBelow: aClass [
	| result |
	result := Pragma allNamed: aSymbol inAndBelow: aClass.
	result
		ifEmpty: [ self errorClass new
				signal: 'No pragma <' , aSymbol greaseString , '> found' ].
	^ result
]

{ #category : #pragmas }
EDATPragmaHelper classSide >> retrievePragmas: aSymbol with: aValue inAndBelow: aClass [
	| result |
	result := (Pragma allNamed: aSymbol inAndBelow: aClass)
		select: [ :p | (p argumentAt: 1) = aValue ].
	result
		ifEmpty: [ self errorClass new
				signal:
					'No pragma <' , aSymbol greaseString , ' ' , aValue greaseString
						, '> found' ].
	^ result
]

{ #category : #pragmas }
EDATPragmaHelper >> retrievePragma: aSymbol inAndBelow: aClass [
	^ self class retrievePragma: aSymbol inAndBelow: aClass
]

{ #category : #pragmas }
EDATPragmaHelper >> retrievePragma: aSymbol with: aValue inAndBelow: aClass [
	^ self class retrievePragma: aSymbol with: aValue inAndBelow: aClass
]

{ #category : #pragmas }
EDATPragmaHelper >> retrievePragmas: aSymbol inAndBelow: aClass [
	^ self class retrievePragmas: aSymbol inAndBelow: aClass
]

{ #category : #pragmas }
EDATPragmaHelper >> retrievePragmas: aSymbol with: aValue inAndBelow: aClass [
	^ self class retrievePragmas: aSymbol with: aValue inAndBelow: aClass
]
