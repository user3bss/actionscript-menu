// would be good to create an abstract class for data IO
//  start with wrappers for this app and this data for XML
//  then for JSON/ AMF etc.
//
// then abstract the data
// 

//var file0 = xmlFile;
//trace(file0);
// for external file paths/ try looking at
//http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/external/ExternalInterface.html
//
// or search for Flash vars here is an example
//http://www.afcomponents.com/tutorials/img_loop/3/
//
// one example I saw had urlvariables at least what looked like
//<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="766" height="56">
//<param name="movie" value="/flash/menu.swf?xmlPath=/flash/settings.xml&amp;menuTextColor=0x6b513d&amp;overMenuTextColor=0x4A1F02&amp;menuColor=0xe1dcd9&amp;submenuTextColor=0x7C7169&amp;overSubmenuTextColor=0x4A1F02&amp;submenuColor=0xe1dcd9&amp;submenuOverColor=0xcec6c2&amp;selectedMenuLight=0&amp;selectedSubmenuLight=0" />
//<param name="quality" value="high" />
//<embed src="/flash/menu.swf?xmlPath=/flash/settings.xml&amp;menuTextColor=0x6b513d&amp;overMenuTextColor=0x4A1F02&amp;menuColor=0xe1dcd9&amp;submenuTextColor=0x7C7169&amp;overSubmenuTextColor=0x4A1F02&amp;submenuColor=0xe1dcd9&amp;submenuOverColor=0xcec6c2&amp;selectedMenuLight=0&amp;selectedSubmenuLight=0" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="766" height="56"></embed>
//</object>

var xml_data:XML;
var xmlLoader:URLLoader = new URLLoader();
xmlLoader.load(new URLRequest("menu.xml"));
xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);

function xmlLoaded(event:Event):void{
	xml_data = new XML(event.target.data);
	parseData();
	//trace(event.target.data);	//trace(xml);
	//xmlList.length();
}