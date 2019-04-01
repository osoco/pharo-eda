asserting
shouldRunAfter: anotherGenerator
	^ anotherGenerator ~= EDATestSupportGenerator and: [ anotherGenerator ~= EDADomainTestGenerator ]