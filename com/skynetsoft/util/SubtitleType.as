package com.skynetsoft.util {
	
	public class SubtitleType {
        public static const JOIN:String = "join";
		public static const NORMAL:String = "normal";
		private var _subtitle:String;
		private var _type:String;
		private var _label:String;
		public function set subtitle(s:String):void{
			  _subtitle = s;
			}
		public function get subtitle():String{
			  return  _subtitle;
			}	
		public function set type(t:String):void{
			  _type = t;
			}	
		public function get type():String{
			  return _type;
			}	
		public function set label(l:String):void{
			  _label = l;
			}	
		public function get label():String{
			  return _label;
			}	
		public function SubtitleType() {
			// constructor code
		}
		public function toString():String{
			   return this.label+"|"+this.subtitle+"|"+this.type;
			}


	}
	
}
