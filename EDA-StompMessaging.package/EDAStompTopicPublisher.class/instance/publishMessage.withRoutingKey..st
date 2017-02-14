API
publishMessage: aMessage withRoutingKey: aRoutingKeyString
	^ self publishMessage: aMessage withRoutingKey: aRoutingKeyString usingClient: self client withConfig: self class