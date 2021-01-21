Extension { #name : #TStampFrameWithBody }

{ #category : #'*EDA-StompMessaging' }
TStampFrameWithBody >> contentType [
	^ self headerAt: #'content-type' ifAbsent: [ self headerAt: #'Content-Type' ifAbsent: [ 'application/json' ]]
]

{ #category : #'*EDA-StompMessaging' }
TStampFrameWithBody >> text: string [
	self
		contentType: 'application/json';
		body: string
]
