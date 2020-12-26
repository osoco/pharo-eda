baselines
declareGroups: spec
	spec
		group: 'core'
			with:
			#('EDA-Traits' 'EDA-Tools' 'EDA-Domain' 'EDA-EventStore' 'EDA-Messaging' 'EDA-Events' 'EDA-Commands' 'EDA-Logging' 'EDA-Projections' 'EDA-Projections-Voyage-Repository' 'EDA-StompMessaging' #'EDA-Voyage-EventStore' 'EDA-Application' 'EDA-Settings' 'EDA-SMTP' 'EDA-Errors' "'EDA-Domain-GT-Extensions'");
		group: 'tests'
			with:
			#('EDA-Traits-Tests' 'EDA-Tools-Tests' 'EDA-Domain-Tests' 'EDA-Projections-Tests' 'EDA-Commands-Tests' 'EDA-Commands-Tests-Tests' 'EDA-Settings-Tests' 'EDA-Application-Tests');
		group: 'default' with: #('core' 'tests');
		group: 'development' with: #('default');
		group: 'full' with: #('development' 'Roassal2').	"'GToolkit'"	
	^ spec
