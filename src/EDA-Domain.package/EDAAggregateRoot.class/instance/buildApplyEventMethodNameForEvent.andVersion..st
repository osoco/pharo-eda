helper
buildApplyEventMethodNameForEvent: eventName andVersion: eventVersion
	^ String streamContents: [ :s | s nextPutAll: 'apply'; nextPutAll: eventName greaseString; nextPut: $v; nextPutAll: eventVersion greaseString; nextPut: $: ]