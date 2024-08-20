import flixel.math.FlxBasePoint;
import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxTextBorderStyle;

var p1Scale = new FlxBasePoint(1, 1);
var p2Scale = new FlxBasePoint(1, 1);
public var currentHUD:FlxSpriteGroup;
var stars:FlxSpriteGroup;

// so source code doesn't fuck with icon bop.
doIconBop = false;

function postCreate() {
    
    currentHUD = new FlxSpriteGroup();
    add(currentHUD);
    currentHUD.cameras = [camHUD];
    currentHUD.scrollFactor.set();
    healthBar.y -= 20; healthBarBG.y -= 20;
    for (i in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt])
        members.remove(i);

    stars = new FlxSpriteGroup();
    scoreTxt.fieldWidth = FlxG.width;
    scoreTxt.setFormat(Paths.font('DIGILF__.ttf'), 42, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    
    for(i in 0 ... 2) {
        var pizza = new FlxSprite(healthBar.x, healthBar.y).loadGraphic(Paths.image('game/pizza'));
        pizza.updateHitbox();
        pizza.y -= (pizza.height / 2) - 10;
        switch(i){
            case 0: pizza.x -= pizza.width / 2;
            case 1: pizza.x += healthBar.width - pizza.width / 2;
        }
        currentHUD.add(pizza);
    }

    for (i in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt])
        currentHUD.add(i);

    for(i in 0 ... 5) {
        var star = new FlxSprite(healthBar.x + (80 * i) + 40, healthBar.y - 10);
        star.frames = Paths.getFrames('game/star');
        star.animation.addByPrefix('bop','star', 24, false);
        star.animation.addByIndices('still', 'star', [19], "", 30, true);
        star.cameras = [camHUD];
        star.scale.set(0.8,0.8);
        stars.add(star);
    }
    currentHUD.add(stars);
}
function postUpdate(elapsed:Float) {
    updateRatingStuff();
    for (i in 0...2) {
        [p1Scale, p2Scale][i].x = lerp(1, [p1Scale, p2Scale][i].x, FlxMath.bound(1 - (elapsed * 9), 0, 1));
        [iconP1, iconP2][i].scale.set([p1Scale, p2Scale][i].x, [p1Scale, p2Scale][i].x);
        [iconP1, iconP2][i].updateHitbox();
        [iconP1, iconP2][i].offset.set(75, 75);
    }
    scoreTxt.text = StringTools.replace(scoreTxt.text, ':', ':\n');
}

// moved to update because postUpdate runs on PauseSubState, meaning uh `update` isnt called so it will just fling the shit
// down the screen
function update() {
    for (i => spr in [iconP2, iconP1]) {
        spr.x = currentHUD.members[i].getMidpoint().x;
        spr.y = currentHUD.members[i].getMidpoint().y - 10;
    }
    scoreTxt.screenCenter().y -= 260;
}
function beatHit(beat:Int){
    for (i in 0...2) [p1Scale, p2Scale][i].x = 1.2;
    for (i in stars)
        if(misses < 1) {
            if(beat % 4 == 0) {
                i.animation.play("bop", true);
            }
        } else {
            i.animation.play('still', true);
        }
}
function updateRatingStuff(){
    if (misses > 0){
        for (i in 0...5) {
            if (accuracy * 100 > 95) {starCheck(i, 0);}
            else if (accuracy * 100 > 90) {starCheck(i, 5);}
            else if (accuracy * 100 > 80) {starCheck(i, 4);}
            else if (accuracy * 100 > 70) {starCheck(i, 3);}
            else if (accuracy * 100 > 60) {starCheck(i, 2);}
            else if (accuracy * 100 > 50) {starCheck(i, 1);}
        } 
    } else {for (i in 0...5) starCheck(i, 0);}
}
function starCheck(i:Int, cap:Int){
    if (i < cap) {
        if (stars.members[i].color != 0xFFFCDD03) {
            stars.members[i].y -= 20;
            FlxTween.tween(stars.members[i], {y: stars.members[i].y + 20}, 0.25, {ease: FlxEase.sineOut});
        }
        stars.members[i].color = 0xFFFCDD03;
    } else {stars.members[i].color = 0xFFFFFFFF;}
}
var scoreTween:FlxTween;
function onPlayerHit(_) {
    if (_.note.isSustainNote) return;
    scoreTxt.scale.set(1.075, 1.075);
    if (scoreTween != null) scoreTween.cancel();
    scoreTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {onComplete: () -> scoreTween = null});
}