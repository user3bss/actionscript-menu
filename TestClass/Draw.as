package TestClass{
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.geom.Matrix;

	import flash.display.Sprite;
  public class Draw{
	public function Draw(){}
	// all function accept an style array in this format
	//Ft:Array	[0]FillStyle["vertGrad","solid"... to be continued
	// 			[1]fillcolor array
	// 			[2]fillalpha array
	//			[3]Background Color


	//an attempt to predefine commonly used gradient fills
	private function Gradient(O,W:int,H:int,Ft:Array){
		//Fs fill style Array
		if(Ft[0] == "vertGrad"){
			var matrix:Matrix = new Matrix;
			var alphas:Array = Ft[2]; //[100, 50, 50, 100];	
			var ratios:Array = [0, 125, 128, 255];
			matrix.createGradientBox(W, H, (Math.PI/2));
			O.graphics.beginGradientFill(GradientType.LINEAR, Ft[1], alphas, ratios, matrix);
		}
		if(Ft[0] == "solid"){
			O.graphics.beginFill(Ft[1][0],100); //solid fill
		}
		//O.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		//O.graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix);	
	}
	public function drawBox(W:int, H:int, Ft:Array){
 		var bar = new Sprite();
		bar.graphics.lineStyle(1, Ft[3], 60, true, "none", "square", "none");
		if(Ft[0] != "none") Gradient(bar,W,H,Ft);		
		bar.graphics.drawRect(0,0,W,H);
		if(Ft[0] != "none") bar.graphics.endFill();
		return bar;
	}
	
	public function drawTab(W:int, H:int, Ft:Array, r:int=6, rH:int=5){
		var tab = new Sprite();
		tab.graphics.lineStyle(1, Ft[3], 60, true, "none", "square", "none");
		if(Ft[0] != "none") Gradient(tab,W,H,Ft);
		tab.graphics.lineTo(W, 0);	//top line
		tab.graphics.curveTo((W+r),0,(W+r),(H / rH)); //top right corner
		tab.graphics.lineTo((W+r), H);				  //right side
		tab.graphics.lineTo(0-r, H);				  // bottom line
		tab.graphics.lineTo(0-r, (H / rH));			 // left side
		tab.graphics.curveTo(0-r,0,0,0);			 //left corner
		if(Ft[0] != "none") tab.graphics.endFill();
		tab.x = r;	//move the shape so all is visible		
		return tab;
	}
  }
}