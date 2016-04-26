package  {
	//import flash.events.Event;
	import fl.events.ComponentEvent
	import com.skynetsoft.util.Constant;
	//定义自动完成组建的事件类
	public class AutoCompleteEvent extends ComponentEvent{
        //public static const ENTER:String=AutoCompleteEventType.ENTER;
		public static const FINISH:String = "finish";
		private var _inputText:String;
		public function setInputText(ob:String){
			   _inputText = ob;
			}
		public function getInputText():String{
			   return _inputText;
			}	
		public function AutoCompleteEvent(eventType:String) {
			super(eventType);
		}
  }
}
