package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.skynetsoft.events.ProgressMouseEvent;
	
	
	public class Progress extends MovieClip {
		
		private function regEvents(ob:Progress){
			   ob.addEventListener(MouseEvent.CLICK,onProgressMouseClick);
			}
		private function onProgressMouseClick(evt:MouseEvent){
			    var evtClick:ProgressMouseEvent = new ProgressMouseEvent(ProgressMouseEvent.CLICK); 
				evtClick.setStageX(evt.stageX);
				evtClick.setStageY(evt.stageY);
				evt.stopImmediatePropagation();
				dispatchEvent(evtClick);
			}	
		public function Progress() {
			this.x = 6;
			this.y = 12;
			regEvents(this);
		}
	}
	
}
