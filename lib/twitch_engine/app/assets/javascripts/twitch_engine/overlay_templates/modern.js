document.addEventListener("DOMContentLoaded", function() {
	webcam();
	spotify_currently_playing(1, function(data) {
		spotify_element(data);
	}, 3000);
});

var prev_dur = -1;
function spotify_element(data) {
	if (data.not_live) {
		$('#now-playing').addClass('not-live');
		return;
	}
	$('#now-playing').removeClass('not-live');
	let $song_progress = $('#song-progress');
	$('#song-title').html(data.title);
	$('#song-artists').html(data.artists);
	let duration_pct = data.duration_pct;
	if (prev_dur < duration_pct && (duration_pct - prev_dur) < 20) {
		$song_progress.addClass('transition');
	}
	else {
		$song_progress.removeClass('transition');
	}
	$song_progress.width(`${duration_pct}%`);
	prev_dur = data.duration_pct;
	$('.song-image').css("background-image", `url(${data.album_image})`);
	if (data.is_playing) {
		$('#now-playing').animate({	height: 'show' });
	}
	else {
		$('#now-playing').animate({	height: 'hide' });
	}
}