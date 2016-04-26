package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.transitions.Tween;
	import com.skynetsoft.util.Constant;
	import fl.transitions.easing.None;
	import fl.transitions.TweenEvent;
	import com.skynetsoft.util.Dialog;
	import com.skynetsoft.util.GlobalDialogHandler;
	import flash.events.MouseEvent;

    //目录面板类
	public class CategoryPanel extends Dialog {
		//内容与遮罩的精度偏差值
		private static const contentOffset:Number = -50;
		//声明卷帘对象
		private var _curtain:CurtainOfCategory;
		//声明目录内容对象
		private var _content:ContentOfCategory;
        //声明面板状态对象
		private var _panelStatus:String;				
		
		private function setCurtain(ob:CurtainOfCategory){
			  _curtain = ob;
			}
		private function getCurtain():CurtainOfCategory{
			  return _curtain;
			}	
		private function setContent(ob:ContentOfCategory){
			  _content = ob;
			}	
		public function getContent():ContentOfCategory{
			   return _content;
			}
		private function setPanelStatus(ob:String){
			  _panelStatus = ob;
			}
		private function getPanelStatus():String {
			   return _panelStatus;
			}
			
		//目录对象构造函数
		public function CategoryPanel() {
			this.x =0;
			this.y =0;
			setCurtain(new CurtainOfCategory());
			setContent(new ContentOfCategory());
			this.addChild(getContent());
			this.addChild(getCurtain());
			setContentMask(getCurtain().getMask());
			this.filters = new Array(Constant.getDefaultDropShadow());
			this.setPanelStatus(PanelStatusType.READY);
			this.visible = false;
		}
		private function setContentMask(ob:MaskOfCurtain){
			   getContent().mask = ob;
			}
		
		
		//对话框显示缓动动画
		override public function doMotionStart(_ob:Boolean){
			  //var tw:Tween;
			  getCurtain().y = -80;
			  _tw = new Tween(getCurtain(),"y",None.easeNone,getCurtain().y,getContent().height-50,Constant.MOTION_SPEED,true);
			  //tw = new Tween(this,"alpha",None.easeOut,0,1,Constant.MOTION_DIALOG_SPEED,true);
		      _tw.stop();
		      //注册退出对话框动画的缓动MOTION_START事件侦听
		      if (_ob == true) {
			     _tw.addEventListener(TweenEvent.MOTION_START,onDialogMotionCome);
			     }
			  _tw.start();
			}
		//对话框隐藏缓动动画	
		override public function doMotionEnd(_ob:Boolean){
			  //var tw:Tween;
			  _tw = new Tween(getCurtain(),"y",None.easeNone,getContent().height-50,getCurtain().getOriginalY(),Constant.MOTION_DIALOG_SPEED,true);				
			  //tw = new Tween(this,"alpha",None.easeOut,1,0,Constant.MOTION_DIALOG_SPEED,true);
		      _tw.stop();
			  _tw.addEventListener(TweenEvent.MOTION_FINISH,onDialogMotionFinish);
			  if (_ob == true) {
			      _tw.addEventListener(TweenEvent.MOTION_START,onDialogMotionBack);
			      }
			  _tw.start();
			}	
	}
	
}
