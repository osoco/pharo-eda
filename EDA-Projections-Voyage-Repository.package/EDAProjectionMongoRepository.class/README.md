Class:

I make a remote MongoDB database the repository of EDA projections.

Responsibilities:

- I am a  projection repository on top of a MongoDB database.
- I implement the projection repository api.

Collaborators:

- I need information about the remote MongoDB server (host, port, database name, username and password). I get this if you launch SettingBrowser, which retrieves the information from json files under config/ folder.
- I use Voyage to deal with MongoDB operations.

Public API and Key Messages:

- See EDAProjectionVoyageRepository
- Create me with EDAProjectionMongoRepository new, but don't forget to call initBackendRepository after launching SettingBrowser.

Internal Representation and Key Implementation Points.

- I used EDAMongoNoCache in the past, but it disables the default caching mechanism in Voyage, and every "save" operation creates a new document in MongoDB.