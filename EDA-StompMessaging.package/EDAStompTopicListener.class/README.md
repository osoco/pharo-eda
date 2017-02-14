* Class: EDAStompTopicListener

Manages the details of connecting, subscribing, and unsubscribing, to Stomp queues.

* Responsibility:

Contains the configuration settings used by Stomp clients, and manages basic operations such as subscribing and unsubscribing.

* Collaborators:

Children (not instances) of this class would be configured via the Settings framework .

* Public API and Key Messages

- subscribe:subscribe to a queue.
- unsubscribe: unsubscribe to a queue.
- subscriptionId: the id of the listener.