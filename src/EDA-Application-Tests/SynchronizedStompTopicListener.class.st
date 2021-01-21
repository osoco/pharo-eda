Class {
	#name : #SynchronizedStompTopicListener,
	#superclass : #GHSimpleForwarderProxyHandler,
	#instVars : [
		'eventsReady'
	],
	#category : 'EDA-Application-Tests'
}

{ #category : #API }
SynchronizedStompTopicListener class >> wrap: aListener [
	^ GHTargetBasedProxy createProxyFor: aListener handler: SynchronizedStompTopicListener new
]

{ #category : #accessing }
SynchronizedStompTopicListener >> eventsReady [
	eventsReady == nil
		ifTrue: [ self eventsReady: false ].
	^ eventsReady
]

{ #category : #accessing }
SynchronizedStompTopicListener >> eventsReady: aFlag [
	eventsReady := aFlag.
	^ self
]

{ #category : #logic }
SynchronizedStompTopicListener >> handleOnMessageDo: ctx [
	| proc |
	proc := [ 
		[ self eventsReady ]
		whileFalse: [ 
			Transcript
				print: 'Waiting 1.5s';
				cr;
				flush.
			(Delay forMilliseconds: 1500) wait ].
		super manageMessage: ctx
	] newProcess.
	proc priority: Processor systemBackgroundPriority.
	proc resume.
	^ self
]

{ #category : #lifecycle }
SynchronizedStompTopicListener >> methodsMessagesToHandle [
	| result |
	result := super methodsMessagesToHandle.
	result at: #onMessageDo: put: #handleOnMessageDo:.
	result at: #ready put: #eventsReady.
	result at: #ready: put: #eventsReady:.
	^ result
]
