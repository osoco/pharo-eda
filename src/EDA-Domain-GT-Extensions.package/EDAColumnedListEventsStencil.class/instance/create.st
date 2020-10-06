api - instantiation
create
	<return: #Object>
| view |
			view := GtPhlowColumnedListView new.
			view
				items: [ events ];
				actionUpdateButtonTooltip: 'Update events list';
				column: 'ID' item: #id;
				column: 'Time' item: #timestamp;
				column: 'Kind' item: #class.
				
			^ view