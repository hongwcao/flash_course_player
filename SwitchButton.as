package  {
	import flash.display.MovieClip;
	import com.skynetsoft.util.Constant;
	import com.skynetsoft.util.LanguageType;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import fl.transitions.TweenEvent;
	import com.skynetsoft.events.SwitchButtonEvent;
	import com.skynetsoft.util.SwitchType;

	public class SwitchButton extends MovieClip {
		private var cnBtn:ButtonOfCNTitle;
		private var enBtn:ButtonOfENTitle;
		private var openBtn:ButtonOfOpenTitle;
		private var closeBtn:ButtonOfCloseTitle;
		public function SwitchButton(_x:Number,_y:Number,_local:String) {
		       this.x = _x;
			   this.y = _y;
			   cnBtn = new ButtonOfCNTitle();
			   enBtn = new ButtonOfENTitle();
     		   openBtn = new ButtonOfOpenTitle();
			   closeBtn = new ButtonOfCloseTitle();
			   initBtnTitle(_local);
			   addChild(cnBtn);
			   addChild(enBtn);
			   addChild(openBtn);
			   addChild(closeBtn);
			   this.buttonMode = true;
			   //this.useHandCursor =false;
			   regEvents();
		}
		private function initBtnTitle(_local:String){
			   cnBtn.visible = false;
			   enBtn.visible = false;
			   openBtn.visible = false;
			   closeBtn.visible = false;
               if (_local == LanguageType.CN) {
				     cnBtn.visible = true;
				   }
			   else if ( _local == LanguageType.EN) {
					  //cnBtn.visible = false;
					  enBtn.visible = true;                                                                                                                         
				   }
			   else if ( _local == SwitchType.OPEN ){
				      openBtn.visible = true; 
				   }
			   else if ( _local == SwitchType.CLOSE){
				      closeBtn.visible = true; 
				   }	   
		}
		private function regEvents(){
			   this.addEventListener(MouseEvent.CLICK,onExecute);          
			}
		private function isSwitchButton():Boolean{
			   return (openBtn.visible || closeBtn.visible);
			}
		private function onExecute(evt:MouseEvent){
			   evt.stopImmediatePropagation();
			   var tween:Tween;
			   if (isSwitchButton()){
				  if (openBtn.visible == true) {
				      tween = new Tween(openBtn,"alpha",None.easeOut,1,0,Constant.MOTION_BUTTON_SPEED,true);
		              tween.stop();
		              //注册退出对话框动画的缓动MOTION_START事件侦听
		              tween.addEventListener(TweenEvent.MOTION_START,onCloseMotionCome);
		              tween.addEventListener(TweenEvent.MOTION_FINISH,onOpenMotionBack); 
 				  }
				  else if (closeBtn.visible == true) {
					  tween = new Tween(closeBtn,"alpha",None.easeOut,1,0,Constant.MOTION_BUTTON_SPEED,true);
		              tween.stop();
		              //注册退出对话框动画的缓动MOTION_START事件侦听
		              tween.addEventListener(TweenEvent.MOTION_START,onOpenMotionCome);
		              tween.addEventListener(TweenEvent.MOTION_FINISH,onCloseMotionBack);   
				   }
			      }
			   else {	   
			      if (cnBtn.visible == true) {
				      tween = new Tween(cnBtn,"alpha",None.easeOut,1,0,Constant.MOTION_BUTTON_SPEED,true);
		              tween.stop();
		              //注册退出对话框动画的缓动MOTION_START事件侦听
		              tween.addEventListener(TweenEvent.MOTION_START,onENMotionCome);
		              tween.addEventListener(TweenEvent.MOTION_FINISH,onCNMotionBack);
				      }
				   else if (enBtn.visible == true) {
				      tween = new Tween(enBtn,"alpha",None.easeOut,1,0,Constant.MOTION_BUTTON_SPEED,true);
		              tween.stop();
		              //注册退出对话框动画的缓动MOTION_START事件侦听
		              tween.addEventListener(TweenEvent.MOTION_START,onCNMotionCome);
		              tween.addEventListener(TweenEvent.MOTION_FINISH,onENMotionBack); 
				      }
			     }
				tween.start();
				
			}	
			
		public function onStatusChange(_status:String){
			   var evt:SwitchButtonEvent = new SwitchButtonEvent(SwitchButtonEvent.ON_CHANGE);
			   evt.setParam(_status);
			   dispatchEvent(evt);
			}	
		private function onCNMotionBack(evt:TweenEvent){
				evt.stopImmediatePropagation();
				this.cnBtn.visible = false; 
				onStatusChange(LanguageType.EN);
			}	
		private function onENMotionBack(evt:TweenEvent){
				evt.stopImmediatePropagation();
				this.enBtn.visible = false;
				onStatusChange(LanguageType.CN);
				//this.mouseEnabled = true;
			}
		
		private function onENMotionCome(evt:TweenEvent){
			   evt.stopImmediatePropagation();
			   //this.cnBtn.visible = false;
			   this.enBtn.visible = true;
			   var tween:Tween;
			   tween = new Tween(enBtn,"alpha",None.easeOut,0,1,Constant.MOTION_BUTTON_SPEED,true);
			   tween.stop();
			   this.mouseEnabled = false;
			   tween.start();
			}	
		private function onCNMotionCome(evt:TweenEvent){
			   evt.stopImmediatePropagation();
			   this.cnBtn.visible = true;
			   var tween:Tween;
			   tween = new Tween(cnBtn,"alpha",None.easeOut,0,1,Constant.MOTION_BUTTON_SPEED,true);
			   tween.stop();
			   this.mouseEnabled = false;
			   tween.start();
			}	
    	
		private function onOpenMotionBack(evt:TweenEvent){
				evt.stopImmediatePropagation();
				this.openBtn.visible = false; 
				onStatusChange(SwitchType.CLOSE);
			}	
		private function onCloseMotionBack(evt:TweenEvent){
				evt.stopImmediatePropagation();
				this.closeBtn.visible = false;
				onStatusChange(SwitchType.OPEN);
				//this.mouseEnabled = true;
			}
		private function onOpenMotionCome(evt:TweenEvent){
			   evt.stopImmediatePropagation();
			   this.openBtn.visible = true;
			   var tween:Tween;
			   tween = new Tween(openBtn,"alpha",None.easeOut,0,1,Constant.MOTION_BUTTON_SPEED,true);
			   tween.stop();
			   this.mouseEnabled = false;
			   tween.start();
			}		
		private function onCloseMotionCome(evt:TweenEvent){
			   evt.stopImmediatePropagation();
			   //this.cnBtn.visible = false;
			   this.closeBtn.visible = true;
			   var tween:Tween;
			   tween = new Tween(closeBtn,"alpha",None.easeOut,0,1,Constant.MOTION_BUTTON_SPEED,true);
			   tween.stop();
			   this.mouseEnabled = false;
			   tween.start();
			}	

	}//end SwitchButton class
}//end package
