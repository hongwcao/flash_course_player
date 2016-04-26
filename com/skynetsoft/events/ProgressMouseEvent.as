package com.skynetsoft.events {
	import flash.events.MouseEvent;
	public class ProgressMouseEvent extends MouseEvent{
        public static const CLICK:String = "progress_click";
		public static const PLAY_BUTTON_CLICK:String ="play_button_click";
		public static const PAUSE_BUTTON_CLICK:String ="pause_button_click";
		public static const MOUSE_OUT:String = "mouse_out";
		public static const MOUSE_OVER:String = "mouse_over";
		private var _stageX:Number;
		private var _stageY:Number;
		public function getStageX():Number{
			 return _stageX;
			}
		public function getStageY():Number{
			 return _stageY;
			}	
		public function setStageX(ob:Number){
			 _stageX = ob;
			}	
		public function setStageY(ob:Number){
			 _stageY = ob;
			}	
		public function ProgressMouseEvent(evtType:String) {
			super(evtType);
		}

	}
	
}
