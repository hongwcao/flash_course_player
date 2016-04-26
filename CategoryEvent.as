package  {
	import fl.events.ListEvent;
	public class CategoryEvent extends ListEvent{
        public static const ITEM_CLICK:String = "item_click";
		public static const COMPLETED_PROCRESS:String = "completed_process";
		public static const INIT_LOADED:String ="init_loaded";
		private var _label:String;
		private var _url:String;
		private var _code:String;
		private var _key:String;
		private var _completedProcess:String
		private var _path:String;
		public function setLabel(label:String):void{
			  _label = label;
			}
		public function getLabel():String{
			  return _label;
			}
		public function setPath(path:String):void{
			  _path = path;
			}
		public function getPath():String{
			  return _path;
			}
		public function setURL(ob:String):void{
			  _url = ob;
			}
		public function getURL():String{
			  return _url
			}	
		public function setCode(ob:String):void{
			  _code = ob;
			}	
		public function getCode():String{
			  return _code;
			}	
		public function getKey():String{
			  return _key;
			}	
		public function setKey(ob:String):void{
			  _key = ob;				   
            }	
		public function setCompletedProcess(ob:String){
			  _completedProcess = ob;
			}	
		public function getCompletedProcess():String{
			  return _completedProcess;
			}	
		public function CategoryEvent(evtType:String) {
			super(evtType);
		}

	}
	
}
