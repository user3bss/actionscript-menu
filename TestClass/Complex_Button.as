//========================================================
// Purpose Draw Buttons
//
//
//==============================================================================================================
//in order for handcursor to hold true for entire button
// you must select a fill style other that "none", this also affects the
// mouseOver event because without a fillstyle applied the mouse can only be triggered by the border line
//
// the TextField overrides the usehand, and takes mouse events, the Text field also takes the object name???
//
// TextBlock doesn't override the usehand mouse pointer when mouse is over text,
//		however everthing else is the same ie( mouse events and object name)
//
// the sprite object won't take the object name???
	
package TestClass{
 import flash.display.Sprite;
 import TestClass.TextBLOCK;
 import TestClass.Draw;
 
 public class Complex_Button{
	var FillStyle:Array;		var txtFmt;
	var FillStyle_Over:Array;	var txtFmt_Over;
	var ShapeType:String;
	var padding:Array;
	var d = new Draw();
	var nameSpace;
	var objNamei = 0;
	var menu_width = 0;
	
	public function Complex_Button(arg:Array, ns:String="btn" ){//obj_stacking, Style, misc="obj"){
		//[0]		main button styles
		//[0][0]	text format:Array
		//[0][1]	button style:Array
		//[0][2]	padding:Array
		//[0][3]	ShapeType:String
		//[0][4]	menu stacking
		//[0][5]	over text format:Array
		//[0][6]	over button style:Array		
		txtFmt = new TextBLOCK(arg[0]);
		txtFmt_Over = new TextBLOCK(arg[5]);

		//fillstyle, colors, alphas, border color
		FillStyle = arg[1];
		FillStyle_Over = arg[6];
		ShapeType = arg[3];
		padding = arg[2];	//text padding
		nameSpace = ns;
	}
	
	public function setmax(menu:Array){
		menu_width = txtFmt.getMaxSizeText(menu, padding);
	}
	
	//----------------------------------------------------------------------
	//var Xoffset = 0; var Yoffset = 0; var type = "vert";	//object stacking
	public function make_button(txt:String):Array{
		var btn = boxSprite([txt,txtFmt,FillStyle,padding], true);
		btn.name = nameSpace+objNamei; objNamei++;
		
		var btn_Over = boxSprite([txt,txtFmt_Over,FillStyle_Over,padding], false);
		btn_Over.name = nameSpace+objNamei; objNamei++;		
		return [btn, btn_Over];
	}
	
	private function boxSprite(arg:Array, is_visible:Boolean):Sprite{
		//0:String	label text
		//1:TextFormat	text properties object
		//2:Array	[0]FillStyle["vertGrad","solid"... to be continued
		// 			[1]fillcolor array
		// 			[2]fillalpha array
		//			[3]Background Color
		//3:Array   padding, all int's representing pixels of padding
		//			[0] top
		//			[1] left
		//			[2] right
		//			[3] bottom
		var boxButton:Sprite;
		var txt = arg[1].createText(arg[0]);
		//txt.mouseEnabled = false;
		//txt.mouseChildren = false;
		txt.name = nameSpace+"Label"+objNamei;
		var H = txt.height+arg[3][0]+arg[3][3]; // add the padding to the height
		var W = txt.width+arg[3][1]+arg[3][2]; // add the padding to the width
		if(menu_width > W){	W = menu_width;	}
		switch(ShapeType){
			case("Tab"):
			 boxButton = d.drawTab(W, H, arg[2]);
			 break;				
			default:
			 boxButton = d.drawBox(W, H, arg[2]);
		}
		//align the text inside the shape
		//trace(txt.getRect(boxButton));
		txt.x += arg[3][1];	
		txt.y -= txt.getRect(boxButton).y;	//align the y position of the text to 0 in the box
		txt.y += (boxButton.height-txt.height) - arg[3][0]; //center the text
		//trace(txt.getRect(boxButton));
		boxButton.visible = is_visible;
		boxButton.addChild(txt); 
		boxButton.buttonMode = true;
		boxButton.useHandCursor = true;
		//boxButton.name = "boxButton";
		boxButton.mouseChildren = false;
		return boxButton;
	}
 }
}
