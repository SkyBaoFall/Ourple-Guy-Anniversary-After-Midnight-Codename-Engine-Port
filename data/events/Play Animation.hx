function onEvent(eventEvent) {
    if (eventEvent.event.name == "Play Animation") {
        for (char in strumLines.members[eventEvent.event.params[1]].characters)
            char.playAnim(eventEvent.event.params[0], true, null);
    }
}