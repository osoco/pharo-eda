"
Class: EDAEventStompTopicListener 

Used in integration tests, to be able to verify the correctness of the generated events.

Responsibility:

It's a regular EDAStompTopicListener, containing configuration settings used only in tests.
"
Class {
	#name : #EDAEventStompTopicListener,
	#superclass : #EDAStompTopicListener,
	#category : #'EDA-StompMessaging'
}
