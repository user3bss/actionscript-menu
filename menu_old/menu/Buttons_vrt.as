package
{
	import flash.display.Sprite;

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import flash.events.MouseEvent;
	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	import flash.display.MovieClip;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import flash.events.*;
  public class Buttons_vrt extends MovieClip{
	
		//layout position vars
		//width counter, padding between elements
		var W:int = 4;	var Offset:int = 2; var YOffset:int=0;
		var m_padding:Array = [5,8,8,5];		//top, left, right, bottom
		var sm_padding:Array = [5,2,2,5];
		var subW:int = 4; var subOffset:int = 2;
		
		//menu vars
		var FillStyle:Array;		
		var m_txtFmt:TextFormat;		//var text_attributes:Array; // 0->font, 1->color, 2->size
		var m_visible = null; var sm_visible = null;	//hold referance numbers for objects that are using overlay affects
										// for mouse over events
										// for main menu it holds a signle int
										//for submenu its and array, 0->objary offset, 1-> submenu item
		var bar_size_min;				// minimum bar size
		var bar;
		
		//var m_attr:Array;
		var m_over_attr:Array; 			//txt_format:array, fillstyle_array
		var m_over_txtFmt:TextFormat;	//var text_attributes:Array; // 0->font, 1->color, 2->size		
		var s_attr:Array;				//fillstyle submenu
		var s_over_att:Array;			//fillstyle submenu over
		var sm_txtFmt:TextFormat;
		var smo_txtFmt:TextFormat;
		var smenu_style:String;
		var smenu_width = 0;
		
		// Sound Vars
		var snd_Click_enabled = false;
		var soundClick:Sound;
		var soundClickCtrl:SoundChannel;
		var snd_Over_enabled = false;
		var soundOver:Sound;		
		var soundOverCtrl:SoundChannel;

		var nSprite;
		var tmp;
		var sub_obj_ary:Array;
		var obj_ary:Array = new Array();		//holds all menu item objects
		var pat:RegExp = /[0-9]*\d/;			//devimal pattern matching

		//-------------------------
		var extern;
		
	public function Buttons_vrt(menu_attr, menu_over_attr, sub_attr, sub_over_att, snd_att):void{
		this.buttonMode = false;
		FillStyle = menu_attr[1]; Offset = menu_attr[2];
		W = Offset*2;		//width counter 
		//m_attr = menu_attr;
		m_over_attr = menu_over_attr[1]; s_attr = sub_attr[1];  s_over_att = sub_over_att[1];
		m_padding = menu_attr[3];
		sm_padding  = sub_attr[3];
		smenu_style = sub_attr[4];
		
		//Draw the Bar for the Tab Menu------------------------------------
		var mc = [menu_attr[5], menu_attr[5], menu_attr[5], menu_attr[5]];
		var mFillStyle = ["solid", mc, 0, menu_attr[5]];				
		tmp = drawBox(menu_attr[4], 7, mFillStyle);
		tmp.name = "bar0";
		bar = tmp;
		bar_size_min = 7;
		
		// setup txt formatting properties --------------------------------------------------------------
		m_txtFmt = new TextFormat(menu_attr[0][1], menu_attr[0][2], menu_attr[0][0]); //both formats use the same font
		m_over_txtFmt = new TextFormat(menu_attr[0][1], menu_attr[0][2], menu_over_attr[0][0]);
		sm_txtFmt = new TextFormat(sub_attr[0][1], sub_attr[0][2], sub_attr[0][0]);  //both formats use the same font
		smo_txtFmt = new TextFormat(sub_attr[0][1], sub_attr[0][2], sub_over_att[0][0]); //both formats use the same font
		
		//setup sound properties ------------------------------------------
		//soundOver = new Sound( new URLRequest(snd_att[0]));
		//soundOver.addEventListener(Event.COMPLETE, sound_Over_loaded);
		//soundClick = new Sound( new URLRequest(snd_att[1]));
		//soundClick.addEventListener(Event.COMPLETE, sound_Click_loaded);
	}
	private function sound_Over_loaded(event:Event){ snd_Over_enabled = true;	}
	private function sound_Click_loaded(event:Event){ snd_Click_enabled = true;	}
	
	public function add_menu_item(menu_item:Array){
		//[0] MainSprite 			//.name = MSprite[i]
		//[1] MouseOverSprite		//.name = MOSprite[i]
		//[2] Href
		//[3] submenu array--- just like this array layout
		//     [0] Main Sprite      //.name = SMSprite[j]
		//     [1] MouseOverSprite  //.name = SMOSprite[j]
		//     [3] submenu array --------------- not in this release ----
		//
		// Add the menu items
		var i:int; var j:int;
		for(i=0;i<menu_item.length;i++){
			tmp = new Array();
			add_button(menu_item[i][0], YOffset, i);	//pass the label and Y offset, and i for object nameing
			tmp[tmp.length] = menu_item[i][1];			//add the link to the array
			//tmp looks like 
				//[0] MainSprite 			//.name = MSprite[i]
				//[1] MouseOverSprite		//.name = MOSprite[i]
				//[2] Href
			// move the tmp array to the object collection array
			obj_ary[i] = tmp;	//append it			trace(obj_ary);
			if(menu_item[i].length == 3){
				// menu item has sub menus				
				tmp = new Array();			//link container
				nSprite = new Sprite();	//object container
				nSprite.buttonMode = false;	nSprite.useHandCursor = false; //doesn't seem to make a diff??
				subW = obj_ary[i][0].x; subOffset = bar.y;
				smenu_width = 0; //submenu max width
				for(j=0;j<menu_item[i][2].length;j++){//calculate maximum box width
					var txt:TextField = createTextField(menu_item[i][2][j][0], sm_txtFmt);
					var W = txt.width+sm_padding[1]+sm_padding[2];
					if(W+2 > smenu_width) smenu_width = W+2;
				}
				for(j=0;j<menu_item[i][2].length;j++){
				  //trace(menu_item[i][2][j]); 		//add submenu items
				  tmp[tmp.length] = menu_item[i][2][j][1]; //add the link
				  add_sub_button(menu_item[i][2][j][0], j, nSprite); //trace(tmp); //tmp contains the objects from the call
				}
				obj_ary[i][3] = [nSprite, tmp];				// add submenu items to the array
				//bar_size_min = obj_ary[i][3][0].getChildAt(0).height + 8; //calc the bar size based on height of button
			}
		}
		// Done creating elements ---------------------------------------------------------------------------------
		
		// add menu elements, add the bar last, so it will be on top???????
 		/*var box = new Sprite();
		box.graphics.lineStyle(3, 0x000000, 1, true, "none", "square", "none");
		box.graphics.drawRect(0,0,bar.width,this.obj_ary[0][0].height);
		box.name = "box0";
		box.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_evt);
		this.addChild(box);*/
		
		
		for (i=0; i< obj_ary.length;i++){
			this.addChild(this.obj_ary[i][0]);	this.addChild(this.obj_ary[i][1]);
		}
		bar.y = (obj_ary[0][0].height + obj_ary[0][0].y) - 2;		//move the bar, to bottom of 1st button
		//this.addChild(bar);
		
		for (i=0; i< obj_ary.length;i++){
			if(obj_ary[i].length == 4){
			//add the submenu items to the movie
				obj_ary[i][3][0].y = this.obj_ary[0][0].height + YOffset;
				obj_ary[i][3][0].visible = false;
				this.addChild(obj_ary[i][3][0]);
				//trace(obj_ary[i][3][0]);
			}
		}
 		/*box = new Sprite();
		box.graphics.lineStyle(3, 0x000000, 1, true, "none", "square", "none");
		box.graphics.drawRect(0, bar.y-2, bar.width, 320-bar.y);
		box.name = "box1";
		box.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_evt);
		this.addChild(box);*/
	}
	
	private function add_button(aLabel:String, Y:int, aryOffset:int){
		var tabScheme:Array = [aLabel, m_txtFmt, FillStyle];		//put all the data into an array
		var tab0 = tabSprite(tabScheme, true);						// generate the button
		tab0.x = W;	tab0.y = Y;										// move the button
		tab0.name = "MSprite"+aryOffset;
		tmp[tmp.length] = tab0;		
		tab0.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_evt);
		
		tabScheme = [aLabel, m_over_txtFmt, m_over_attr];		//put all the data into an array
		var tab1 = tabSprite(tabScheme, false);					// generate the button
		tab1.x = W;	tab1.y = Y;								// move the button
		tab1.name = "MOSprite"+aryOffset;
		tmp[tmp.length] = tab1;
		//trace(tab1.hasEventListener(MouseEvent.MOUSE_OVER) ); //getChildAt(0).hasEventListener("") //willTrigger		
		tab1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown_evt); //click listener
		W += Offset+tab1.width;
	}
	
	private function add_sub_button(aLabel:String, aryOffset:int, container){
		var boxScheme:Array = [aLabel, sm_txtFmt, s_attr];		//put all the data into an array
		var box0 = boxSprite(boxScheme, true);					// generate the button
		box0.x = subW;	box0.y = subOffset;						// move the button
		box0.name = "SMSprite"+aryOffset;		
		container.addChild(box0);
		box0.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_evt);
		
		boxScheme = [aLabel, smo_txtFmt, s_over_att];//put all the data into an array
		var box1 = boxSprite(boxScheme, false);					// generate the button
		box1.x = subW;	box1.y = subOffset;							// move the button
		box1.name = "SMOSprite"+aryOffset;
		container.addChild(box1);
		box1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown_evt); //click listener
		subOffset += box1.height;
	}
	
	private function mouseDown_evt(event:MouseEvent):void {
		trace(event.type+"--------"+event.target.parent.name+"------------"+event.target.parent);		
		if (snd_Click_enabled) soundClickCtrl = soundClick.play(0);
		var tLink:String = event.target.parent.name;
		var i = tLink.match(pat); //trace(i);
		if( tLink.search("SMOSprite") >= 0  ){
			tLink = tLink.charAt(tLink.length-1);// get last char
			//trace(event.target.parent.name+" : "+tLink); //get instance name
			trace(obj_ary[m_visible][3][1][tLink]);
		}
		else{
			//tLink = obj_ary[tLink.charAt(tLink.length-1)][2]; // get link from main button
			tLink = obj_ary[i][2]; // get link from main button
			trace(tLink);
		}
		//navigateToURL(new URLRequest(tLink), "_Self");
	}
	public function mouseOver_evt(event:MouseEvent):void {
		trace(event.type+"--------"+event.target.parent.name+"------------"+event.target.parent);
		// ?? this is called even if not mouseover		// for object onwich event was appended
		var tLink:String = event.target.parent.name;		//trace(tLink);
		var i = tLink.match(pat); //trace(i);
		if( tLink.search("MSprite") == 0 ){ // this statement fixes anomily for mouseover stage,
			if (snd_Over_enabled) soundOverCtrl = soundOver.play(0);
			obj_ary[i][1].visible = true;
			obj_ary[i][1].addEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt); //click listener
			m_visible = i;
			if(obj_ary[i].length == 4){				//submenu visability
				obj_ary[i][3][0].visible = true;
				obj_ary[i][3][0].addEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt); //click listener
			}
		} else if ( tLink.search("SMSprite") == 0 ){
			if (snd_Over_enabled) soundOverCtrl = soundOver.play(0);			
			obj_ary[m_visible][3][0].getChildAt((i*2)+1).visible = true;
			obj_ary[m_visible][3][0].getChildAt((i*2)+1).addEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt); //click listener
			sm_visible = i;
		} else if ( tLink.search("Sprite") == -1 ) {
			try{
				//trace(tLink+", :"+tLink.search("Sprite"));
				//obj_ary[m_visible][1].visible = false;		//disable selected tab
				//obj_ary[m_visible][3][0].visible = false;	//disable submenu container
				//obj_ary[m_visible][3][0].getChildAt((sm_visible*2)+1).visible = false; //disable selected sub menu item
				//sm_visible = null;
			} catch (e){
			}
		}
	}

	public function mouseOut_evt(event:MouseEvent):void {
		trace(event.type+"--------"+event.target.parent.name+"------------"+event.target.parent);
		// ?? this is called even if not mouseover		// for object onwich event was appended
		var tLink:String = event.target.parent.name;		//trace(tLink);
		var i = tLink.match(pat); //trace(i);
		if( tLink.search("MSprite") == 0 ){ // this statement fixes anomily for mouseover stage,
			if (snd_Over_enabled) soundOverCtrl = soundOver.play(0);
			if(m_visible != null){
				obj_ary[m_visible][1].visible = false;
				obj_ary[m_visible][1].removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt);
				if(obj_ary[m_visible].length == 4){ //if has submenu
					obj_ary[m_visible][3][0].visible = false;	//disable submenu container
					obj_ary[m_visible][3][0].removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt);
					if (obj_ary[m_visible][3][0].numChildren >= (sm_visible*2)+2 && sm_visible != null){
							obj_ary[m_visible][3][0].getChildAt((sm_visible*2)+1).visible = false;
							obj_ary[m_visible][3][0].getChildAt((sm_visible*2)+1).removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt);
							sm_visible = null;
					}
				}
			}
			m_visible = i;
		} else if ( tLink.search("SMSprite") == 0 ){
			if (snd_Over_enabled) soundOverCtrl = soundOver.play(0);			
			if (obj_ary[m_visible][3][0].numChildren >= (sm_visible*2)+2 && sm_visible != null){
				obj_ary[m_visible][3][0].getChildAt((sm_visible*2)+1).visible = false;
				obj_ary[m_visible][3][0].getChildAt((sm_visible*2)+1).removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_evt);
			}
			sm_visible = i;
		}
	}
	
	//--=============================== DRAWING SECTION =============================================
	private function tabSprite(arg:Array, is_visible:Boolean):Sprite{
		//0:String	label text
		//1:TextFormat	text color
		//2:Array	[0]FillStyle["vertGrad","solid"... to be continued
		// 			[1]fillcolor array
		// 			[2]fillalpha array
		//			[3]Background Color
		var X:int=0; var Y:int=0;
		var myButton:Sprite = new Sprite();
		var txt:TextField = createTextField(arg[0], arg[1]);		
		txt.x = m_padding[1];	txt.y = m_padding[0];
		//var W = txt.width; var H = txt.height;
		var W = txt.width+m_padding[1]+m_padding[2];
		var H = txt.height+m_padding[0]+m_padding[3];
		var aTab = drawTab(W-12, H, arg[2]);
		if(! is_visible)
		 myButton.visible = false;
		myButton.addChild(aTab);
		myButton.addChild(txt);
		myButton.buttonMode = true;
		return myButton;
	}
	
	private function boxSprite(arg:Array, is_visible:Boolean):Sprite{
		//0:String	label text
		//1:TextFormat	text color
		//2:Array	[0]FillStyle["vertGrad","solid"... to be continued
		// 			[1]fillcolor array
		// 			[2]fillalpha array
		//			[3]Background Color
		var X:int=0; var Y:int=0;
		var boxButton:Sprite = new Sprite();
		boxButton.buttonMode = true;	boxButton.useHandCursor = true;		
		var txt:TextField = createTextField(arg[0], arg[1]);
		txt.x = sm_padding[1];	txt.y = sm_padding[0];
		var H = txt.height+sm_padding[0]+sm_padding[3];		
		var aBox = drawBox(smenu_width, H, arg[2]);
		if(! is_visible)
		 boxButton.visible = false;
		boxButton.addChild(aBox);
		boxButton.addChild(txt);
		return boxButton;
	}
	//------------------------------ private section ----------------------------------------
	private function createTextField(itext:String, tfmt:TextFormat, iX:int=0, iY:int=0):TextField{
		var aText:TextField = new TextField();
		//aText.textColor = 447201;		
		aText.border = false;
		aText.selectable = false;
		aText.autoSize = TextFieldAutoSize.LEFT;
		//aText.embedFonts(true);		// throws error, inaccessible property
		if(itext != null) aText.text = itext; 
		if(iX != 0) aText.x = iX;	
		if(iY != 0) aText.y = iY;	
	    aText.setTextFormat(tfmt);		// this has to be last of formating doesn't get applied
		return aText;
	}
	
	private function Gradient(O,W:int,H:int,Fs:Array){
		//Fs fill style Array
		var matrix:Matrix = new Matrix;
	
		if(Fs[0] == "vertGrad"){
			var alphas:Array = Fs[2]; //[100, 50, 50, 100];	
			var ratios:Array = [0, 125, 128, 255];
			matrix.createGradientBox(W, H, (Math.PI/2));
			O.graphics.beginGradientFill(GradientType.LINEAR, Fs[1], alphas, ratios, matrix);
		}
		if(Fs[0] == "solid"){
			O.graphics.beginFill(Fs[1][0],100); //solid fill
		}
		//O.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		//O.graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix);	
	}
	
	private function drawTab(W:int, H:int, Ft:Array, X:int=0, Y:int=0, r:int=6, rH:int=5):Shape{
		//supposedly there's a method that can draw this in the graphics library
		//flash.Shape.graphics.drawRoundRectComplex(100, 300, 300, 300, 100, 0, 0, 0);
		// but I havn't got it to display, however it doesn't throw any errors???
		var tab:Shape = new Shape;
		tab.graphics.lineStyle(1, Ft[3], 60, true, "none", "square", "none");
		Gradient(tab,W,H,Ft);
		tab.graphics.lineTo(W, 0);	//top line
		tab.graphics.curveTo((W+r),0,(W+r),(H / rH)); //top right corner
		tab.graphics.lineTo((W+r), H);				  //right side
		tab.graphics.lineTo(0-r, H);				  // bottum line
		tab.graphics.lineTo(0-r, (H / rH));			 // left side
		tab.graphics.curveTo(0-r,0,0,0);			 //left corner
		tab.graphics.endFill();
		tab.x = r;	//move the shape so all is visible		
		return tab;
	}
	private function drawBox(W:int, H:int, Ft:Array):Shape{
 		var bar = new Shape();
		bar.graphics.lineStyle(1, Ft[3], 60, true, "none", "square", "none");
		//bar.graphics.beginFill(menu_attr[4], 100);
		Gradient(bar,W,H,Ft);		
		bar.graphics.drawRect(0,0,W,H);
		bar.graphics.endFill();
		return bar;
	}
	
	//- Transform Functions +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
  }
}