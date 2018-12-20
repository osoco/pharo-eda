persistence
initBackendRepository
	| result |
	result := VOMemoryRepository new.
	result enableSingleton.
	^ result