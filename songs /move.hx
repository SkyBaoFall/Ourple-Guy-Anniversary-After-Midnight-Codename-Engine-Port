import flixel.math.FlxBasePoint;
var camMoveOffset:Float = 5;
var movement = new FlxBasePoint();
function postCreate() FlxG.camera.pixelPerfectRender = true;
function onCameraMove(camMoveEvent) {
    if (camMoveEvent.strumLine != null && camMoveEvent.strumLine?.characters[0] != null) {
        switch (camMoveEvent.strumLine.characters[0].animation.name) {
            case "singLEFT": movement.set(-camMoveOffset, 0);
            case "singDOWN": movement.set(0, camMoveOffset);
            case "singUP": movement.set(0, -camMoveOffset);
            case "singRIGHT": movement.set(camMoveOffset, 0);
            default: movement.set(0,0);
        };
        camMoveEvent.position.x += movement.x;
        camMoveEvent.position.y += movement.y;
    }
}