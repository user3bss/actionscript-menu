package TestClass{
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import flash.text.engine.FontDescription;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.SpaceJustifier;
	import flash.text.engine.LineJustification;	

//input array is in the form:
//[ color:int, font:String, size:int ]
	public class TextBLOCK{
		var txtFmt:ElementFormat;
		public function TextBLOCK(arg:Array){
				this.format = arg;	//test the setter
		}
	
		public function getMaxSizeText(arg:Array, pad:Array):int{
			var max_text_width = 0; 	//submenu max width
			for(var j=0;j<arg.length;j++){//calculate maximum box width
				var txt:TextLine = createText(arg[j][0]);
				var W = txt.width+pad[1]+pad[2];
				if(W+2 > max_text_width) max_text_width = W+2;
			}
			return max_text_width;
		}
		public function set format(arg:Array){
		  //trace (arg);
		  var fontDescription:FontDescription = new FontDescription();		  //fontDescription.fontName = "_sans";
		  fontDescription.fontName = arg[1];
		  //fontDescription.fontWeight = flash.text.engine.FontWeight.BOLD;
		  txtFmt = new ElementFormat(fontDescription);  //txtFmt.fontSize = 14; txtFmt.color = 0x000000;
		  txtFmt.fontSize = arg[2];	  txtFmt.color = arg[0];
		}
		public function createText(itext:String):TextLine{
		  //var strlen:int = itext.length; trace (itext.length);
		  var textElement:TextElement = new TextElement(itext, txtFmt);			//insert text
		  var textBlock:TextBlock = new TextBlock();
		  textBlock.content = textElement;
		  var spaceJustifier:SpaceJustifier = new SpaceJustifier("en", LineJustification.ALL_INCLUDING_LAST);
		  textBlock.textJustifier = spaceJustifier;					
		  var textLine:TextLine = textBlock.createTextLine(null, 500); //500 text width, 
		  textLine.mouseEnabled = false; //this didn't disable the events
		  return textLine;
		}	
	}
}