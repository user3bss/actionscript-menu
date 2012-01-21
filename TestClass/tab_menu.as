//Purpose:
//to call drawing components and add listeners to create a menu
//
// display list ----------------
// main container:	 0
// main_button:		 0,1
// main_button_over: 0,2
// sub_menu:		 0,3
// sub_button:		 0,3,0
// sub_button_over:	 0,3,1
//
package TestClass{
 import TestClass.Complex_Button;
 import TestClass.stack;
 import flash.display.Sprite;
 
 import flash.events.MouseEvent;
 import TestClass.mouse;

 public class tab_menu{ // extends MovieClip{
	var s_main;	var s_sub;	//stacking
	var b_top;	var b_sub;	//buttons
	var bar;				//menu bar
	public var container;	//holds the entire menu
	var m;					//mouse event class
	var menuAry:Array;

	public function tab_menu(arg:Array):void{
		//build the menu here
		//arg list
		//[0]		main config vars for menu creation
		//[0][0]	XOffset
		//[0][1]	YOffset
		//[0][2]	bar width
		//[0][3]	bar color
		//
		//[1]		main button styles
		//[1][0]	text format:Array
		//[1][1]	button style:Array
		//[1][2]	padding:Array
		//[1][3]	ShapeType:String
		//[1][4]	menu stacking
		//[1][5]	over text format:Array
		//[1][6]	over button style:Array
		//
		//[2]		submenu styles
		//[2][0]	text format:Array
		//[2][1]	button style:Array
		//[2][2]	padding:Array
		//[2][3]	ShapeType:String
		//[2][4]	menu stacking
		//[2][5]	over text format:Array
		//[2][6]	over button style:Array
		container = new Sprite();
		container.x = 8;	container.y = 2;	//align the container object
		container.name = "tab_menu";
		
		//=================================== Creating Stacking obj's ============================
		//		Xoffset, YOffset, Obj_spacing, type = "vert" or "horiz"	
		s_main = new stack(arg[0][0], arg[0][1], 3, arg[1][4]); 
		s_sub = new stack(0, 0, 0, arg[2][4]);
		//trace(arg[1]); trace(arg[2]);
		b_top = new Complex_Button(arg[1], "main_btn");
		b_sub = new Complex_Button(arg[2], "sub_btn");

		//draw the menu bar
		
		bar = new Sprite();
		bar.name = "bar";
		bar.graphics.lineStyle(1, arg[0][3], 60, true, "none", "square", "none");
		bar.graphics.beginFill(arg[0][3]);
		bar.graphics.drawRect(0, 0, arg[0][2], 10);
		bar.graphics.endFill();
		
		m = new mouse();
	}
	
	public function make_menu(menu:Array){
		//the Links are an array like
		//[0]		label
		//[1]		url
		//[2]		Array
		// the menu of links array is like
		//[0]		menu array
		var button_names:Array = new Array();
		var button_links:Array = new Array();
		var submenu_trigger_names:Array = new Array();
		var submenu_container_names:Array = new Array();
		var mc = new Sprite();
		mc.name = "main_menu";
		for(var i=0;i<menu.length;i++){
			var tmp = b_top.make_button(menu[i][0]); //tmp = return [btn:boxSprite, btn_Over:boxSprite];
			s_main.stack_obj(tmp[0]);	s_main.move_obj(tmp[1]);
			tmp[0].addEventListener(MouseEvent.MOUSE_OVER, m.mouseTrace_evt);
			tmp[1].addEventListener(MouseEvent.MOUSE_OUT, m.mouseTrace_evt);
			tmp[1].addEventListener(MouseEvent.CLICK, m.mouseTrace_evt);
			button_names.push(tmp[1].name);	//store the link
			button_links.push(menu[i][1]);	//store the link

			if(menu[i].length > 2){ //if it has a sub menu process it
				b_sub.setmax(menu[i][2]);		//get max size;
				if(s_sub.type == "vert"){ 			// set auto size and position automatically for drop menus
					s_sub.stack_reset(s_main._X, (tmp[0].height+bar.height - 2));
				}
				if(s_sub.type == "horiz"){ 			// set auto size and position automatically for drop menus
					s_sub.stack_reset(0, (tmp[1].height+bar.height - 2));
				}				
				var sc = new Sprite();
				sc.name = "sub_menu"+i;
				for(var j=0;j<menu[i][2].length;j++){
					var tmp1 = b_sub.make_button(menu[i][2][j][0]);
					s_sub.stack_obj(tmp1[0]);	s_sub.move_obj(tmp1[1]);
					sc.addChild(tmp1[0]);		sc.addChild(tmp1[1]);
					tmp1[0].addEventListener(MouseEvent.MOUSE_OVER, m.mouseTrace_evt);
					tmp1[1].addEventListener(MouseEvent.MOUSE_OUT, m.mouseTrace_evt);
					tmp1[1].addEventListener(MouseEvent.CLICK, m.mouseTrace_evt);					
					button_names.push(tmp1[1].name);		//store the link
					button_links.push(menu[i][2][j][1]);	//store the link
				}
				submenu_trigger_names.push(tmp[1].name);
				submenu_container_names.push(sc.name);
				sc.visible = false;		//make so sub menus aren't visible by default
				container.addChild(sc);
			}
			mc.addChild(tmp[0]);
			mc.addChild(tmp[1]);
		}
		container.addChild(mc);
		var mlink:Array = [button_names, button_links];
		if(submenu_trigger_names.length > 0){
			var submenu_connections:Array = new Array(submenu_trigger_names, submenu_container_names);
			m.set_arrays(mlink, submenu_connections);
		} else {
			m.set_arrays(mlink);
		}
		bar.x = -10;	bar.y = tmp[0].height - 2;	container.addChild(bar);
		return container;
	}
 }
}