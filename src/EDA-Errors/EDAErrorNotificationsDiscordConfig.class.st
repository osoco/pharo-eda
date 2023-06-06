Class {
	#name : #EDAErrorNotificationsDiscordConfig,
	#superclass : #Object,
	#classInstVars : [
		'webhookUrl',
		'username',
		'avatarUrl'
	],
	#category : #'EDA-Errors-Strategies'
}

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> avatarUrl [
	^ avatarUrl
]

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> avatarUrl: anObject [
	avatarUrl := anObject
]

{ #category : #creating }
EDAErrorNotificationsDiscordConfig class >> createClient [
	^ DSWebhookClient new
		url: webhookUrl;
		username: username;
		avatarUrl: avatarUrl
]

{ #category : #'class initialization' }
EDAErrorNotificationsDiscordConfig class >> initialize [
	self avatarUrl: nil.
	self username: nil.
	self webhookUrl: nil
]

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> username [
	^ username
]

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> username: anObject [
	username := anObject
]

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> webhookUrl [
	^ webhookUrl
]

{ #category : #accessing }
EDAErrorNotificationsDiscordConfig class >> webhookUrl: anObject [
	webhookUrl := anObject
]
