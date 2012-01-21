package TestClass{
//================== Modify Display List =============================
//contains(child:DisplayObject):Boolean
//getChildIndex(target:DisplayObject):int
//getChildByName(name:String):DisplayObject
//getChildAt(num:int):DisplayObject
//getObjectsUnderPoint(point:Point):Array
//areInaccessibleObjectsUnderPoint(point:Point)
//removeChild(child:DisplayObject):DisplayObject
//removeChildAt(index:int):DisplayObject
//setChildIndex(child:DisplayObject, index:int):void
//swapChildren(child1:DisplayObject, child2:DisplayObject):void
//swapChildrenAt(index1:int, index2:int):void

//=========== Get object type ============================
//this.isPrototypeOf(theClass:Object):Boolean
//trace(this.hasOwnProperty("numChildren"));
//trace(typeof(this.root));		//object
//trace(this.root.toString);	//function Function() {}
//trace(this.root);				//[object MainTimeline]
//trace(this.root.stage);		//[object Stage]

//print_names(this);
 public class DisplayLIST{
	private static var _instance:DisplayLIST;
	private var level:int = 0;
	public static function getInstance():DisplayLIST {
		if (_instance == null) {
			_instance = new DisplayLIST();
			trace("creating new DisplayLIST Singleton.");
		}
		return _instance;
	}	 
	 public function DisplayLIST():void {
	 }
//traverse the display list
	private function space(numSpaces:int):String{
		var space1:String = " ";
		var r:String = "";
		for(var i = 0;i<numSpaces;i++){
			r = r.concat(space1);
		}
		return r;
	}
	public function print_names(obj){
		if(obj.hasOwnProperty("numChildren")){
			//trace("Name: "+obj.name+" has "+obj.numChildren+" children");
			for(var i = 0;i<obj.numChildren;i++){
				trace(space(level)+"Index:"+i+" Type:"+obj.getChildAt(i)+" Name:"+obj.getChildAt(i).name+" Parent:"+obj.getChildAt(i).parent.name);
				if(obj.getChildAt(i).hasOwnProperty("numChildren")){	//is it a object container?
					level++;
					print_names(obj.getChildAt(i) );	//trace(obj.getChildAt(i).getChildAt(0).name);
				}
			}
			if(level > 0){
				level--;
			}
		} else {
			trace("object doesn't have numChildren Property");
		}
	}
 }
}