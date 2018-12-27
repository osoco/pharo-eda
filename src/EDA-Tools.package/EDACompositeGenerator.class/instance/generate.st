api
generate
	self generatorClasses keysAndValuesDo: [ :index :generator | generator generate ] displayingProgress: [ :index :generator | 'Generating ' , generator class greaseString, ' (v', generator version , ')' ]