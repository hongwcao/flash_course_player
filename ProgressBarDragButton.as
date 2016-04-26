package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import com.skynetsoft.events.ProgressMouseEvent;
	import flash.globalization.NumberParseResult;
	
	public class ProgressBarDragButton extends MovieClip {
		private var _progressWidth:uint = 786;
		private var _originalX:Number;
		private var _originalY:Number;
		private var _isDrag:Boolean;
		public function getProgressWidth():Number{
			   return _progressWidth;
			}
		public function isDrag():Boolean{
			  return _isDrag;
			}
		public function setIsDrag(ob:Boolean){
			  _isDrag = ob;
			}	
		private function setOriginalX(_x:Number){
			  _originalX = _x;
			}
		private function getOriginalX():Number{
			  return _originalX;
			}	
		private function setOriginalY(_y:Number){
			  _originalY = _y;
			}	
		private function getOriginalY():Number {
			  return _originalY;
			}	
		private var _mask:MaskOfProgress = new MaskOfProgress();
		
		
		public function getMaskOfProgress():MaskOfProgress{
			  return _mask;
			}
		
		private function onStartDrag(evt:MouseEvent){
				this.startDrag(false,new Rectangle(getOriginalX(),getOriginalY(),getProgressWidth(),0));
				stage.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
				this.setIsDrag(true);
			}
		private function setBtnX(_x:Number){
			    this.x = _x;
			}	
		public function onStopDrag(evt:MouseEvent){
			    this.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag);
				this.setIsDrag(false);
			}	
		private function onDragBtnMouseClick(evt:MouseEvent){
				var evtClick:ProgressMouseEvent = new ProgressMouseEvent(ProgressMouseEvent.CLICK); 
				evtClick.setStageX(evt.stageX);
				evtClick.setStageY(evt.stageY);
				evt.stopImmediatePropagation();
				dispatchEvent(evtClick);
			}	
		private function regEvents(ob:ProgressBarDragButton){
			    
				ob.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag);
				ob.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
				ob.addEventListener(MouseEvent.CLICK,onDragBtnMouseClick);
				//ob.addEventListener(MouseEvent.MOUSE_OUT,onStopDrag);
			}	
		public function ProgressBarDragButton() {
			this.x = 9.75;
			this.y = 14.10;
            setOriginalX(this.x);
			setOriginalY(this.y);
			addChild(_mask);
			this.buttonMode = true;
			regEvents(this);
		}
		public function autoMoveBtn(_currFrame:uint,_totFrames:uint):void{
			  setBtnX(_currFrame/(_totFrames/getProgressWidth()));
			}
	}
	
}
