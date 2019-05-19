baselines
declareGroups: spec
	spec
		group: 'default'
			with:
			#('EDA-Traits' 'EDA-Tools' 'EDA-Domain' 'EDA-EventStore' 'EDA-Messaging' 'EDA-Events' 'EDA-Commands' 'EDA-Logging' 'EDA-Projections' 'EDA-Projections-Voyage-Repository' 'EDA-StompMessaging' #'EDA-Voyage-EventStore' 'EDA-Application' 'EDA-Settings');
		group: 'tests' with: #('EDA-Traits-Tests' 'EDA-Tools-Tests' 'EDA-Domain-Tests' 'EDA-Projections-Tests' 'EDA-Commands-Tests' 'EDA-Commands-Tests-Tests');
		group: 'development' with: #('default' 'tests');
		group: 'full' with: #('development' 'Roassal2' 'GToolkit').
	^ spec