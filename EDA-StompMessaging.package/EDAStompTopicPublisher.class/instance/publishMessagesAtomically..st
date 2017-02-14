API
publishMessagesAtomically: messageCollection
	^ self publishMessages: messageCollection inTransaction: self nextId usingClient: self client withConfig