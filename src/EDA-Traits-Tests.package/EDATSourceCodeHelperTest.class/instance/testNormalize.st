tests
testNormalize
	self assert: (self normalize: 'SKILL_TYPE') equals: 'skill_type'.
	self assert: (self normalize: '   skill_type  ') equals: 'skill_type'.
	self assert: (self normalize: 'SKILL|type') equals: 'skill_type'.
	self assert: (self normalize: 'Skill+Type') equals: 'skill_type'.
	self assert: (self normalize: '+skill-type$') equals: '_skill_type_'