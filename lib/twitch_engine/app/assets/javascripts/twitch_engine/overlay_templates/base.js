var is_live = false;

$(window).on('obsStreamingStarting obsStreamingStarted obsRecordingStarting obsRecordingStarted', function() { is_live = true; });
$(window).on('obsStreamingStopping obsStreamingStopped obsRecordingStopping obsRecordingStopped', function() { is_live = false; });

function webcam() {
	var video = document.querySelector('#webcam');

	if (navigator.mediaDevices.getUserMedia) {
		navigator.mediaDevices.getUserMedia({
			video: {
				width: { ideal: 640 },
				height: { ideal: 360 }
			}
		})
		.then(function(stream) {
			video.srcObject = stream;
		})
		.catch(function(err0r) {
			console.log(err0r);
		});
	}
}

function spotify_currently_playing(id, done_function, timeout) {
	setInterval(function () {
		if (is_live) {
			$.get(`/users/${id}/spotify_currently_playing`).done(function(data) { done_function(data) });
		}
		else {
			done_function({ not_live: true })
		}
	}, timeout);
}