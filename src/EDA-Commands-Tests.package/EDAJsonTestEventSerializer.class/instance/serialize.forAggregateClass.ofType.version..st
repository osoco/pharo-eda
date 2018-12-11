initialization
serialize: anEvent forAggregateClass: aggregateClass ofType: eventType version: aVersion
	| result |
	result := WriteStream with: String new.
	result nextPutAll:'{ "meta": { "id": "<ANYTHING>", "aggregate": "';
	nextPutAll: aggregateClass;
	nextPutAll: '", "type": "';
	nextPutAll: eventType;
	nextPutAll: '", "version": "';
	nextPutAll: '", "correlationId": "<ANYTHING>" }, "body": ';
	nextPutAll: (super serialize: anEvent);
	nextPut: $}.
	^ result contents