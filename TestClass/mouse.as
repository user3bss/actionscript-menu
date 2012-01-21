package TestClass{
 import flash.events.MouseEvent;
 import flash.utils.Timer;
 import flash.events.TimerEvent;
 import flash.net.*;
 import TestClass.AUDIO;
 public class mouse{
	 
	var linkHref:Array;
	var submenu:Array;
	public function mouse(){
		var a:AUDIO = AUDIO.getInstance();
		//a.AddTrack("http://localhost/actionscript_menu/tel.mp3");
		//a.AddTrack("http://localhost/actionscript_menu/sfx2.mp3");
		a.AddTrack("http://localhost/actionscript_menu/song1.mp3");
	}
	public function set_arrays(arg:Array, arg1:Array = null){
		submenu = arg1; // Array(submenu_trigger_names, submenu_container_names);

		//trace(arg[0]); trace(arg[1]);
		linkHref = arg;
		//              Button Names                                     Button Links
		//linkHref = [["main_btn1","main_btn3","sub_btn1","sub_btn3"],["main_btn1","main_btn3","sub_btn1","sub_btn3"]];
	}
	
	function check_mouseInBounds(obj_name, mX, mY, aXL=0, aYL=0, aXH=0, aYH=0){
		var bzoolean = true;
		var str;
		var Ypoint = obj_name.getRect(obj_name.root).y;
		var Xpoint = obj_name.getRect(obj_name.root).x;
		var lowX =  Xpoint + aXL;
		var highX = Xpoint + obj_name.width + aXH;
		var lowY = Ypoint + aYL;
		var highY = Ypoint + obj_name.height + aYH;	
		bzoolean = (mX >= lowX && mX <= highX) && bzoolean;
		bzoolean = (mY >= lowY && mY <= highY) && bzoolean;
		return bzoolean;
	}
	private function ShowHideSubmenu(event:MouseEvent){
		if (submenu != null){
			//trace("submenu Array:"+submenu);
			//if(submenu[0].indexOf(event.target.name) <= submenu[1].length){
				var container_name:String = submenu[1][submenu[0].indexOf(event.target.name)];
				trace(container_name);
			//}
		}
	}
	public function mouseTrace_evt(event:MouseEvent):void {
		var a:AUDIO = AUDIO.getInstance();
		a.PlayTrack();
	 //trap mouse events that were attached to objects, not inheritance to their children ie(text fields)
	 //trace(linkHref);
	 if( event.target.hasEventListener(event.type) ){
		//trace("Event Type:"+event.type+" "+event.target+" Name:"+event.target.name+" X:"+event.stageX+" Y:"+event.stageY);
		//ShowHideSubmenu(event);
		switch( event.type ){
			case (MouseEvent.MOUSE_OUT):
				event.target.visible = false;
				break;
				
			case (MouseEvent.MOUSE_OVER):
				event.target.parent.getChildAt((event.target.parent.getChildIndex(event.target)+1)).visible = true;
				break;
				
			case (MouseEvent.CLICK):
				if(linkHref[0].indexOf(event.target.name) <= linkHref[1].length){
					var url:String = linkHref[1][linkHref[0].indexOf(event.target.name)];
					//trace(event.target.name+" Click: "+linkHref[0].indexOf(event.target.name)+" offset"+url);
					var request:URLRequest = new URLRequest(url);
					try {
					  navigateToURL(request, '_blank'); // second argument is target
					} catch (e:Error) {
					  trace("Error occurred!");
					}
				}
				break;
			default:
		}
	 }
	}
 }//end class
}//end package