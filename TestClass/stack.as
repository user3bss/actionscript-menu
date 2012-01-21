package TestClass{
	//all extra clases must be declared here
	//
	// the constructor sets up the variables Xoffset,Yoffset,obj_spacing,type
	//
	// this class uses _X and _Y to place objects on the stage using basic arithmetic
	// the objects are placed either vertically or horizontally using obj_spacing as a padding value
	// between objects.
	// 
	// the stack function moves the object to x,y offset + obj_spacing and adjusts the _X and _Y variables
	// of this class
	//
	// the move obj function just moves the object to _X,_y
	public class stack{
		var Xoffset:int; var Yoffset:int; //var Zoffset;
		var obj_spacing:int; 
		public var type:String; //either "vert" or "horiz"
		public var _X:int;
		public var _Y:int;
		
		public function stack(a:int=0, b:int=0, c:int=0, d:String="vert"){
			Xoffset = a; Yoffset = b; obj_spacing = c; type = d;
		}
		
		public function stack_reset(a:int=0, b:int=0, c:int=0){
			Xoffset = a; Yoffset = b; obj_spacing = c;
		}
		
		public function stack_obj(obj, Xadj:int=0, Yadj:int=0){
			this.move_obj(obj, Xoffset, Yoffset);
			obj.x += Xadj; obj.y += Yadj;		//adjust if nessicary
			switch (type){
			case ("vert"):
				Yoffset += obj.height + obj_spacing + Yadj;
				//Xoffset = obj.width
				break;
			case ("horiz"):
				Xoffset += obj.width + obj_spacing + Xadj;
				//Yoffset = obj.height;
				break;			
			default:
				trace("TestClass stack type error");
			}
			//trace(type+" X:"+Xoffset+", Y:"+Yoffset+", height:"+obj.height+", width:"+obj.width);
		}
		public function move_obj(obj, moveX:int=0, moveY:int=0){
		//align the text inside the shape
		//trace("X:"+obj.x+", Y:"+obj.y+", height:"+obj.height+", width:"+obj.width);
		//trace("X:"+obj.getRect(pObj).x); 		trace("Y:"+obj.getRect(pObj).y);
		//trace("Rect:"+obj.getRect(pObj));
		//obj.x -= obj.getRect(pObj).x;	
		//obj.y -= obj.getRect(pObj).y;			//align the y position of the text to 0 in the box
		//obj.y += (pObj.height-obj.height);  	// - arg[3][0]; //center the text
		
			if(moveX != 0){
				obj.x = moveX;
				_X = moveX;
			} else	obj.x = _X;
			
			if(moveY != 0){
				obj.y = moveY;
				_Y = moveY;
			} else	obj.y = _Y;
		}
	}
}