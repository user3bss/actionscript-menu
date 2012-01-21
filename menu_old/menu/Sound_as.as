import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
var soundReq:URLRequest = new URLRequest("http://localhost/tel.mp3");
var sound:Sound = new Sound();
var soundControl:SoundChannel;
sound.load(soundReq);
var resumeTime:Number = -1;

sound.addEventListener(Event.COMPLETE, sComplete);
function sComplete(event:Event):void{ resumeTime = 0; }

function playSound():void{
	 soundControl = sound.play(0); //(resumeTime);
	 resumeTime = soundControl.position;	
}