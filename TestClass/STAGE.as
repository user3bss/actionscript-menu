package TestClass{
	//trace(this.stage.frameRate);	//12
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
 public class STAGE{
	private static var _instance:STAGE;
	var swfStage = null;
	
	public static function getInstance():STAGE {
		if (_instance == null) {
			_instance = new STAGE();
			trace("creating new STAGE Singleton.");
		}
		return _instance;
	}
	public function STAGE():void {
	}
	public function set_STAGE(swfS:Stage):void {
		swfStage = swfS;
		swfStage.scaleMode = StageScaleMode.NO_SCALE;
		swfStage.align = StageAlign.TOP_LEFT;
		swfStage.addEventListener(Event.RESIZE, resizeDisplay);		
	}
	public function resizeDisplay(event:Event):void {
		var swfWidth:int = swfStage.stageWidth;	
		var swfHeight:int = swfStage.stageHeight;
		//trace("resize event: stageWidth:"+swfWidth+" swfHeight"+swfHeight);	
		// Resize the video window.
		//var newVideoHeight:Number = swfHeight - controlBar.height;
		//videoScreen.height = newVideoHeight;
		//videoScreen.scaleX = videoScreen.scaleY;
		// Reposition the control bar.
		//controlBar.y = newVideoHeight;
	}
 }
}