Class:

I represent a projection: a different data structure created from event information, useful for performance reasons.

Responsibility:

I am in charge of projecting an event, and keeping my data structure correct. From the class side I also can check whether all persisted projections of my own class are synchronized, and can re-synchronize them if necessary.

Collaborators:

- I get notified whenever a new event is emitted, using the built-in Announcement mechanism.
- The EDAApplication instance calls me to ensure my projections are up to date.

Public API and Key Messages

- (class side) projectEvent: Project an event.
- (class side) projectEvents: Projects all recent events from a collection.
- You don't need to create instances, just use EDAProjection setupProjectionUsingEventStore: anEventStore

Internal Representation and Key Implementation Points.

The logic when an event is projected is:

- EDAProjection class>>projectEvent: anEvent
   -> EDAProjection class>>projectEvent: anEvent usingEmitingBlock: [ noop ]
We use this design to reuse the same process regardless of whether we are projecting a newly-emitted event, or we are rebuilding projections from events.  We want to emit new events (not to confuse with projectable events) using  Announcements mechanism. In the latter case, we want to add some additional information to the notifications we emit. The block expects an argument: the announcement instance. Take a look at EDAProjection class >> projectEvent:atIndex:ofTotalCount: to see other ways to call this method.
      -> EDAProjection class>>projectEvent: anEvent usingExistingBlock: aBlock
At this point we retrieve the concrete projection instance based on the event details. We do so using (EDAProjection subclass)>>retrieveProjectionForEvent: aEvent
Once we have the projection,  we look for methods tagged with #projectionForEvents: anEvent class in the current EDAProjection subclass.
For each one of those methods,
         -> EDAProjection delegateEventProjectionOf: anEvent in: aProjection to: projectionMethod andThen: aBlock
This method delegates the event to the annotated method. It's expected to return whether the event has been projected successfully or not. If it was successful, we increment the EDAProjection instance projected events count, and update the timestamp of the most recent projected event. Otherwise, we add the event to a list of unprocessed events.
Then, we save the projection, create the announcement, call the block to do whatever it needs to do with the announcement, and finishes.

Keep in mind that each EDAProjection subclass will include its own design when implementing the pragma-annotated methods.

    Instance Variables
	lastProjectedEvent:		The timestamp of the last projected event
	numProjectedEvents:		The number of projected events
	unprojectedEvents:		The list of unprojected events


    Implementation Points