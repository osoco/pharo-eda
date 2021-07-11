Class {
	#name : #EDAMMSpecIteratorCommandHandler,
	#superclass : #EDAMMCommandHandler,
	#instVars : [
		'block'
	],
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'instance creation' }
EDAMMSpecIteratorCommandHandler class >> for: aBlockClosure [
	^ self new block: aBlockClosure; yourself
]

{ #category : #accessing }
EDAMMSpecIteratorCommandHandler >> block [
	^ block
]

{ #category : #accessing }
EDAMMSpecIteratorCommandHandler >> block: aBlock [
	block := aBlock
]

{ #category : #'command handling' }
EDAMMSpecIteratorCommandHandler >> handleCommand: aCommand within: aContext [
	| specs |
	EDAMMSpecReaderCommandHandler new
		handleCommand: aCommand
		within: aContext.
	specs := aContext at: 'specs' ifAbsent: OrderedCollection new.
	specs
		do: [ :spec | self block value: spec value: aCommand value: aContext ].
	^ false
]
