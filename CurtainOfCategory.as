package  {
	
	import flash.display.MovieClip;
	import com.skynetsoft.util.Constant;
	
	//目录卷帘控制类
	public class CurtainOfCategory extends MovieClip {
		
		private var _controlBar:ControlBarOfCurtain;
		private var _mask:MaskOfCurtain;
		private var _originalY:Number = -80;
		private var _originalX:Number = 2;
		private function setControlBar(ob:ControlBarOfCurtain){
			  _controlBar = ob;
			}
		private function getControlBar(){
			  return _controlBar;
			}	
		private function setMask(ob:MaskOfCurtain){
			  _mask = ob;
			}
		public function getMask(){
			  return _mask; 
			}	
			
		public function getOriginalY():Number{
			  return _originalY;
			}	
		public function getOriginalX():Number{
			  return _originalX;
			}	
		//构建函数
		public function CurtainOfCategory() {
			this.x = this.getOriginalX();
			this.y = this.getOriginalY();
			setMask(new MaskOfCurtain());
			setControlBar(new ControlBarOfCurtain());
			addChild(getMask());
			addChild(getControlBar());
			//this.filters = Constant.DROP_SHADOW_FILTER;
		}
	}
	
}
