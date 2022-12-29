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
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Traits'
}

{ #category : #helpers }
EDATErrorHelper classSide >> basename [
	^ Time now yyyyMMddhhmmss24
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
	| errorHandler result context basename dictionary errorDescription fuelContextFileReference |
	errorHandler := (self class environment at: aStrategy asSymbol) new.
	errorHandler class shouldPersistFuel
		ifTrue: [ errorDescription := 'Error processing ' , aCommand greaseString
				, ': ' , anException description greaseString.
			self logErrorMessage: errorDescription.
			context := thisContext clone.
			basename := self class basename.
			fuelContextFileReference := self
				writeFuelContext: context
				named: anException class greaseString
				withBasename: basename.
			self writeCommand: aCommand withBasename: basename.
			self
				notifyError: anException
				withTitle: 'Error processing command ' , aCommand class name , ' for tenant ' , aCommand tenant
				andProcessingMessage: aCommand
				andFuelContext: fuelContextFileReference ].
	errorHandler context: context.
	dictionary := anException extraContextInformationForCommand: aCommand.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException forMessage: aString usingErrorStrategy: aStrategy [
	| errorHandler result context basename dictionary errorDescription fuelContextFileReference |
	errorDescription := 'Error processing ' , aString greaseString , ': '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	dictionary := Dictionary new.
	dictionary at: #message put: aString.
	context := thisContext clone.
	basename := self class basename.
	fuelContextFileReference := self
		writeFuelContext: context
		named: anException class greaseString
		withBasename: basename.
	self writeMessage: aString withBasename: basename.
	self
		notifyError: anException
		withTitle: 'Error processing message'
		andProcessingMessage: aString
		andFuelContext: fuelContextFileReference.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException usingErrorStrategy: aStrategy [
	| errorHandler result context basename errorDescription fuelContextFileReference |
	errorDescription := 'Error detected: '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	basename := DateAndTime now asYYYYmmddHMS.
	context := thisContext clone.
	fuelContextFileReference := self
		writeFuelContext: context
		named: anException class greaseString
		withBasename: basename.
	self
		notifyError: anException
		withTitle: 'Error detected'
		andFuelContext: fuelContextFileReference.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: Dictionary new.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> manageError: anException whenProjectingEvent: anEvent usingErrorStrategy: aStrategy [
	| errorHandler result context basename dictionary errorDescription fuelContextFileReference |
	errorDescription := 'Error projecting ' , anEvent greaseString , ': '
		, anException description greaseString.
	self logErrorMessage: errorDescription.
	context := thisContext clone.
	basename := self class basename.
	fuelContextFileReference := self
		writeFuelContext: context
		named:
			anException class greaseString , '-' , anEvent class greaseString
				, '.txt'
		withBasename: basename.
	self writeEvent: anEvent greaseString withBasename: basename.
	self
		notifyError: anException
		withTitle: 'Error projecting an event'
		andProcessingMessage: anEvent
		andFuelContext: fuelContextFileReference.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	dictionary := Dictionary new.
	dictionary at: #event put: anEvent.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result
]

{ #category : #handling }
EDATErrorHelper >> notifyError: anException withTitle: errorTitle andFuelContext: fuelContextFileReference [
	self notifyError: anException withTitle: errorTitle andProcessingMessage: nil andFuelContext: fuelContextFileReference 
]

{ #category : #handling }
EDATErrorHelper >> notifyError: anException withTitle: errorTitle andProcessingMessage: aMessage andFuelContext: fuelContextFileReference [
	| fileName webhookUrl1 webhookUrl2 webhookUrl3 webhookUrl4 webhookUrl materializationScript |

	webhookUrl1 := 'https://discord.com/'.
	webhookUrl2 := 'api/webhooks/'.
	webhookUrl3 := '1058006738550390825/'.
	webhookUrl4 := 'iggQlr29Oo7z8EcS40bWRETr1fv8yXrgj2oHSBWL_PqAnnDRzVQVrT1hP798yUdgBfEi'.
	webhookUrl := webhookUrl1 , webhookUrl2 , webhookUrl3 , webhookUrl4.
	fileName := 'contestia-core-context-' , DateAndTime now asYYYYmmddHMS , '.fuel'.
	materializationScript := '(EDAFuelHelper new 
    readFuelFromFileNamed: ''' , fileName
		,
			''' asFileReference) 
        debug'.
	DSWebhookClient new
		url: webhookUrl;
		username: 'Contestia Core';
		avatarUrl: 'https://contestia.es/assets/img/logo-negativo.svg';
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
EDATErrorHelper >> writeEvent: aString withBasename: aBasename [
	| result |
	result := (self class errorFolderFor: aBasename) / 'event.txt'.
	result writeStream
		nextPutAll: aString;
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
