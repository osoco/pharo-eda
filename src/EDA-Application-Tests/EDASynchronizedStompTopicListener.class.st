"
#superclass : #GHSimpleForwarderProxyHandler,
"
Class {
	#name : #EDASynchronizedStompTopicListener,
	#superclass : #Object,
	#instVars : [
		'eventsReady'
	],
	#category : #'EDA-Application-Tests'
}

{ #category : #API }
EDASynchronizedStompTopicListener class >> wrap: aListener [
	"^ GHTargetBasedProxy createProxyFor: aListener handler: SynchronizedStompTopicListener new"
]

{ #category : #accessing }
EDASynchronizedStompTopicListener >> eventsReady [
	eventsReady == nil
		ifTrue: [ self eventsReady: false ].
	^ eventsReady
]

{ #category : #accessing }
EDASynchronizedStompTopicListener >> eventsReady: aFlag [
	eventsReady := aFlag.
	^ self
]

{ #category : #logic }
EDASynchronizedStompTopicListener >> handleOnMessageDo: ctx [
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
EDASynchronizedStompTopicListener >> methodsMessagesToHandle [
	| result |
	result := super methodsMessagesToHandle.
	result at: #onMessageDo: put: #handleOnMessageDo:.
	result at: #ready put: #eventsReady.
	result at: #ready: put: #eventsReady:.
	^ result
]
