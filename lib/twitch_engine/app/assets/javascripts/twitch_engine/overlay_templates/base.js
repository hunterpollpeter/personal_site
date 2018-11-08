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