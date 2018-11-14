$(function() {
	webcam();

	// obs studio code below
	if (window.obsstudio === undefined) return;
	window.obsstudio.getStatus(function (data) {
		poll_update_data();
	});
});

$(window).on('obsStreamingStarting obsStreamingStarted obsRecordingStarting obsRecordingStarted', function() { poll_update_data(); });
$(window).on('obsStreamingStopping obsStreamingStopped obsRecordingStopping obsRecordingStopped', function() { clearTimeout(timeout_handle); });

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
		.catch(function() {
			console.log('here');
			video.classList.add('no-webcam');
		});
	}
}

let timeout = 3000;
var timeout_handle = -1;
function poll_update_data() {
	update_data().always(function() { timeout_handle = setTimeout(poll_update_data, timeout); })
}
function update_data() {
	return $.get(`/users/${id}/overlay_data`, {'topics[]': topics} ).done(function(data) { poll_handler(data) }); // TODO: make this the actual path
}