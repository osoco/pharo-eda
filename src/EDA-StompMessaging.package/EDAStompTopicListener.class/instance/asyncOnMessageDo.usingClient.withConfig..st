lifecycle
asyncOnMessageDo: aBlock usingClient: aClient withConfig: config
	| result |
	result := [ self syncOnMessageDo: aBlock usingClient: aClient withConfig: config ] newProcess.
	result priority: Processor systemBackgroundPriority.
	^ result