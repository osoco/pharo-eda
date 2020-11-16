accessing
events
	^ self eventPublishings
		collect: [ :eventPublishing | eventPublishing event ]