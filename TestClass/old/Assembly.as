import TestClass.assemble;
import TestClass.stack;
import TestClass.Draw;

var d = new Draw();
var o;
var s = new stack(0, 0, 0, "vert");
var a;
var container;

var styles = ["none","solid","vertGrad"];
//txtcolor, font, size, bold
var txtFmt = [0xffffff, "_sans", 14, true];
//fillstyle, colors, alphas,bordercolor
var FillStyle = [styles[1],
				 [0x000000,0xffffff,0xffffff,0x000000],
				 [1,1,1,1],
				 0x004200];
var txtFmtO = [0xffffff, "_sans", 14, true];
//fillstyle, colors, alphas,bordercolor
var FillStyleO = [styles[1],
				 [0x000000,0xffffff,0xffffff,0x000000],
				 [1,1,1,1],
				 0x004200];


container = new Sprite();
container.name = "menu0";
	a = new assemble([10, 0, 5, "horiz"],[FillStyle, "Tab", [5, 5, 10, 10]], "menu_main");
	b = new assemble([10, 0, 5, "horiz"],[FillStyle, "Tab", [5, 5, 10, 10]], "menu_main");
	o = a.assemble_Obj("hehehe", true);
	container.addChild(o);
	o.addEventListener(MouseEvent.MOUSE_OVER, mouseTrace_evt);
	o = a.assemble_Obj("hahaha", true);
	container.addChild(o);
	o.addEventListener(MouseEvent.MOUSE_OVER, mouseTrace_evt);
this.addChild(container);
s.stack_obj(container);

o = d.drawBox(500,10,FillStyle);
o.name = "menu_bar";
o.addEventListener(MouseEvent.MOUSE_OVER, mouseTrace_evt);
this.addChild(o);
s.stack_obj(o, 2, -3);

container = new Sprite();
container.name = "sub_menu0";
	a = new assemble([10, 0, 0, "vert"],[FillStyle, "", [10, 5, 5, 5] ], "menu_sub");
	o = a.assemble_Obj("hehehe", true);
	container.addChild(o);
	o.addEventListener(MouseEvent.MOUSE_OVER, mouseTrace_evt);
	o = a.assemble_Obj("hahaha", true);
	container.addChild(o);
	o.addEventListener(MouseEvent.MOUSE_OVER, mouseTrace_evt);
container.visible = false;
this.addChild(container);
s.stack_obj(container);