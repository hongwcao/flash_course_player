package com.skynetsoft.util {
	import com.yahoo.astra.fl.controls.AutoComplete
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import com.skynetsoft.util.Constant;
	import flash.events.Event;
    import flash.net.URLRequest;
	import fl.events.ComponentEvent;
	import flash.events.MouseEvent;

	public class AcronymsCompleted extends MovieClip{
		
		//初始化自动完成控件声明
        private var _autoComplete:AutoComplete;
	    private var _loader:URLLoader;
		private var _xml:XML;

		private function setData(ob:XML){
			  _xml = ob;
			}
		public function getData():XML{
			  return _xml;
			}	
		
		//初始化缩略词
		private function initLoader(){
            _loader = new URLLoader();
			var _url:URLRequest = new URLRequest(Constant.ACRONYMS_XML);
			_loader.addEventListener(Event.COMPLETE, onLoaded);
			_loader.load(_url);
			}	
		//载入外部缩略词的信息
		private function onLoaded(evt:Event){
			  //var _xml:XML = new XML((URLLoader)(evt.target).data);
			  this.setData(new XML((URLLoader)(evt.target).data));
			  this._autoComplete.dataProvider = new DataProvider(this.getData());
			  this._autoComplete.labelField = "acronym";
			  this._autoComplete.x = 10;
			  this._autoComplete.y = 50;
			  this._autoComplete.width = 250;
			  this._autoComplete.setStyle("textFormat",Constant.getDefaultTextFormat());
			  //Have it fill in the text field with the most likely entry
              this._autoComplete.autoFillEnabled = true;
              //Replace the default filter so it returns airport code or city matches as well
              this._autoComplete.filterFunction = acronymsFilterFunction;
              //add it to the stage
              this.addChild(_autoComplete);
			}
		//forego the default filter function to return items that match acronym, details, or en
        private function acronymsFilterFunction(element:*, index:int = 0, arr:Array = null):Boolean 
           {
	           var txt:String = _autoComplete.text.toLowerCase();
	           var willWork:Boolean =  (element.acronym.toLowerCase().substring(0,txt.length) == txt) ||
							(element.details.toLowerCase().substring(0,txt.length) == txt) ||
							(element.en.toLowerCase().substring(0,txt.length) == txt);

	           return willWork;
            }
		private function registerEvents(ob:AcronymsCompleted){
			  ob.addEventListener(ComponentEvent.ENTER,onEnterKeyDown);
			  ob.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownUp);
			  ob.addEventListener(MouseEvent.MOUSE_UP,onMouseDownUp);
			}
		//终止在控件上的鼠标操作事件的传播	
	    private function onMouseDownUp(evt:MouseEvent){
			  evt.stopImmediatePropagation();
			}		
		
		private function onEnterKeyDown(evt:ComponentEvent){
			  evt.stopImmediatePropagation();
			  var _autoCompEvt:AutoCompleteEvent = new AutoCompleteEvent(AutoCompleteEvent.FINISH);
			  _autoCompEvt.setInputText(this._autoComplete.text);
			  this.dispatchEvent(_autoCompEvt);
			}
		public function AcronymsCompleted() {
			// constructor code
			_autoComplete = new AutoComplete();
			initLoader();
			registerEvents(this);
			//_autoComplete.dataProvider = new DataProvider(_airports);
		}
	}

}
