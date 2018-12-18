tests
test_delete_queue
	<script>
	| cleaner |
	cleaner := EDAQueueCleaner new.
	cleaner deleteQueue: 'myqueue@audit'