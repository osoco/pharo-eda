tests
testToCamelCase
	self assert: (self toCamelCase: 'SKILL_TYPE') equals: 'SkillType'.
	self assert: (self toCamelCase: 'skill_type') equals: 'SkillType'.
	self assert: (self toCamelCase: 'SKILL type') equals: 'SKILLType'.
	self assert: (self toCamelCase: 'SkillType') equals: 'SkillType'