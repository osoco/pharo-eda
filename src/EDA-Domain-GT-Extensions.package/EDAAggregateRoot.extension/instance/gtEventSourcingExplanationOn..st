*EDA-Domain-GT-Extensions
gtEventSourcingExplanationOn: aView
	<gtView>
	| explanationMethods |
	explanationMethods := (Pragma
		allNamed: #gtExplanation
		from: self class
		to: Object) collect: #method.
		
		
	^ aView explicit
		title: 'Event Sourcing explanation';
		priority: 1;
		stencil: [ self withArgs: #() executeMethod: explanationMethods first ];
		yourself