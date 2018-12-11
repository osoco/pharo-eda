Class:

I'm a trait that provides some utility methods related to reflection.

Responsibility:

I inject reflection-related methods in any class that uses me.

Collaborators:

I depend on no one.

Public API and Key Messages

- doesInstance:understand: Checks whether an instance understands a selector.

Internal Representation and Key Implementation Points.

It relies upon Class >> methodDict.
