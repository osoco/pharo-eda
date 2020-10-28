*EDA-Domain-GT-Extensions
gtEventSourcingExplanation
	<gtExplanation>
	| show stencil |
	show := GtSlideShow new.
	stencil := GtSlideShowStencil new.
	show
		addSlide: (GtTitleLiveSlide new titleWithFormat: (stencil title: 'Title')).
	show
		addSlide:
			(GtElementLiveSlide new
				element: [ ATSExplanationExamples new
						applicationExplanationOnEventListView  ]).
	show
		addSlide:
			(GtElementLiveSlide new
				element: [ ATSExplanationExamples new
						applicationExplanationOnEventListAndTimelineView ]).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'Embedding a full Class Coder');
				element: [ (GtCoder forClass: Boolean) createInPager maximized ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'Coder with a given method expanded');
				element: [ (GtCoder forMethod: True >> #ifTrue:ifFalse:) createInPager
					"maximized" ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'A Method coder for selected methods');
				element: [ stencil
						methodCoderForMethods:
							{(Boolean >> #not).
							(True >> #not).
							(False >> #not)} ]).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'New method definitions');
				newText:
					'These method definitions must be accepted before they will be compiled.';
				element: [ stencil
						methodCoderForClass: Object
						withSources: {'foo ^ ''foo''' . 'bar ^ ''bar'''} ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'A Class Hierarchy');
				newText: 'Note that diagram is live, so you can click on the classes.';
				element: [ (GtPager
						createWrappedOn:
							(GtInspectorTool
								forObject:
									(GtMondrianDomainExamples new
										classHierarchyFor: Boolean withAllSubclasses)
								viewSelector: #gtLiveFor:)) maximized ]).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'A full Inspector');
				newText: 'This example  shows how to embed a full Inspector on a given object.';
				element: [ (GtInspector createOn: Boolean) maximized ]).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (stencil heading: 'A GtExample');
				newText:
					'The example below shows an address book with multiple categories and contacts.'
						asRopedText;
				element: [ GtExampleLiveSlide new
						method: GtABAddressBookExample >> #contactsAddressBookWithCategories;
						asElement ]).
	show makeArrowsVisible.
	^ show