package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.skynetsoft.util.Constant;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
    import flash.geom.Point;
    import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.Bounce;
	import com.skynetsoft.events.FrameLabelEvent;
	import com.skynetsoft.util.SubtitleType;
	import com.skynetsoft.events.SwitchButtonEvent;
	import com.skynetsoft.util.SwitchType;
	import com.skynetsoft.events.SubtitleEnableEvent;
	//字幕控件类
	public class Subtitle extends MovieClip {
		
		//private var initPoint:Point =new Point(2,612);
		private var initPoint:Point =new Point(2,580);
		//定义滚动字幕字段
		private var _scrollText:TextField;
	    //定义字幕控件的活动点
		private var _xy:Array = new Array(initPoint,new Point(2,684));										   
		//private var _xy:Array = new Array(new Point(250,2),new Point(2,600),new Point(200,710),new Point(460,60));
		private var _i:Number = 0;
		
		//定义字幕的热区
		private var hotspot4Subtitles:HotSpot4Subtitles = new HotSpot4Subtitles();
		
		private function getXY():Point{
			   if ((_i >= 0 ) && (_i <= 1)) {
			    ++_i
			   } else {
			    _i = 0; 
			  }
			  return _xy[_i];
			}
		private function getXY2():Point{
			  if (_i == -1){
				   _i = 0;
				   return _xy[_i];
			  }else if (_i == 0){
				   _i = 1  
				   return _xy[_i]
			  }else if (_i == 1){
				   _i = 0; 
				   return _xy[_i];
			  }
			  return _xy[0]; 	  
			}	
		private function getTextFormat():TextFormat{
			 var _fmt = new TextFormat();
             //常用样式
             _fmt.align = "left";
             //my_fmt.blockIndent = 50; //区块缩进
             //my_fmt.bold = true;
             //my_fmt.bullet = true;
             //_fmt.color = 0xffffff;
			 _fmt.color = 0xcccccc;
             _fmt.font = "微软雅黑";
             //my_fmt.indent = 50; //首字缩进
             //my_fmt.italic = true;
             _fmt.kerning = true; //字距调整
             _fmt.leading = 1; //行距
             //my_fmt.letterSpacing = 10; //字间距
             //my_fmt.leftMargin = 10;
             //my_fmt.rightMargin = 10;
             _fmt.size = 16;
             //my_fmt.underline = true;
             //my_fmt.target = "blank"
			 return _fmt;
			}
		public function setScrollText(ob:String){
			  _scrollText.text = ob;
			}	
		private function get scrollText():String {
			   return _scrollText.text;
			}	
		private function registerEvents(ob:Subtitle) {
			   //ob.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownDrag);
			   //ob.addEventListener(MouseEvent.MOUSE_UP,onMouseUpDrag);
			   //ob.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleMouseClick);
			   //ob.addEventListener(MouseEvent.MOUSE_OVER,onDoubleMouseClick);
			   hotspot4Subtitles.addEventListener(MouseEvent.MOUSE_OVER, onDoubleMouseClick);
			}
		private function onDoubleMouseClick(e:MouseEvent):void{
			   e.stopImmediatePropagation();
			   var _point:Point = this.getXY2();
			   //var _xtw:Tween = new Tween(this,"x",None.easeNone,this.x,_point.x,Math.random(),true);
			   var _ytw:Tween = new Tween(this,"y",	Bounce.easeOut,this.y,_point.y,1,true);
			   //var _ytw:Tween = new Tween(this,"y",	Elastic.easeOut,this.y,_point.y,1,true);
			   _ytw.start();
 			}
		private function onMouseDownDrag(evt:MouseEvent){
			   (evt.target as Subtitle).startDrag(false,new Rectangle(0,0,1024,768));
			}
		
		private function onMouseUpDrag(evt:MouseEvent){
			   (evt.target as Subtitle).stopDrag();
			}
		//初始化字
    	private function initTextField(){
                _scrollText = new TextField();
				
				this._scrollText.mouseEnabled = false;
				this._scrollText.wordWrap = true;
				this._scrollText.x = 3;
				this._scrollText.y = 3;
				this._scrollText.width = 1010;
				this._scrollText.height =  80;
				this._scrollText.type = TextFieldType.INPUT;
				this._scrollText.text = "";
				this._scrollText.setTextFormat(getTextFormat());
				this.hotspot4Subtitles.alpha = 0;
				this.hotspot4Subtitles.x =3;
				this.hotspot4Subtitles.y =15;
				this.addChild(_scrollText);
				this.addChild(hotspot4Subtitles);
			}
		
		
		public function onExecute(e:FrameLabelEvent):void{
				if (e.subtitle.length == 0) {
					 this.visible =false;
					}  else {
						this.visible = true;
					}
				if (e.subType == SubtitleType.NORMAL) {
				     this.setScrollText(e.subtitle);
				    }
				else if (e.subType == SubtitleType.JOIN) {
					  this.setScrollText(this.scrollText + " " +e.subtitle);
					}	
				this._scrollText.setTextFormat(getTextFormat());
			}
		public function checkEnable(evt:SwitchButtonEvent):void	{
			    trace("checkEnable"+evt.getParam());
				if (evt.getParam() == SwitchType.OPEN) {
					   this.visible = false;
					}
				else if (evt.getParam() == SwitchType.CLOSE){
					   this.visible = true;
				}
				evt.stopImmediatePropagation()
			}
		//字幕面板启动或关闭函数
		public function enableStatus(evt:SubtitleEnableEvent):void {
			  trace("enableStatus"+evt.getParam());
			  if (evt.getParam() == true) {
			      this.visible = true;
			  }else if (evt.getParam() == false) {
				  this.visible = false;  
			  } 
			  evt.stopImmediatePropagation();
			}
		//字幕构造函数
		public function Subtitle() {
			// constructor code
			this.x = initPoint.x;
			this.y = initPoint.y;
			//this.alpha = 0;
			this.filters = new Array(Constant.getDefaultDropShadow());
			this.doubleClickEnabled = true;
			initTextField();
			registerEvents(this);
		}
	}
	
}
