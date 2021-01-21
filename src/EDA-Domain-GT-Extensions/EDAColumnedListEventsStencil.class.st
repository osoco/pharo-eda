Class {
	#name : #EDAColumnedListEventsStencil,
	#superclass : #BrStencil,
	#instVars : [
		'events'
	],
	#category : 'EDA-Domain-GT-Extensions-Stencils'
}

{ #category : #'instance creation' }
EDAColumnedListEventsStencil class >> on: aCollectionOfEvents [
^ self new events: aCollectionOfEvents 
]

{ #category : #'api - instantiation' }
EDAColumnedListEventsStencil >> create [
	<return: #Object>
| view |
			view := GtPhlowColumnedListView new.
			view
				items: [ events ];
				actionUpdateButtonTooltip: 'Update events list';
				column: 'ID' item: #id;
				column: 'Time' item: #timestamp;
				column: 'Kind' item: #class.
				
			^ view
]

{ #category : #accessing }
EDAColumnedListEventsStencil >> events: anObject [
	events := anObject
]

{ #category : #initialization }
EDAColumnedListEventsStencil >> initialize [
^ super initialize 
]
