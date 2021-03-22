meta
declareGroupsIn: spec
	spec
		group: 'core'
			with:
			#(#'EDA-Application' #'EDA-Traits' #'EDA-Tools' #'EDA-Domain' #'EDA-Commands' #'EDA-Events' #'EDA-EventStore' #'EDA-Messaging' #'EDA-SMTP' #'EDA-Projections' #'EDA-Projections-Voyage-Repository' #'EDA-StompMessaging' #'EDA-Voyage-EventStore' #'EDA-Settings' #'EDA-Logging');
		group: 'tests'
			with:
			#(#'EDA-Projections-Tests' #'EDA-Commands-Tests' #'EDA-Domain-Tests' #'EDA-Commands-Tests-Tests' #'EDA-Tools-Tests' #'EDA-Traits-Tests');
		group: 'explainability'
			with: #(#'EDA-Domain-GT-Extensions' #'EDA-FamixMetaModel');
		group: 'default' with: #('core' 'tests');
		group: 'ALL'
			with: #('default' 'explainability')