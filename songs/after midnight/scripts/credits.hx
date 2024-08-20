import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

var creditFrame:FlxSprite;
var creditTxt:FlxText;

function postCreate() {
    creditFrame = new FlxSprite().loadGraphic(Paths.image('game/credit'));
    creditFrame.scale.set(1.5,1.5);
    creditFrame.updateHitbox();
    creditFrame.setPosition(-creditFrame.width, 40);
    creditFrame.cameras = [camHUD];
    add(creditFrame);
    
    creditTxt = new FlxText(0,creditFrame.y+10,creditFrame.width);
    creditTxt.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    creditTxt.text = "@AFTER MIDNIGHT@\nGREGGREG\n\n@ART@\nMABOI9798\nLOSS\nYUMII\nINFRY\nLIBUR\nHEADDZO\nSTUFFY\n\n@CODING@\nPENI\nDATA\n\n@CHARTING@\nROTTY\nBROOKLYN\nDOUYHE";
    creditTxt.applyMarkup(creditTxt.text, [new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.WHITE,true,false,0xFFCB00E5),'@'),new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.WHITE),'^^')]);
    creditTxt.x = creditFrame.x;
    creditFrame.setGraphicSize(Std.int(creditFrame.width),Std.int(creditTxt.height)+25);
    creditFrame.updateHitbox();
    creditTxt.cameras = [camHUD];
    add(creditTxt);
}
function beatHit(beat:Int)
    if (beat == 30) {
        FlxTween.tween(creditTxt, {x: 10},1, {ease: FlxEase.cubeOut});
        FlxTween.tween(creditFrame, {x: 10}, 1, {ease: FlxEase.cubeOut, onComplete: function (f:FlxTween) {
        FlxTween.tween(creditTxt, {x: -creditFrame.width},1.5, {startDelay: 1,ease: FlxEase.cubeIn});
        FlxTween.tween(creditFrame, {x: -creditFrame.width},1.5, {startDelay: 1,ease: FlxEase.cubeIn, onComplete: function (f:FlxTween) {
                remove(creditFrame);
                creditFrame.destroy();
                remove(creditTxt);
            }});
        }});
    }