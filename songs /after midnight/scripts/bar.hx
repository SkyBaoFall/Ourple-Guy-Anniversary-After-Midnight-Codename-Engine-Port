import sys.FileSystem;
//import backend.CrossUtil;
import flixel.addons.display.FlxBackdrop;
//import flixel.math.FlxPoint;
//import substates.GameOverSubstate;

//bg1
var bg;
var front;
var sparkles;
var rainback;
var rain;
var trees;
var spotlight1;
var spotlight2;

//bg2
var backbg;
var skyback;
var gradient;

//bg3
var bar;
var outside;
var door;
var lime;
var cup;
var brookesit;
var legs;

//brooke walking segment
var brookewalking;
var skywalk;
var hill;
var leaves;
var bush1;
var bush2;
var tree1;
var tree2;
var treesback;
var endingScene;
var finalPortrait;
var grace;

//misc
var blackScreen;
var ongoing:Bool = false;
var fakeCam:FlxCamera;
var isEndingCut:Bool = true;
var allowMoveCam:Bool = true;
//tweaking
var twkBg;
var scenes:Array<FlxSprite> = [];

var vhsShader; //did not work lol

function create() {
    FlxG.camera.zoom = 5;
    //brooke walking
    skywalk = new FlxSprite(0, -1300).loadGraphic(Paths.image('bgs/walking/sky'));
    skywalk.scale.set(1.5, 1.5);
    add(skywalk);

    grace = new Character(skywalk.getMidpoint().x + 500, skywalk.getMidpoint().y - 400, 'gracesky');
    grace.alpha = 0.45;
    add(grace);

    hill = new FlxSprite(600, -100).loadGraphic(Paths.image('bgs/walking/hill'));
    hill.y += 450;
    hill.scale.x = 3;
    add(hill);

    treesback = new FlxBackdrop(Paths.image('bgs/walking/treesback'), 0x01, 0);
    treesback.y += 240;
    add(treesback);

    leaves = new FlxBackdrop(Paths.image('bgs/walking/leaves'), 0x01, 0);
    leaves.y += 240;
    add(leaves);

    tree1 = new FlxBackdrop(Paths.image('bgs/walking/tree1'), 0x01, 0);
        add(tree1);

        tree2 = new FlxBackdrop(Paths.image('bgs/walking/tree2'), 0x01, 0);
        tree1.y += 300;
        tree2.y += 300;
        add(tree2);

        brookewalking = new FlxSprite(700, 1000);
        brookewalking.frames = Paths.getFrames('bgs/walking/brookewalking');
        brookewalking.animation.addByPrefix('walk','frame', 6);
        brookewalking.animation.play('walk', true);
        add(brookewalking);

        bush1 = new FlxBackdrop(Paths.image('bgs/walking/bush1'), 0x01, 1500);
        bush1.x -= 1550;
        add(bush1);

        bush2 = new FlxBackdrop(Paths.image('bgs/walking/bush2'), 0x01, 700);
        bush2.x += 1550;
        bush1.y += 400;
        bush2.y += 400;
        add(bush2);

        endingScene = new FlxSprite(0, 0);
        endingScene.frames = Paths.getFrames('bgs/walking/ending');
        endingScene.animation.addByPrefix('idle','brookeending', 4, true);
        endingScene.animation.addByPrefix('house','house', 4, true);
        endingScene.animation.play('idle', true);
        endingScene.cameras = [camHUD];
        endingScene.alpha = 0;
        add(endingScene);

        finalPortrait = new FlxSprite(600, -100).loadGraphic(Paths.image('bgs/walking/portrait'));
        finalPortrait.cameras = [camHUD];
        finalPortrait.alpha = 0;
        add(finalPortrait);

        //bg3
        outside = new FlxSprite(100, 90).loadGraphic(Paths.image('bgs/inside/outside'));
        outside.scrollFactor.set(0.7, 0.7);
        add(outside);
        outside.antialiasing = false;

        bar = new FlxSprite(0, 80).loadGraphic(Paths.image('bgs/inside/bar'));
        add(bar);
        bar.antialiasing = false;

        lime = new Character(240, 167 + 80, 'lime');
        lime.playAnim('clean', true);
       // lime.specialAnim = true;
        add(lime);

        cup = new FlxSprite(59, 158 + 80);
        cup.frames = Paths.getFrames('bgs/inside/cup');
        cup.animation.addByPrefix('bye','byecup', 12, false);
        cup.animation.play('bye', true);
        cup.visible = false;
        cup.animation.finishCallback = (s)->{
            if (cup.visible)
                cup.kill();
        };
        lime.animation.callback = (name, frameNum, frameIndex)->{
            if (name == 'bye' && frameNum == 4){
                cup.animation.play('bye', true);
                cup.visible = true;
            }
        };
        add(cup);

        legs = new FlxSprite(59, 158 + 80);
        legs.frames = Paths.getFrames('bgs/inside/legs');
        legs.animation.addByPrefix('walk','walk', 18, true);
        legs.animation.play('walk', true);
        legs.visible = false;
        add(legs);

        brookesit = new FlxSprite(472, 226 + 80);
        brookesit.frames = Paths.getFrames('bgs/inside/sitbrooke');
        brookesit.animation.addByPrefix('sit','sit', 4, true);
        brookesit.animation.addByPrefix('drinksit','drinksit', 4, true);
        brookesit.animation.addByPrefix('drinking','drinking', 4, true);
        brookesit.animation.play('sit', true);
        brookesit.visible = false;
        add(brookesit);

        door = new FlxSprite(0, 80).loadGraphic(Paths.image('bgs/inside/door'));
        add(door);
        door.antialiasing = false;

        //tweak
        twkBg = new FlxSprite(0, 80).loadGraphic(Paths.image('bgs/tweaking/bg1'));
        add(twkBg);
        twkBg.antialiasing = false;
        twkBg.visible = false;

        //bg2
        skyback = new FlxSprite(50, 100).loadGraphic(Paths.image('bgs/behind/bg'));
        skyback.scrollFactor.set(0.7, 0.7);
        add(skyback);
        skyback.antialiasing = false;

        backbg = new FlxSprite(60, 150).loadGraphic(Paths.image('bgs/behind/bg1'));
        backbg.scale.set(1.5, 1.5);
        add(backbg);
        backbg.antialiasing = false;

        gradient = new FlxSprite(60, 150).loadGraphic(Paths.image('bgs/behind/gradient'));
        gradient.scale.set(1.5, 1.5);
        add(gradient);
        gradient.antialiasing = false;

        //bg1
        bg = new FlxSprite(0, 0).loadGraphic(Paths.image('bgs/back'));
        bg.scale.set(1.2, 1.2);
        bg.scrollFactor.set(0.7, 0.7);
        bg.updateHitbox();
        add(bg);
        bg.antialiasing = false;
        
        front = new FlxSprite(0, 0).loadGraphic(Paths.image('bgs/front'));
        front.scale.set(1.2, 1.2);
        front.updateHitbox();
        add(front);
        front.antialiasing = false;

        sparkles = new FlxSprite(206 - 50, 273 - 50);
        sparkles.frames = Paths.getFrames('bgs/sparkle');
        sparkles.animation.addByPrefix('sparkle','sparkle',30);
        sparkles.animation.play('sparkle', true);
        sparkles.visible = false;
        

        rainback = new FlxSprite(front.x + front.width * 0.5 - 350, 60);
        rainback.frames = Paths.getFrames('bgs/rain');
        rainback.animation.addByPrefix('rain','rain',30);
        rainback.animation.play('rain', true);
        rainback.scale.set(1.25, 1.25);
        rainback.updateHitbox();
        rainback.alpha = 0;
        rainback.blend = 0;
        add(rainback);

        blackScreen = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackScreen.scrollFactor.set();

        spotlight1 = new FlxSprite(145, -15).loadGraphic(Paths.image('bgs/spotlight'));
        spotlight1.blend = 0;
        spotlight1.updateHitbox();
        spotlight1.antialiasing = false;

        spotlight2 = new FlxSprite(464, -15).loadGraphic(Paths.image('bgs/spotlight'));
        spotlight2.blend = 0;
        spotlight2.updateHitbox();
        spotlight1.alpha = 0;
        spotlight2.alpha = 0.3;
        spotlight2.visible = false;
        spotlight2.antialiasing = false;

        trees = new FlxSprite(-100, 0).loadGraphic(Paths.image('bgs/trees'));
        trees.scale.set(1.25, 1.25);
        trees.scrollFactor.set(1.4, 1.4);
        trees.updateHitbox();
        trees.alpha = 0;
        add(trees);
        trees.antialiasing = false;

        rain = new FlxSprite(front.x + front.width * 0.5 - 500, 60);
        rain.frames = Paths.getFrames('bgs/rain');
        rain.animation.addByPrefix('rain','rain',30);
        rain.animation.play('rain', true);
        rain.scale.set(1.5, 1.5);
        rain.updateHitbox();
        rain.alpha = 0;
        rain.blend = 0;
        rain.scrollFactor.set(1.3, 1.3);
        
        //FlxG.camera.filtersEnabled = false;

        
    }
    
    function postCreate() {
        FlxG.camera.zoom = 5;
        maxCamZoom *= 6;
        camHUD.alpha = 0;
        for (i in [dad, boyfriend, gf]) {
            members.remove(i);
        }
        add(gf);
        
        add(dad);
        add(sparkles);
        add(boyfriend);
        add(rain);
        add(blackScreen);
        add(spotlight1);
        add(spotlight2);
        dad.alpha = 0;

        var fpsArray:Array<Int> = [12,12,24,12,24,12,12,10,10,14];
        for (i in 0...10){
            var spr = new FlxSprite(0, 80);
            spr.frames = Paths.getFrames('bgs/tweaking/scene' + (i+1));
            spr.animation.addByPrefix('scene','i', fpsArray[i], false);
            spr.animation.play('scene', true);
            spr.visible = false;
            scenes.push(spr);
            add(spr);
            
        };
        
        //CrossUtil.insertFlxCamera(1,fakeCam);
        FlxG.cameras.add(fakeCam = new FlxCamera(), false);
        fakeCam.bgColor = 0x0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.add(camHUD, false);
        //boyfriend.cameras = [fakeCam];
    }
    
    var panelOn:Bool = false;
    var flicker:Bool = false;
    var limesection:Bool = false;
