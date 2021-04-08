# Event-Driven Architectures in Pharo

PharoEDA is a framework that simplifies developing Event-Driven Architectures [1].
It's also an opinionated framework favoring Domain-Driven Design [2], which means that if you honor some conventions, and the adapters are available, PharoEDA will let you focus in your domain and only in your domain. It works out-of-the-box. Please read on even if your programming language of choice is not Pharo Smalltalk [3].

## How it works out-of-the-box

Before dealing with technical details and configuration settings, let us show what this framework does for you.
Imagine you have your Pharo-EDA microservice up and running. It receives commands, does whatever it needs to do, and
in response, it generates events.
Now imagine that after an Event-Storming session, a new event is identified: *user created*. Your model might already include a *User* aggregate, or maybe not. Anyway, you end up defining a *create user* command which includes the information needed by the *user created* event. That new command needs to be handled by the *User* aggregate.

With PharoEDA, to support this new event and command, you'd need:
- Define the command envelope
```json
{
    'meta': {
        'type': 'CREATE_USER'
    },
    'body': {
        'login': 'me@example.com',
        'password': 'secret'
    }
}
```
- Define a sample event
```json
{
    'meta': {
        'type': USER_CREATED'
    },
    'body': {
        'id': '<ANYTHING>',
        'userId': '<ANYTHING>',
        'login': 'me@example.com',
        'password': 'secret'
    }
}
```
- Write the command and event examples above under the `contracts` folder (the exact locations are not relevant at this point). Don't pay attention to the *<ANYTHING>* values: they're just placeholders used by tests.
- Run `MyDomainGenerator new generateAll`. Here, `MyDomainGenerator` is just a descendant of `EDAGenerator` that deals with the specifics of how to translate a the name of the command into the name of the event and viceversa. Depending on how you name your events and commands, it might need to be customized.
- Implement the logic to handle the new command, which could be as simple as validating the input and generating the event. PharoEDA expects your command-handling code to be annotated in a certain way, so PharoEDA detects it automatically. A naive example would be:
```smalltalk
User >> handleCreateUser: aCommand
    <useAsCommandHandlerFor: #CreateUser>
    self validateCreateUserCommand: aCommand.
    ^ UserCreated withUserId: UUID new greaseString login: aCommand login andPassword: aCommand password
```

That's everything you'd need to do. The beauty of DDD with EventStorming is letting the events guide you while modelling your domain.

Well, you might be suspicious about how the state is managed in the code above. We're not storing the *login* or *password* anywhere in the code.

The reason is that PharoEDA uses Event Sourcing. When a new command is received, it's able to know how to rebuild the correct aggregate based on the events registered so far. Well, more specifically, it's able to identify the aggregate instance, retrieve the past events from the Event Store, and ask the aggregate to deal with them.
In PharoEDA we call that operation "apply an event". Here, we don't use annotations, but naming conventions.
Back to our example, we could think of the following method:
```smalltalk
User >> applyUserCreated: anEvent
    self userId: anEvent userId.
    self login: anEvent login.
    self password: anEvent password
```

However, we don't need to write it ourselves: the generator has written it for us already. Keep in mind the apply methods must be *pure**: they cannot have side effects.

PharoEDA takes care of the heavy-lifting, so you invest your development time in the innermost layer: your domain. This is not a slogan: it's what PharoEDA achieves.

Currently, PharoEDA has adapters for RabbitMQ [4] and MongoDB [5] (through Voyage [6]).

In the above example, PharoEDA will perform this tasks, in sequence:
- It will read the *create user* message from the RabbitMQ.
- Based on the metadata of the message, PharoEDA will find the `CommandConsumer` instance to use.
- That `CommandConsumer` will then parse it into a *CreateUser* instance (generated by the *MyDomainGenerator* above).
- PharoEDA will then /dispatch/ the command. This is done by a dispatcher:
  - It'll find out which aggregate should handle it, and which method to call.
  - It will build a new aggregate instance. In this case, an *User*.
  - Every command provides a criteria to find the specific aggregate expected to handle it. In the case of "create" commands, it provides information about the primary key of the aggregate. Other commands typically use just the `id`.
  - The event store provides the events required to assemble the aggregate instance. In this case, it finds none, since there would not be any events in the event store to apply. In general, it will group the events by id (since aggregates with the same primary key might have been deleted in the past), and ask the aggregate to apply the events found.
- The dispatcher will then ask this apggregate instance to *handle* the command.
- In return, the aggregate could generate one or more events, or throw an error.
- For each one of them, it will store it in the MongoDB-based Event Store.
- It will publish it in a RabbitMQ exchange.
- Some events might be published as announcements, so other parts of the application can perform additional tasks when an event in triggered.

## What you need to know about Domain-Driven Design to use PharoEDA

PharoEDA encourages you to use Domain-Driven Design when developing your application.
Future releases will provide specific tools to enhance your DDD experience.

- [1] <https://en.wikipedia.org/wiki/Event-driven_architecture>
- [2] <https://en.wikipedia.org/wiki/Domain-driven_design>
- [3] <https://pharo.org>
- [4] <https://www.rabbitmq.com/>
- [5] <https://www.mongodb.com/>
- [6] <https://github.com/pharo-nosql/voyage>
