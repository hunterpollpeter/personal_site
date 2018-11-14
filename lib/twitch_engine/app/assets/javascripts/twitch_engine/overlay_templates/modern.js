let id = 1; // TODO: make this dynamic and url_encode
let topics = ['spotify_currently_playing', 'most_recent_follower'] // TODO: make this dynamic

$(function() {
 // ready
});

function poll_handler(data) {
	spotify_now_playing(data['spotify_currently_playing']);
	most_recent_follower(data['most_recent_follower']);
}

var prev_dur = -1;
function spotify_now_playing(data) {
	if (data === undefined) return;
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

function most_recent_follower(data) {
	$('.follower-image').css("background-image", `url(${data.user_image})`);
	$('#follower-name').html(data.user_name);
	$('#followed-ago').html(data.followed_ago);
}