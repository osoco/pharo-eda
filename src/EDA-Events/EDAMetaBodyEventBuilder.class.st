Class {
	#name : #EDAMetaBodyEventBuilder,
	#superclass : #EDABuilder,
						andThrow: self errorClass ] ]
	#traits : 'EDATEventBuilder + EDATMetaBodyTypeHelper + EDATPragmaBasedMessageBuilder',
	#classTraits : 'EDATEventBuilder classTrait + EDATMetaBodyTypeHelper classTrait + EDATPragmaBasedMessageBuilder classTrait',
	#category : #'EDA-Events-Builders'
}

{ #category : #meta }
EDAMetaBodyEventBuilder class >> pragmaSymbol [
	^ #eventName:
]
