Class:
I'm the parent class for EDA-based applications.

Responsibilities: 
- I'm in charge of bootstrapping the EDA application.
- I configure the EventStore, the repositories, the projections, the STOMP clients.

Collaborators:
- I use Pharo Settings to know how to access the event store, the projections, the STOMP queues and exchanges.
- I can send Announcements.

Public API and Key Messages

- EDAApplication class >> setup : Bootstraps and sets up the adapters for the Event Store, Projections, STOMP clients.
- EDAApplication class >> start: Starts accepting incoming commands.
- EDAApplication class >> stop: To stop accepting incoming commands.
- EDAApplications are not designed to be instantiated.

Internal Representation and Key Implementation Points.

- There're some settings mapped to EDAApplication. 