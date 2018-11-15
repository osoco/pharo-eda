test - fixture
injectPragmaIntoTestProjection
	| oldSource newSource selector body |
	oldSource := (EDATestEntityCounterProjection class >> #projectCreatedEvents:) sourceCode.
	selector := oldSource lines first.
	body := oldSource lines allButFirst inject: '' into: [ :text :each | text , each asString ].
	newSource := selector , String cr , 
		'<projectionForEvents: #(ApplicationCreated)>' , String cr , 
		body.
	EDATestEntityCounterProjection class compileSilently: newSource classified: 'event projection'.
