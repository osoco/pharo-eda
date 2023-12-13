"
Class:

I'm a trait that writes to disk the context in which an error has been detected, so it can be easily inspected and debugged offline. Not all errors are affected. Error strategies use this trait.

Responsibility:

When this trait is used in a class, the class can save to disk the error context.

Collaborators:

It delegates error handling to error strategy implementations.
It uses EDATLogging and EDASourceCodeHelperStub.

Public API and Key Messages:

- manageError:forCommand:usingErrorStrategy: When a command-related error is captured, it delegates the error handling to the error strategy.
- manageError:forMessage:usingErrorStrategy: When an arbitrary message cannot be processed, it delegates the error handling to the error strategy.
- manageError:whenProjectingEvent:usingErrorStrategy:: When a projection-related error is captured, it delegates the error handling to the error strategy.
"
Trait {
	#name : #EDATErrorHelper,
	#traits : 'EDATLogging',
	#category : #'EDA-Traits'
}

{ #category : #helpers }
EDATErrorHelper classSide >> basename [
	^ DateAndTime now asYYYYmmddHMS
]

{ #category : #helpers }
EDATErrorHelper classSide >> errorFolderFor: basename [
	| parent result |
	parent := FileSystem workingDirectory / 'errors'.
	parent createDirectory.
	result := parent / basename greaseString.
	result createDirectory.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException forCommand: aCommand usingErrorStrategy: aStrategy [
	| errorHandler extraContextInformationDict errorDescription |
	errorDescription := 'Error processing ' , aCommand greaseString
		, ': ' , anException description greaseString.
	self logErrorMessage: errorDescription.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: thisContext clone.
	extraContextInformationDict := anException
		extraContextInformationForCommand: aCommand.
	^ errorHandler
		handleError: anException
		withExtraContextInformation: extraContextInformationDict
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException forMessage: aString usingErrorStrategy: aStrategy [
	| errorHandler extraContextInformationDict errorDescription |
	errorDescription := 'Error processing ' , aString greaseString , ': '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: thisContext clone.
	extraContextInformationDict := Dictionary with: #message -> aString.
	^ errorHandler
		handleError: anException
		withExtraContextInformation: extraContextInformationDict
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException usingErrorStrategy: aStrategy [
	| errorHandler errorDescription extraContextInformationDict |
	errorDescription := 'Error detected: '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: thisContext clone.
	extraContextInformationDict := Dictionary empty.
	^ errorHandler
		handleError: anException
		withExtraContextInformation: extraContextInformationDict
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException whenProjectingEvent: anEvent usingErrorStrategy: aStrategy [
	| errorHandler extraContextInformationDict errorDescription |
	errorDescription := 'Error projecting ' , anEvent greaseString , ': '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: thisContext clone.
	extraContextInformationDict := Dictionary with: #event -> anEvent.
	^ errorHandler
		handleError: anException
		withExtraContextInformation: extraContextInformationDict
]

{ #category : #handling }
EDATErrorHelper >> notifyError: anException withTitle: errorTitle andProcessingMessage: aMessage andFuelContext: fuelContextFileReference [
	| fileName materializationScript |

	fileName := 'contestia-core-context-' , DateAndTime now asYYYYmmddHMS , '.fuel'.
	materializationScript := '(EDAFuelHelper new 
    readFuelFromFileNamed: ''' , fileName
		,
			''' asFileReference) 
        debug'.
	EDAErrorNotificationsDiscordConfig createClient
		embedColor: Color red;
		embedTitle: errorTitle;
		embedDescriptionMarkdown: [ :markdown | 
			markdown
				text: 'An exception';
				space;
				bold: anException class greaseString;
				space;
				text: 'detected'.
			aMessage
				ifNotNil: [ markdown space;
					text: 'processing the message:'; cr;
						script: (aMessage asString truncateWithElipsisTo: (DSConstants maxMessageLenght - 400)) language: 'json';
						cr ].
			markdown
				text:
					'Download the attached file and debug it evaluating the following expression in a Pharo image:';
				cr;
				script: materializationScript language: 'Smalltalk' ];
		fileName: fileName
			bytes: (fuelContextFileReference binaryReadStreamDo: [ :in | in contents ]);
		send
]

{ #category : #handling }
EDATErrorHelper >> writeCommand: aCommand withBasename: aBasename [
	| result |
	result := (self class errorFolderFor: aBasename)
		/ (aCommand class printString , '.txt').
	result writeStream
		nextPutAll: aCommand printString;
		close.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> writeEvent: anEvent withBasename: aBasename [
	| result |
	result := (self class errorFolderFor: aBasename) / 'event.txt'.
	result writeStream
		nextPutAll: anEvent printString;
		close.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> writeFuelContext: aContext named: aString withBasename: aBasename [
	| parentFolder contextFileReference |
	parentFolder := self class errorFolderFor: aBasename.
	contextFileReference := EDAFuelHelper new
		writeFuelContext: aContext
		named: 'session.fuel'
		inFolder: parentFolder.
	^ contextFileReference
]

{ #category : #handling }
EDATErrorHelper >> writeMessage: aString withBasename: aBasename [
	| result |
	result := (self class errorFolderFor: aBasename) / 'message.txt'.
	result writeStream
		nextPutAll: aString;
		close.
	^ result
]
