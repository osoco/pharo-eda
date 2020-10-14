lifecycle
asyncOnMessageDo: aBlock usingClient: aClient withConfig: aConfig
	| result |
	result := [ self syncOnMessageDo: aBlock usingClient: aClient withConfig: aConfig ] newProcess.
	result priority: Processor systemBackgroundPriority.
	^ result