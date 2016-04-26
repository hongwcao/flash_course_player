package  {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import com.skynetsoft.util.Constant;
	
	
	public class HomeButton extends SimpleButton {
		//构造函数
		private var _active:Boolean = false;
		private function setActiveStatus(b:Boolean) {
			  this._active = b;
			}
		private function getActiveStatus():Boolean{
			  return this._active;
			}	
	
		public function HomeButton() {
			this.x =33;
			this.y = 695.8;
			this.filters = new Array(Constant.getDefaBtnDpShadow());
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseClick);
		}
		
		public function onMouseClick(evt:MouseEvent){
			if (getActiveStatus()) { 
			   //todo
			   //dispatchEvent(new Event("1"));
			}  else {
			   //todo
			   //dispatchEvent(new Event("2"));	
			}
			exchangeActiveStatus()
		}
		private function exchangeActiveStatus(){
			 setActiveStatus(!getActiveStatus());
			}
	}
	
}
