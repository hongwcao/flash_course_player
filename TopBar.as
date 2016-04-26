package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import com.skynetsoft.events.CategoryTitleRefreshEvent;

	public class TopBar extends MovieClip {
		private var _title:TextField = new TextField();
		private var _fmt:TextFormat = new TextFormat();
		
		private function setTitle(ob:TextField){
			   _title = ob;
			}
		private function getTitle():TextField{
			   return _title;
			}		
			
		private function initTitle(ob:TextField){
			  ob.x = 200;
			  ob.y = 7.1;
			  ob.height = 35.7;
			  //ob.width = 484.5;
			  ob.width = 600;
			  ob.text = "---";
			  ob.type = flash.text.TextFieldType.DYNAMIC;
			  ob.mouseEnabled = false;
			  ob.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			  ob.multiline = true;
			  //ob.embedFonts = true;
			  setTitle(ob);
			}	
		
		private function setTitleText(ob:String){
			  getTitle().text = ob;
			}
			
		public function TopBar() {
			this.x = 0;
			this.y =0;
			initTitle(getTitle());
            getTitle().setTextFormat(getTextFormat());
    		addChild(getTitle());
		}
		private function getTextFormat():TextFormat{
			  _fmt.align = flash.text.TextFormatAlign.LEFT;
    		  //_fmt.color = 0x667D84;
			  _fmt.color = 0xcccccc;
			  _fmt.font = "微软雅黑";
			  _fmt.size = 20;
			  _fmt.bold = false;
			  return _fmt;
		}	
		
		public function onRefreshTitle(_evt:CategoryTitleRefreshEvent){
			   trace(_evt.getTitleText());
			   setTitleText(_evt.getTitleText());
			   getTitle().setTextFormat(getTextFormat());
			}	
		
	}
	
}
