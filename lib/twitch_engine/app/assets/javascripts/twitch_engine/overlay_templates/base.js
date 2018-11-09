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
	$.get(`/users/${id}/spotify_currently_playing`)
		.done(function(data) {
			done_function(data)
		})
		.always(function() {
			setTimeout(spotify_currently_playing(id, done_function, timeout), timeout);
		});
}