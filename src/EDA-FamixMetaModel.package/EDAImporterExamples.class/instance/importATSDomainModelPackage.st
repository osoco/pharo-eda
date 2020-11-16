importing-filters
importATSDomainModelPackage
	<gtExample>
	| model parentPackageName |
	parentPackageName := 'ATS-Domain'.
	model := MooseEDAModel new.
	model name: 'Moose Model for package ' , parentPackageName.
	model sourceLanguage: FAMIXSmalltalkSourceLanguage new.
	^ MoosePharoEDAImporterTask new
		importerClass: PharoEDAImporter;
		model: model;
		addFromPackagesMatching: [ :e | e name = parentPackageName ];
		"	^ model"
			run