*EDA-Domain-GT-Extensions
gtViewEventsListFor: aView
	<gtView>
	| events |
	events := self events ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Events';
		priority: 10;
		items: [ events ];
		actionUpdateButtonTooltip: 'Update events list';
		column: 'ID' item: #id;
		column: 'Time' item: #timestamp;
		column: 'Kind' item: #class