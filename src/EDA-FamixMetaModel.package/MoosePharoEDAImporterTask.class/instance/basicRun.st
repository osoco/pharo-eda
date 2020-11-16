running
basicRun
	| importer elements |
	importer := importerClass new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		importingContext:
			(MooseImportingContext new
				importPackage;
				importInheritance;
				importInvocation;
				importAccess;
				mergeClassAndMetaclass;
				doNotImportSubclasses;
				yourself);
		addClasses: self allClasses;
		addClassExtensions: self allClassExtensions;
		run.
		elements := importer importEDAFromSmalltalkModel: model.
		"InstallElementsOperator populates a Moose model with (unary) elements"
	(InstallElementsOperator with: elements on: self model)
		runSelector: runSelector.
	"CandidateListOperator populates a Moose model with (binary) element relations like: methodA invokes methodB"
	candidateOperator
		ifTrue: [ (self candidateClass runOn: self model) runSelector: runSelector ].
	self model sourceLanguage: FAMIXSmalltalkSourceLanguage new.
	^ self model