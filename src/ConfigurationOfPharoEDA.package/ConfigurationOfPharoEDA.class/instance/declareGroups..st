baselines
declareGroups: spec
	spec
		group: 'minimal'
			with:
			#(#'EDA-Application' #'EDA-Traits' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging');
		group: 'tests'
			with: #(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests');
		group: 'default' with: #('minimal' 'tests');
		group: 'full' with: #('default' 'Roassal2' 'GToolkit')