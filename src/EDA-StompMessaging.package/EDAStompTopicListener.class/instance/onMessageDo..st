lifecycle
onMessageDo: aBlock
	self listenerProcess: (self asyncOnMessageDo: aBlock usingClient: self client withConfig: self config).
	self listenerProcess resume.
	^ self listenerProcess