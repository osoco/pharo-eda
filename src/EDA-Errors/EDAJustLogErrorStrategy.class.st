"
Class: EDAJustLoggingProjectionErrorHandlingStrategy

This class represents a concrete strategy when dealing with errors detected when projecting events.

Responsibility:

Any strategy must extend this class and implement #handleError:.

Collaborators:

Any EDAProjector processing events should react upon errors by retrieving the selected strategy and delegating the error to it.
The Settings framework allows the user to review and choose among all defined strategies.

Public API and Key Messages:

- handleError: to deal with the error itself.
- description (class side): to describe the main purpose of the strategy.
"
Class {
	#name : #EDAJustLogErrorStrategy,
	#superclass : #EDAErrorHandlingStrategy,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAJustLogErrorStrategy class >> description [
	^ 'Just log error'
]

{ #category : #accessing }
EDAJustLogErrorStrategy >> description [
	^ 'Just log error'
]

{ #category : #'error handling' }
EDAJustLogErrorStrategy >> doHandleError: anException withExtraContextInformation: anExtraContextInformationDict [
	| event projection |
	event := anExtraContextInformationDict at: #event ifAbsent: nil.
	projection := anExtraContextInformationDict at: #projection ifAbsent: nil.
	projection
		ifNil: [ | projections |
			projections := anExtraContextInformationDict
				at: #projections
				ifAbsent: OrderedCollection new.
			self
				logWarningMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Projection of event ';
								nextPutAll: event greaseString;
								nextPutAll: ' in projections ';
								nextPutAll: projections greaseString;
								nextPutAll: ' failed with error ';
								nextPutAll: anException description ]) ]
		ifNotNil: [ :arg | 
			self
				logWarningMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Projection of event ';
								nextPutAll: event greaseString;
								nextPutAll: ' in projection ';
								nextPutAll: projection greaseString;
								nextPutAll: ' failed with error ';
								nextPutAll: anException description ]) ].
	^ false
]
