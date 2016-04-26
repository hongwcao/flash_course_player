package com.skynetsoft.events {
	import flash.events.Event;
	public class FrameLabelEvent extends Event{
        public static const FRAME_LABEL_CHANGED:String = "frame_label_changed";
		public static const FRAME_LABEL_SKIP:String = "frame_label_skip";
		public static const FRAME_LABEL_ENDED:String = "frame_label_ended";
		private var _frameLabel:String;
		private var _url:String;
		private var _subtitle:String
		private var _subType:String
		public function set subType(t:String):void{
			    _subType = t;
			}
		public function get subType():String{
			    return _subType;
			}	
		public function set subtitle(s:String):void{
			   _subtitle =s;
			}
		public function get subtitle():String{
			   return _subtitle;
			}	
		public function set url(u:String):void{
			  _url = u;
			}
		public function get url():String{
			  return _url;
			}	
		public function set frameLabel(f:String):void{
			   _frameLabel = f;
			}
		public function get frameLabel():String {
			   return _frameLabel;
			}	
		public function FrameLabelEvent(evtType:String) {
			super(evtType);
			// constructor code
		}

	}
	
}
