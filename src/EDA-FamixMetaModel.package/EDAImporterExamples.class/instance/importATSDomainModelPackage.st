importing-filters
importATSDomainModelPackage
	<gtExample>
	| model parentPackageName |
	parentPackageName := 'ATS-Domain'.
	model := MooseModel new.
	model name: 'Moose Model for package ' , parentPackageName.
	model sourceLanguage: FAMIXSmalltalkSourceLanguage new.
	MoosePharoImporterTask new
		importerClass: PharoEDAImporter;
		model: model;
		importingContext:
			(MooseImportingContext new
				importPackage;
				importInheritance;
				importAccess;
				importAggregate;
				mergeClassAndMetaclass;
				doNotImportSubclasses;
				yourself);
		addFromPackagesMatching: [ :e | e name = parentPackageName ];
		run.
	^ model