package com.skynetsoft.util {
	
	public class ContentMetaType {

		private var _key:String;
		private var _code:String;
		private var _url:String;
		private var _label:String;
		private var _label_en:String;
		private var _lessonStatus:String;
		private var _path:String;
		private var _fullTitle:String;
		private var _fullTitle_en:String;
		
		public function setFullTitle_en(title:String):void{
			  _fullTitle_en = title;
			}
		
		public function getFullTitle_en():String{
			  return _fullTitle_en;
			}
		
		public function setLabel_en(label:String):void{
			   _label_en = label;
			}
		public function getLabel_en():String{
			   return _label_en;
			}
		
		public function setFullTitle(t:String):void{
			   _fullTitle = t;
			}
		public function getFullTitle():String{
			  return _fullTitle;
			}	
		
		public function setKey(key:String):void{
			  _key = key;
			}
		public function getKey():String {
			  return _key;
			}	
		public function setCode(code:String):void{
			  _code = code;
			}	
		public function getCode():String{
			  return _code;
			}	
		public function setURL(url:String):void{
			  _url = url;
			}	
		public function getURL():String{
			  return _url;
			}	
		public function setLabel(label:String):void{
			  _label = label;
			}	
		public function getLabel():String{
			  return _label;
			}	
		public function setLessonStatus(status:String):void{
			  _lessonStatus = status;
			}
		public function getLessonStatus():String {
			  return _lessonStatus;
			}	
		public function setPath(path:String):void{
			  _path = path;
			}
		public function getPath():String{
			  return _path;
			}	
		public function ContentMetaType() {
			// constructor code
		}
		public function toString():String{
			   return getLabel()+"|"+getCode()+"|"+getURL()+"|"+getKey()+"|"+getLessonStatus()+"|"+getPath();
			}

	}
	
}
