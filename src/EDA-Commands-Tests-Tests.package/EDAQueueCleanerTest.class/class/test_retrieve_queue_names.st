tests
test_retrieve_queue_names
	<script>
	| cleaner queues |
	cleaner := EDAQueueCleaner new.
	queues := cleaner listQueues