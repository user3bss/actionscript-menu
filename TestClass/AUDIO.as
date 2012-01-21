package TestClass{
 import flash.media.Sound;
 //import flash.media.SoundChannel;
 import flash.media.SoundTransform;
 import flash.net.URLRequest;
 import flash.events.*;
 import flash.utils.getTimer;

 public class AUDIO{
	var Tracks:Array = new Array();
	//var soundControl:SoundChannel;
	var CurrentTrack:int = 0;
	private static var _instance:AUDIO;
	private function ErrorHandler(evt:Event){
		trace(evt);
	}
	public static function getInstance():AUDIO {
		if (_instance == null) {
			_instance = new AUDIO();
			trace("creating new AUDIO Singleton.");
		}
		return _instance;
	}	
	public function AUDIO(_Tracks:Array = null){
		if(_Tracks != null){
			for(var i=0;i<_Tracks.length;i++){
				AddTrack(_Tracks[i]);
			}
		}
	}
	public function AddTrack(url:String){
		var soundReq:URLRequest = new URLRequest(url);
		var sound:Sound = new Sound();
		//sound.addEventListener(ioError, ErrorHandler);
		sound.load(soundReq);
		Tracks.push(sound);
	}
	public function PlayTrack(Track:int = 0):void{
		if(Track < Tracks.length){
			//var t:int = getTimer();
			//Tracks[Track].addEventListener(Event.SOUND_COMPLETE, NextTrack, false, 0, true);
			Tracks[Track].play(0);
			//trace("delay time: "+(getTimer()-t)+"ms");			
		}
	}
	public function PlayTrackList():void{
		CurrentTrack = 0;
		PlayTrack(CurrentTrack);
//		for(var i = 0;i<Tracks.length;i++){		}
	}
	
// plays the sound with volume 0 endlessly
/*	var  SilentSoundTransform:SoundTransform = new SoundTransform(0);
	var silent_sound:Sound;
	function playSoundSilentlyEndlessly(evt:Event = null):void{
		Tracks[0].play(0, 1000, SilentSoundTransform).addEventListener(Event.SOUND_COMPLETE, playSoundSilentlyEndlessly, false, 0, true);
		trace("+");
	}*/
 }
}