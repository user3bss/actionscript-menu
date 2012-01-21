function get_buttons(){
	level0 = xml_data.buttons.button;
	for(var i=0;i<level0.length();i++){
		var bLink_sub:Array = [];		//new array
		level1 = level0[i].sub; 		//get submenu buttons
		for(var j=0;j<level1.length();j++){
			//trace("label:"+level1[j].attribute("label")+", url:"+level1[j].attribute("url")+", target:"+level1[j].attribute("target"));
			bLink_sub[j] = [level1[j].attribute("label").toString(), level1[j].attribute("url").toString()]; //, level1[j].attribute("target")
		}
		//trace("i: "+i+", "+level1);
		menu_item[i] = [level0[i].attribute("label").toString(), level0[i].attribute("url").toString(), bLink_sub]; //main menu links		
	}
	//trace("Labels:"+bLink_Label);	trace("urls:"+bLink_Url);
	//trace("bLinks:"+bLinks);
}
function get_properties(){
	//process main menu -----------------------------------------------------------------------------
	level0 = xml_data.properties.main_menu.default_view;
	button_padding = [int(level0.padding.attribute("top").toString()),
					  int(level0.padding.attribute("left").toString()),
					  int(level0.padding.attribute("right").toString()),
					  int(level0.padding.attribute("bottom").toString())];
	
	menu_txt =  [int(level0.text.attribute("color").toString()),
				 level0.text.attribute("font").toString(),
				 int(level0.text.attribute("size").toString())];
	
	menu_colors = [int(level0.colors_gradient.attribute("top").toString()),
				   int(level0.colors_gradient.attribute("top_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom").toString())];
	
	menu_alphas = [int(level0.alphas.attribute("top").toString()),
				   int(level0.alphas.attribute("top_middle").toString()),
				   int(level0.alphas.attribute("bottom_middle").toString()),
				   int(level0.alphas.attribute("bottom").toString())];
	
	//                 gradient_type  colors       alphas      border_color
	menu_FillStyle = ["vertGrad", menu_colors, menu_alphas, int(level0.misc.attribute("border_color").toString())];
	menu_attr = [menu_txt,
				 menu_FillStyle,
				 int(level0.misc.attribute("offset").toString()),
				 button_padding,
				 int(level0.misc.attribute("bar_width").toString()),
				 int(level0.misc.attribute("bar_color").toString())];
	//var menu_attr:Array = [menu_txt, menu_FillStyle, menu_Offset, button_padding, 500, 0x0B66C1];	 //referance
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//process main mouse over view
	level0 = xml_data.properties.main_menu.mouseover_view;
	menu_txt =  [int(level0.text.attribute("color").toString())];
	
	menu_colors = [int(level0.colors_gradient.attribute("top").toString()),
				   int(level0.colors_gradient.attribute("top_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom").toString())];
	
	menu_alphas = [int(level0.alphas.attribute("top").toString()),
				   int(level0.alphas.attribute("top_middle").toString()),
				   int(level0.alphas.attribute("bottom_middle").toString()),
				   int(level0.alphas.attribute("bottom").toString())];
	
	//                 gradient_type  colors       alphas      border_color
	menu_FillStyle = ["vertGrad", menu_colors, menu_alphas, int(level0.misc.attribute("border_color").toString())];
	menu_over_attr = [menu_txt, menu_FillStyle];	
	//var menu_over_attr:Array = [ menu_txt, menu_FillStyle];		//referance
	
////// ===========================================================================================================///////////////
//               process submenu properties ------------------------
	menu_style = xml_data.properties.sub_menu.style.attribute("menu_type").toString();
	level0 = xml_data.properties.sub_menu.default_view;
	button_padding = [int(level0.padding.attribute("top").toString()),
					  int(level0.padding.attribute("left").toString()),
					  int(level0.padding.attribute("right").toString()),
					  int(level0.padding.attribute("bottom").toString())];
	
	menu_txt =  [int(level0.text.attribute("color").toString()),
				 level0.text.attribute("font").toString(),
				 int(level0.text.attribute("size").toString())];
	
	menu_colors = [int(level0.colors_gradient.attribute("top").toString()),
				   int(level0.colors_gradient.attribute("top_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom").toString())];
	
	menu_alphas = [int(level0.alphas.attribute("top").toString()),
				   int(level0.alphas.attribute("top_middle").toString()),
				   int(level0.alphas.attribute("bottom_middle").toString()),
				   int(level0.alphas.attribute("bottom").toString())];
	
	//                 gradient_type  colors       alphas      border_color
	menu_FillStyle = ["vertGrad", menu_colors, menu_alphas, int(level0.misc.attribute("border_color").toString())];
	Smenu_attr = [menu_txt,
				  menu_FillStyle,
				  int(level0.misc.attribute("offset").toString()),
				  button_padding,
				  menu_style];
	//var Smenu_attr:Array = [Smenu_txt, Smenu_FillStyle, Smenu_Offset, button_padding];	 //referance
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//process main mouse over view
	level0 = xml_data.properties.sub_menu.mouseover_view;
	menu_txt =  [int(level0.text.attribute("color").toString())];
	
	menu_colors = [int(level0.colors_gradient.attribute("top").toString()),
				   int(level0.colors_gradient.attribute("top_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom_middle").toString()),
				   int(level0.colors_gradient.attribute("bottom").toString())];
	
	menu_alphas = [int(level0.alphas.attribute("top").toString()),
				   int(level0.alphas.attribute("top_middle").toString()),
				   int(level0.alphas.attribute("bottom_middle").toString()),
				   int(level0.alphas.attribute("bottom").toString())];
	
	//                 gradient_type  colors       alphas      border_color
	menu_FillStyle = ["vertGrad", menu_colors, menu_alphas, int(level0.misc.attribute("border_color").toString())];
	Smenu_over_attr = [menu_txt, menu_FillStyle];
	//var Smenu_over_attr:Array = [ Smenu_txt, Smenu_FillStyle];			//referance
	
	
	/////////////////////////////////////////////////////////////////////////////////
	// process other xml stuff
	level0 = xml_data.properties.buttons_sound;
	snd = [level0.sound.attribute("rollover_url").toString(), level0.sound.attribute("click_url").toString()];
}
