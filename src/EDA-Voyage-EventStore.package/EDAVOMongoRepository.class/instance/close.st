lifecycle
close
	pool sessions do: [ :session | pool ensureDisconnected: session ].
	self mongoUrlResolver reset.