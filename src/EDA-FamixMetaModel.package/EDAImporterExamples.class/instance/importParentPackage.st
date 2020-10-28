importing-filters
importParentPackage
	<gtExample>
	| model parentPackageName |
	parentPackageName := self class package name.
	model := MooseModel new.
	model name: 'Moose Model for package ' , parentPackageName.
	model sourceLanguage: FAMIXSmalltalkSourceLanguage new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		importingContext:
			(MooseImportingContext new
				importPackage;
				importInheritance;
				importAccess;
				mergeClassAndMetaclass;
				doNotImportSubclasses;
				yourself);
		addFromPackagesMatching: [ :e | e name = parentPackageName ];
		run.
	^ model