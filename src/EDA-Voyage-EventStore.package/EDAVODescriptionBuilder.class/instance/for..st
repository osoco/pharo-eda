description building
for: anEventClass
	^ (super for: anEventClass) ifNil: [ anEventClass aggregateRootClass ]