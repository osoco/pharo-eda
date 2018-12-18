API
addBuilder: builder forCommand: key
    "Adds a builder mapping"
	self mapping at: key put: builder