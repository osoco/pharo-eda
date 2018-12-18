menu
loadSettings
	self isEnvironmentIntegrationTest
		ifFalse: [ self currentEnvironment: 'integration-tests' "This triggers reloading of SettingBrowser" ]