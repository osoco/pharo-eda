Class {
	#name : #EDAApplicationCircuitBreaker,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'circuitBreakerProcess',
		'monitoredResource',
		'checkingPeriod',
		'circuitState',
		'openCircuitBlock',
		'checkResourceBlock',
		'consecutiveResourceCheckFailures',
		'maxConsecutiveResourceCheckFailures',
		'consecutiveResourceCheckSuccesses',
		'minConsecutiveResourceCheckSuccesses',
		'closeCircuitBlock'
	],
	#category : #'EDA-Application'
}

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> checkResourceBlockForApplication: anEDAApplication [
	"Return a one argument block that check if the resouce is healthy. Argument is the monitored resource"
	self subclassResponsibility
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> circuitBreakerName [
	"Return circuit breaker name"
	self subclassResponsibility
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> circuitBreakerProcessName [
	^ self circuitBreakerName , ' Loop'
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> closeCircuitBlockForApplication: anEDAApplication [
	"Return a no argument block that execute the close circuit action when velue it"
	self subclassResponsibility
]

{ #category : #constants }
EDAApplicationCircuitBreaker class >> closedState [
	^ 'closed'
]

{ #category : #'instance creation' }
EDAApplicationCircuitBreaker class >> forEDAApplication: anEDAApplication [
	^ self new
		monitoredResource: (self monitoredResourceForApplication: anEDAApplication);
		checkingPeriod: (self resourceCheckingPeriodForApplication: anEDAApplication);
		checkResourceBlock: (self checkResourceBlockForApplication: anEDAApplication);
		maxConsecutiveResourceCheckFailures: (self maxConsecutiveResourceCheckFailuresForApplication: anEDAApplication);
		minConsecutiveResourceCheckSuccesses: (self minConsecutiveResourceCheckSuccessesForApplication: anEDAApplication);
		openCircuitBlock: (self openCircuitBlockForApplication: anEDAApplication);
		closeCircuitBlock: (self closeCircuitBlockForApplication: anEDAApplication);
		circuitState: self closedState;
		yourself
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> maxConsecutiveResourceCheckFailuresForApplication: anEDAApplication [
	"Return an integer, that is the maximun number of consecutive resource check failures to consider it unhealthy"
	self subclassResponsibility
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> minConsecutiveResourceCheckSuccessesForApplication: anEDAApplication [
	"Return an integer, that is the minimun number of consecutive resource check successes to consider it healthy"
	self subclassResponsibility
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> monitoredResourceForApplication: anEDAApplication [
	"Return application resource to be monitored"
	self subclassResponsibility
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> openCircuitBlockForApplication: anEDAApplication [
	"Return a no argument block that execute the open circuit action when velue it"
	self subclassResponsibility
]

{ #category : #constants }
EDAApplicationCircuitBreaker class >> openedState [
	^ 'opened'
]

{ #category : #'instance variables' }
EDAApplicationCircuitBreaker class >> resourceCheckingPeriodForApplication: anEDAApplication [
	"Return period between resource checkings of the application"
	self subclassResponsibility
]

{ #category : #checking }
EDAApplicationCircuitBreaker >> checkResource [
	| check |
	check := checkResourceBlock value: monitoredResource.
	self logDebugMessage: self class circuitBreakerName , ': Monitored resource check: ' , check greaseString.
	^ check
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> checkResourceBlock: anObject [
	checkResourceBlock := anObject
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> checkingPeriod: aDuration [
	checkingPeriod := aDuration
]

{ #category : #updating }
EDAApplicationCircuitBreaker >> circuitBreakerIsClosed [
	^ circuitState = self class closedState
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> circuitState: aCircuitState [
	self logDebugMessage: self class circuitBreakerName , ': Set state to ', aCircuitState.
	circuitState := aCircuitState.
]

{ #category : #private }
EDAApplicationCircuitBreaker >> closeCircuit [
	self resetConsecutiveResourceCheckSuccesses.
	self circuitState: self class closedState .
	closeCircuitBlock value.
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> closeCircuitBlock: anObject [
	closeCircuitBlock := anObject
]

{ #category : #'circuit breaker process' }
EDAApplicationCircuitBreaker >> createCircuitBreakerProcess [
	^ self createMonitoringLoopTask newProcess
		priority: Processor timingPriority - 1;
		name: self class circuitBreakerProcessName;
		yourself
]

{ #category : #'monitoring loop' }
EDAApplicationCircuitBreaker >> createMonitoringLoopTask [
	^ [ [ self updateCircuit.
	self waitCheckingPeriod ] repeat ]
]

{ #category : #'private - updating' }
EDAApplicationCircuitBreaker >> increaseConsecutiveResourceCheckFailures [
	consecutiveResourceCheckFailures := consecutiveResourceCheckFailures + 1.
	self logDebugMessage: self class circuitBreakerName , ': Increased consecutive resource check failures ' , consecutiveResourceCheckFailures greaseString , '/' , maxConsecutiveResourceCheckFailures greaseString.
]

{ #category : #'private - updating' }
EDAApplicationCircuitBreaker >> increaseConsecutiveResourceCheckSuccesses [
	consecutiveResourceCheckSuccesses := consecutiveResourceCheckSuccesses + 1.
	self logDebugMessage: self class circuitBreakerName , ': Increased consecutive resource check successes: ' , consecutiveResourceCheckSuccesses greaseString , '/' , minConsecutiveResourceCheckSuccesses greaseString.
]

{ #category : #lifecycle }
EDAApplicationCircuitBreaker >> isRunning [
	^ circuitBreakerProcess isNotNil and: [ circuitBreakerProcess isTerminated not ]
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> maxConsecutiveResourceCheckFailures: anInteger [
	maxConsecutiveResourceCheckFailures := anInteger
]

{ #category : #private }
EDAApplicationCircuitBreaker >> maxConsecutiveResourceCheckFailuresAchieved [
	^ consecutiveResourceCheckFailures = maxConsecutiveResourceCheckFailures
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> minConsecutiveResourceCheckSuccesses: anInteger [
	minConsecutiveResourceCheckSuccesses := anInteger
]

{ #category : #private }
EDAApplicationCircuitBreaker >> minConsecutiveResourceCheckSuccessesAchieved [
	^ consecutiveResourceCheckSuccesses = minConsecutiveResourceCheckSuccesses
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> monitoredResource: anObject [
	monitoredResource := anObject
]

{ #category : #private }
EDAApplicationCircuitBreaker >> openCircuit [
	self resetConsecutiveResourceCheckFailures.
	self circuitState: self class openedState.
	openCircuitBlock value
]

{ #category : #accessing }
EDAApplicationCircuitBreaker >> openCircuitBlock: anObject [
	openCircuitBlock := anObject
]

{ #category : #private }
EDAApplicationCircuitBreaker >> resetConsecutiveResourceCheckFailures [
	self logDebugMessage: self class circuitBreakerName , ': Reset consecutive resource check failures'.
	consecutiveResourceCheckFailures := 0
]

{ #category : #private }
EDAApplicationCircuitBreaker >> resetConsecutiveResourceCheckSuccesses [
	self logDebugMessage: self class circuitBreakerName , ': Reset consecutive resource check successes'.
	consecutiveResourceCheckSuccesses := 0
]

{ #category : #lifecycle }
EDAApplicationCircuitBreaker >> start [
	self logDebugMessage: self class circuitBreakerName , ': Starting'.
	self isRunning ifTrue: [ ^ self ].
	
	circuitBreakerProcess := self createCircuitBreakerProcess.
	circuitBreakerProcess resume
]

{ #category : #lifecycle }
EDAApplicationCircuitBreaker >> stop [
	| currentProcess |	
	self logDebugMessage: self class circuitBreakerName , ': Stopping'.
	self isRunning ifFalse: [ ^ self ].
	currentProcess := circuitBreakerProcess.
	circuitBreakerProcess := nil.
	currentProcess terminate.
	self circuitState: self class closedState
]

{ #category : #updating }
EDAApplicationCircuitBreaker >> updateCircuit [
	self logDebugMessage: self class circuitBreakerName , ': Updating circuit breaker status'.
	self circuitBreakerIsClosed
		ifTrue: [ self updateClosedCircuit ]
		ifFalse: [ self updateOpenedCircuit ]
"
	chequear resource
	Si Circuito Cerrado
		Si chequeo fallido
			incrementar número de fallos
			si número de fallos >= número máximo de fallos
				abrir circuito
				resetear número de fallos
	Si circuito abierto
		Si chequeo exitoso
			incrementar número de éxitos
			si número de éxitos >= número mínimo de éxitos
				cerrar circuito
				resetear número de éxitos
"
]

{ #category : #updating }
EDAApplicationCircuitBreaker >> updateClosedCircuit [
	self logDebugMessage: self class circuitBreakerName , ': Updating closed circuit breaker'.
	self checkResource
		ifTrue: [ self resetConsecutiveResourceCheckFailures ]
		ifFalse: [ self increaseConsecutiveResourceCheckFailures.
			self maxConsecutiveResourceCheckFailuresAchieved
				ifTrue: [ self openCircuit ] ]
]

{ #category : #updating }
EDAApplicationCircuitBreaker >> updateOpenedCircuit [
	self logDebugMessage: self class circuitBreakerName , ': Updating opened circuit breaker'.
	self checkResource
		ifFalse: [ self resetConsecutiveResourceCheckSuccesses ]
		ifTrue: [ self increaseConsecutiveResourceCheckSuccesses.
			self minConsecutiveResourceCheckSuccessesAchieved
				ifTrue: [ self closeCircuit ] ]
]

{ #category : #'monitoring loop' }
EDAApplicationCircuitBreaker >> waitCheckingPeriod [
	checkingPeriod wait
]
