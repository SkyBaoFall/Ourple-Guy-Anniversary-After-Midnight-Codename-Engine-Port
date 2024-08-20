var strumAnimPrefix = ["left", "down", "up", "right"];
var notePrefix = ['purple', 'blue', 'green', 'red'];
function onNoteCreation(event) {
    event.cancel();
    var note = event.note;
    note.frames = Paths.getFrames('game/NOTE_assets');
    note.animation.addByPrefix('scroll', notePrefix[event.strumID] + '0', 24);
    note.animation.addByPrefix('hold', notePrefix[event.strumID] + ' hold piece0', 24);
    note.animation.addByPrefix('holdend', notePrefix[event.strumID] + ' hold end0', 24);
    note.antialiasing = true;
    note.scale.set(0.7, 0.7);
}
function onStrumCreation(event) {
    event.cancel();
	var strum = event.strum;
    strum.frames = Paths.getFrames('game/NOTE_assets');
    strum.animation.addByPrefix('static', 'arrow' + strumAnimPrefix[event.strumID % strumAnimPrefix.length].toUpperCase());
    strum.animation.addByPrefix('pressed', strumAnimPrefix[event.strumID % strumAnimPrefix.length] + ' press', 24, false);
    strum.animation.addByPrefix('confirm', strumAnimPrefix[event.strumID % strumAnimPrefix.length] + ' confirm', 24, false);
    strum.antialiasing = true;
    strum.scale.set(0.7, 0.7);
	strum.updateHitbox();
}