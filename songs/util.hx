

var preloadedCharacters:Map<String, Character> = [];
var preloadedIcons:Map<String, FlxSprite> = [];

public function preloadChar(char:Int, name:String, index:Int) {
    if (!preloadedCharacters.exists(name)) {
    // Look for character that alreadly exists
    // Create New Character
        var oldCharacter = strumLines.members[char].characters[0];
        var newCharacter = new Character(oldCharacter.x, oldCharacter.y, name, oldCharacter.isPlayer);
        newCharacter.active = newCharacter.visible = false;
        newCharacter.drawComplex(FlxG.camera); // Push to GPU
        preloadedCharacters.set(name, newCharacter);
    
        //Adjust Camera Offset to Accomedate Stage Offsets
        if(newCharacter.isGF) {
            newCharacter.cameraOffset.x += stage.characterPoses["gf"].camxoffset;
            newCharacter.cameraOffset.y += stage.characterPoses["gf"].camyoffset;
        } else if(newCharacter.playerOffsets){
        newCharacter.cameraOffset.x += stage.characterPoses["boyfriend"].camxoffset;
            newCharacter.cameraOffset.y += stage.characterPoses["boyfriend"].camyoffset;
        } else {
            newCharacter.cameraOffset.x += stage.characterPoses["dad"].camxoffset;
            newCharacter.cameraOffset.y += stage.characterPoses["dad"].camyoffset;
        }
    }
}

public function changeChar(char:Int, name:String, index:Int) {
    // Change Character
    var oldCharacter = strumLines.members[char].characters[0];
    var newCharacter = preloadedCharacters.get(name);
    if (oldCharacter.curCharacter == newCharacter.curCharacter) return;

    insert(members.indexOf(oldCharacter) + index, newCharacter);
    newCharacter.active = newCharacter.visible = true;
    remove(oldCharacter);

    newCharacter.setPosition(oldCharacter.x, oldCharacter.y);
    //newCharacter.playAnim(oldCharacter.animation.name);
    //newCharacter.animation?.curAnim?.curFrame = oldCharacter.animation?.curAnim?.curFrame;
    strumLines.members[char].characters[0] = newCharacter;

    // Change Icon
    if (oldCharacter.isGF) return;
    if (oldCharacter.isPlayer) iconP1.setIcon(newCharacter.getIcon());
    else iconP2.setIcon(newCharacter.getIcon());
}