package TestClass{
	//=========================== External interface ============================
	import flash.external.ExternalInterface;

 public class Extern{
	public var rxBuffer = null;
	public var valid = false;
	
	public var has_id:Boolean;
	public var chart_id:String;
	private static var _instance:Extern;
	
	public static function getInstance():Extern {
		if (_instance == null) {
			_instance = new Extern();
			trace("creating new Extern Singleton.");
		}
		return _instance;
	}
	public function setUp(chart_id:String):void {
		this.has_id = true;
		this.chart_id = chart_id;
		//trace('this.chart_id',this.chart_id);
	}	
	public function Extern():void {
		rxBuffer = null;
		valid = false;
		if (ExternalInterface.available){
			ExternalInterface.addCallback("sendToActionScript", receivedFromJavaScript);
		}		
	}
	public function FlashIsReady(){
		if (ExternalInterface.available){
			ExternalInterface.call("isReady");
		}
	}
	private function receivedFromJavaScript(txt:String):void{
		rxBuffer = txt;
		valid = true;
	}
 }
}