function postCreate() {
    for (event in PlayState.SONG.events)
        if (event.name == "Change Character") preloadChar(event.params[0], event.params[1], event.params[2]);
}

function onEvent(_) {
    var params:Array = _.event.params;
    if (_.event.name == "Change Character") changeChar(params[0], params[1], params[2]);
}