function getSecondTimeFromBeat(beat) {
        var ti = Conductor.crochet * (beat - 1);
        var real = (Conductor.crochet * beat - ti) / 1000;
        return real;
}
var lossHealth:Bool = true;
function onPlayerMiss(_) if (!lossHealth) _.healthGain = 0;
function onEvent(_) {
    var e = _.event;
    var name = e.name;
    var params = e.params;
    if (name == 'brookecam'){
            boyfriend.animation.callback = null;
            moveCam(false);
            for (i in [rain, rainback, gradient, backbg, skyback, boyfriend, dad, gf, sparkles, outside, lime, door, bar, legs, blackScreen, brookesit, twkBg]){
                i.kill();
            }
            allowMoveCam = false;
            camFollow.setPosition(brookewalking.getMidpoint().x, brookewalking.getMidpoint().y - 200);
            FlxG.camera.snapToTarget();
            defaultCamZoom = 0.7;
            isEndingCut = true;
            treesback.velocity.x = 40;
            leaves.velocity.x = 40;
            tree1.velocity.x = 90;
            tree2.velocity.x = 90;
            bush1.velocity.x = 250;
            bush2.velocity.x = 250;
            for (i in currentHUD) FlxTween.tween(i, {alpha: 0}, 2, {ease: FlxEase.sineOut});
        }
    if (name == 'endingoff'){
            if (params[0] == 1){
                FlxTween.tween(camGame, {alpha: 0}, 1, {ease: FlxEase.sineOut});
                FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween){
                    FlxTween.tween(endingScene, {alpha: 1}, 4, {ease: FlxEase.sineOut});
                }});
                endingScene.screenCenter();
                endingScene.animation.play('idle', true);
            }
            if (params[0] == 2){
                endingScene.animation.play('house', true);
            }
            if (params[0] == 3){
                FlxTween.tween(endingScene, {alpha: 0}, 6, {ease: FlxEase.sineOut});
            }
            if (params[0] == 4){
                finalPortrait.screenCenter();
                finalPortrait.scale.set(0.7, 0.7);
                FlxTween.tween(finalPortrait, {alpha: 1}, 5, {ease: FlxEase.sineOut});
            }
            if (params[0] == 5){
                finalPortrait.screenCenter();
                FlxTween.tween(finalPortrait, {alpha: 0}, 2, {ease: FlxEase.sineOut});
            }
        }
        if (name == 'limesection'){
            limesection = !limesection;
            
            if (!limesection) {
                moveCam(limesection);
                defaultCamZoom = 2.5;
            } else defaultCamZoom = 2.7;
        }
        if (name == 'Change Character' && params[1] == 'brookehand'){
            lossHealth = false;
            
            blackScreen.alpha = 0;
            members.remove(blackScreen);
            insert(members.indexOf(sparkles)+1, blackScreen);
            members.remove(boyfriend);
            boyfriend.setPosition(bar.getMidpoint().x - boyfriend.width/2, bar.getMidpoint().y - boyfriend.height/2 + 200);
            FlxTween.tween(boyfriend, {y: boyfriend.y - 200}, 0.1, {ease: FlxEase.expoOut});
            boyfriend.visible = true;
            boyfriend.playAnim('shootup');
            boyfriend.animation.finishCallback = (s)->{
                if (s == 'shootup'){
                    boyfriend.playAnim('shootdown', true);
                }
                if (s == 'teleport'){
                    boyfriend.kill();
                }
            };
            boyfriend.animation.callback = (s,n,i)->{
                if (s == 'shootup' || s == 'blink' || s == 'teleport'){
                    vocals.volume = 1;
                }
            };
            insert(members.indexOf(blackScreen)+1, boyfriend);
            defaultCamZoom = 2.6;
            FlxG.camera.zoom = 2.6;
            boyfriend.animation.callback = (s,n,i)->{
                if (!panelOn)
                moveCam(true, boyfriend);
            };
            FlxTween.tween(blackScreen, {alpha: 1}, 0.6, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                twkBg.setPosition(boyfriend.getMidpoint().x - twkBg.width/2,boyfriend.getMidpoint().y - twkBg.height/2);
                twkBg.visible = true;
                dad.kill();
                sparkles.kill();
                gf.kill();
                FlxTween.tween(blackScreen, {alpha: 0}, 0.6, {ease: FlxEase.quadOut});
            }});
            moveCam(true, boyfriend);
            FlxG.camera.snapToTarget();
            for (i => spr in currentHUD.members) {
                if (i < 2)
                    FlxTween.tween(spr, {alpha: 0}, 3, {ease: FlxEase.sineIn});
                if (i > 3 && i < 7)
                    FlxTween.tween(spr, {alpha: 0}, 3, {ease: FlxEase.sineIn});
            }
            for (i in cpuStrums) {
                FlxTween.tween(i, {alpha: 0}, 3, {ease: FlxEase.sineIn, onComplete: () -> {
                    for (i in cpuStrums) i.x = -9999;
                }});
            }
        }
    if (name == 'drinksit'){
        brookesit.animation.play('drinksit', true);
        brookesit.offset.x = -5;
    }
    if (name == 'drinking') brookesit.animation.play('drinking', true);
    if (name == 'insidebar'){
        for (i in [skyback, backbg, gradient]) i.visible = false;
        allowMoveCam = true;
        defaultCamZoom = 2.1;
        members.remove(rainback);
        insert(members.indexOf(outside)+1, rainback);
        members.remove(rain);
        insert(members.indexOf(rainback)+1, rain);
        rainback.scrollFactor.set(0.85, 0.85);
        rain.scrollFactor.set(0.9, 0.9);
        rain.setPosition(outside.getMidpoint().x - rain.width/2, outside.getMidpoint().y - rain.height/2);
        rainback.setPosition(outside.getMidpoint().x - rainback.width/2, outside.getMidpoint().y - rainback.height/2);
        FlxG.camera.snapToTarget();
        FlxG.camera.angle = 0;
        boyfriend.alpha = 1;
        dad.alpha = 1;
        gf.alpha = 1;
        FlxTween.tween(FlxG.camera, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut});
        moveCam(true);
    }
    if (name == 'limebye') lime.playAnim('bye', true);
    if (name == 'midnCam'){
        ongoing = true;
        allowMoveCam = false;
        FlxTween.tween(FlxG.camera, {zoom: 2.2}, 1.85, {ease: FlxEase.sineInOut, onComplete: () -> ongoing = false});
        FlxTween.tween(camFollow, {x: 415, y: 280}, 1.7, {ease: FlxEase.cubeIn});
    }
    if (name == 'camend'){
        allowMoveCam = true;
        defaultCamZoom = 2.5;
    }
    if (name == 'bgchange'){
        FlxG.sound.play(Paths.sound('spin'), 0.4);
        FlxTween.tween(FlxG.camera.flashSprite, {scaleX: -1}, getSecondTimeFromBeat(Conductor.curBeat)/2, {type: 4, ease: FlxEase.cubeInOut, onComplete: (tw)->{
            if (tw.executions == 4) {
                tw.cancel();
            }
        }});
        new FlxTimer().start(getSecondTimeFromBeat(Conductor.curBeat), () -> {for (i in [trees, front, bg]) i.visible = false;});
    }
    if (name == 'insidetrans'){
        defaultCamZoom = 1.3;
        ongoing = true;
        FlxTween.tween(FlxG.camera, {zoom: 15, alpha: 0, angle: 360 * 3}, 0.8, {ease: FlxEase.sineIn, onComplete: function (twn:FlxTween) {
                ongoing = false;
                defaultCamZoom = 2.5;
            }
        });
        FlxTween.tween(boyfriend, {x: boyfriend.x + 100, alpha: 0}, 0.7, {ease: FlxEase.quartInOut});
        FlxTween.tween(gf, {x: gf.x + 100, alpha: 0}, 0.7, {ease: FlxEase.quartInOut});
        FlxTween.tween(dad, {x: dad.x - 100, alpha: 0}, 0.7, {ease: FlxEase.quartInOut});
    }
    if (name == 'Play Animation' && params[0] == 'ball' && params[1] == 1) {
        legs.kill();
        FlxTween.tween(boyfriend, {y: 156 + 80}, 0.3, {ease: FlxEase.expoOut, onComplete: function(twn){
            FlxTween.tween(boyfriend, {y: 206 + 80}, 0.2, {ease: FlxEase.quadIn, startDelay: 0.05});
        }});
        FlxTween.tween(boyfriend, {x: 470}, 0.6, {ease: FlxEase.quadOut, onComplete: function(twn){
            boyfriend.visible = false;
            brookesit.visible = true;
            brookesit.scale.set(1.1,0.9);
            FlxTween.tween(brookesit.scale, {x: 1, y: 1},0.1);
        }});
    }
    if (name == 'Play Animation' && params[0] == 'ball' && params[1] == 2) {
        legs.kill();
        FlxTween.tween(gf, {y: 156 + 80}, 0.3, {ease: FlxEase.expoOut, onComplete: function(twn){
            FlxTween.tween(gf, {y: 198 + 80}, 0.2, {ease: FlxEase.quadIn, startDelay: 0.05});
        }});
        FlxTween.tween(gf, {x: 586}, 0.6, {ease: FlxEase.quadOut, onComplete: function(twn){
            gf.playAnim('sit', true);
            gf.setPosition(567, 192 + 80);
            gf.scale.set(1.1,0.9);
            FlxTween.tween(gf.scale, {x: 1, y: 1},0.1);
        }});
    }
    if (name == 'Change Character' && params[1] == 'prangesneak'){
        dad.setPosition(-81, 165 + 80);
        dad.animation.callback = (s)->{sparkles.setPosition(dad.getMidpoint().x - sparkles.width/2, dad.getMidpoint().y - sparkles.height/2);};
        sparkles.scale.set(1, 1);
        FlxTween.tween(dad, {x: dad.x + 212}, 13);
        dad.cameras = [FlxG.camera];
        sparkles.cameras = [FlxG.camera];
    }
    if (name == 'Change Character' && params[1] == 'bfwalk'){
        boyfriend.setPosition(637 + 100, 245 + 80);
        FlxTween.tween(boyfriend, {x: boyfriend.x - 200}, 13);
        members.remove(legs);
        insert(members.indexOf(gf)+1, legs);
        legs.visible = true;
        boyfriend.cameras = [FlxG.camera];
    }
    if (name == 'Change Character' && params[1] == 'gfwalk'){
        gf.setPosition(691 + 50, 216 + 80);
        FlxTween.tween(gf, {x: gf.x - 110}, 13);
        gf.cameras = [FlxG.camera];
    }
    if (name == 'spotlight'){
        spotlight1.alpha = 0.8;
        blackScreen.alpha = 0.8;
        FlxTween.tween(spotlight1, {alpha: 0.3}, 1, {ease: FlxEase.sineOut});
        FlxTween.tween(blackScreen, {alpha: 0.4}, 1, {ease: FlxEase.sineOut});
    }
    if (name == 'end'){
        members.remove(spotlight1);
        members.remove(spotlight2);
        members.remove(blackScreen);
    }
    if (name == 'flicker'){
        flicker = !flicker;
        spotlight2.visible = flicker;
    }
    if (name == 'Camera Follow Pos'){
        allowMoveCam = true;
        defaultCamZoom = 2.5;
    }
    if (name == 'Change Character' && params[1] == 'gracethink'){
        gf.cameras = [fakeCam];
        gf.setPosition(340,100 + 500);
        FlxTween.tween(gf, {y: 210}, 1, {ease: FlxEase.quartInOut});
    }
    if (name == 'Change Character' && params[1] == 'prangethink'){
        ongoing = true;
        FlxTween.tween(FlxG.camera, {zoom: 1.6}, 1, {ease: FlxEase.quartInOut, onComplete: function (twn:FlxTween) {
                ongoing = false;
                defaultCamZoom = 1.6;
            }
        });
        allowMoveCam = false;
        camFollow.setPosition(backbg.getMidpoint().x, backbg.getMidpoint().y);
        FlxG.camera.snapToTarget();
        dad.cameras = [fakeCam];
        sparkles.cameras = [fakeCam];
        sparkles.scale.set(1.5, 1.5);
        sparkles.x -= 100;
        dad.setPosition(-110,100 + 500);
            FlxTween.tween(dad, {y: 160}, 1, {ease: FlxEase.quartInOut});
        //forcedCharFocus = dad;
    }
    if (name == 'Change Character' && params[1] == 'prangealt') sparkles.visible = true;
    if (name == 'Change Character' && params[1] == 'brookebig'){
        boyfriend.cameras = [fakeCam];
        boyfriend.setPosition(320,100 + 500);
        FlxTween.tween(boyfriend, {y: 165}, 1, {ease: FlxEase.quartInOut});
    }
        if (name == 'blackfadein') FlxTween.tween(blackScreen, {alpha: 1}, 1, {ease: FlxEase.sineOut});
        if (name == 'blackfadeout') FlxTween.tween(blackScreen, {alpha: 0}, 1, {ease: FlxEase.sineOut});
    if (name == 'scene'){
        var pickedScene = scenes[params[0] - 1];
        if (pickedScene != null){
            if (pickedScene.visible) {
                pickedScene.animation.finishCallback = null;
                pickedScene.kill(); 
                boyfriend.visible = true; 
                panelOn = false; return;
            }
            panelOn = true;
            boyfriend.visible = false;
            pickedScene.setPosition(boyfriend.getMidpoint().x - pickedScene.width/2,boyfriend.getMidpoint().y - pickedScene.height/2);
            if (params[0] == 7) pickedScene.setPosition(boyfriend.getMidpoint().x - pickedScene.width/2 + 25,boyfriend.getMidpoint().y - pickedScene.height/2 + 25);
            if (pickedScene.members == null){
                pickedScene.animation.play('scene', true);
                pickedScene.animation.finishCallback = (s)->{
                    remove(pickedScene);
                    boyfriend.visible = true;
                    panelOn = false;
                };
            }
            pickedScene.visible = true;
            FlxG.camera.snapToTarget();
        }
    }
    if (name == 'endzoom'){
        ongoing = true;
        FlxTween.tween(FlxG.camera, {zoom: 0.25}, 7, {ease: FlxEase.sineInOut, onComplete: () -> {ongoing = false;}});
        FlxTween.tween(camFollow, {x: skywalk.getMidpoint().x - 100, y: skywalk.getMidpoint().y + 300}, 6, {ease: FlxEase.cubeInOut});
    }
}
function onSongStart() {
    FlxTween.tween(dad, {alpha: 1}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(trees, {alpha: 1}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(rainback, {alpha: 0.15}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(rain, {alpha: 0.4}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(blackScreen, {alpha: 0}, 10, {ease: FlxEase.cubeIn});
    FlxTween.tween(camHUD, {alpha: 1}, 12, {ease: FlxEase.cubeIn});
    allowMoveCam = false;
    camFollow.setPosition(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 30);
    ongoing = true;
    FlxTween.tween(FlxG.camera, {zoom: 2.5}, 12.5, {ease: FlxEase.sineInOut, onComplete:
        function (twn:FlxTween) {
            ongoing = false;
            FlxTween.cancelTweensOf(FlxG.camera, ['zoom']);
            FlxG.camera.zoom = 3.5;
            defaultCamZoom = 3.5;
            camFollow.setPosition(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
            FlxG.camera.snapToTarget();
        }
    });
}
function onCameraMove(_) if (!allowMoveCam) _.cancel();
function onNoteHit(_) {
    if (_.noteType == "Lime Sing") _.character = lime;
    if (_.noteType == "Grace Sing") _.character = grace;
    if (_.note.isSustainNote) _.character.animation.curAnim.curFrame = FlxG.random.int(0, 1);
}
function postUpdate(elapsed) {
    if (ongoing) {
        defaultCamZoom = FlxG.camera.zoom;
    }
    fakeCam.scroll.x = FlxG.camera.scroll.x;
    fakeCam.scroll.y = FlxG.camera.scroll.y;
    fakeCam.zoom = FlxG.camera.zoom;
    if (legs.visible){
        if (boyfriend.animation.curAnim.name == 'idle') { boyfriend.animation.curAnim.curFrame = legs.animation.curAnim.curFrame;
        }
        legs.setPosition(boyfriend.x + 20, boyfriend.y + 71);
    }
    if (limesection) moveCam(limesection);
}

function moveCam(move:Bool, ?char = lime){
    if (char == null) char = lime;
    if (move){
        allowMoveCam = false;
        var cam_DISPLACEMENT = outside.getMidpoint();
        cam_DISPLACEMENT.set(0, 0);
        if (char.animation.curAnim != null) {
            //if (char.animation.curAnim.curFrame < 3)  {
            switch (char.animation.curAnim.name.substring(4)) {
                case 'UP':
                    cam_DISPLACEMENT.y = -5;
                case 'DOWN':
                    cam_DISPLACEMENT.y = 5;
                case 'LEFT':
                    cam_DISPLACEMENT.x = -5;
                case 'RIGHT':
                    cam_DISPLACEMENT.x = 5;
            }
            //}
        }
        if (char != boyfriend) camFollow.setPosition(char.getMidpoint().x + 180, char.getMidpoint().y - 45);
        else camFollow.setPosition(455 + 193, 207 + 70);
        camFollow.x += char.cameraOffset.x;
        camFollow.y += char.cameraOffset.y;
        camFollow.x += cam_DISPLACEMENT.x;
        camFollow.y += cam_DISPLACEMENT.y;
        cam_DISPLACEMENT.put();
    }else {allowMoveCam = true;}
}