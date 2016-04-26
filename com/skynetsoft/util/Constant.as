package com.skynetsoft.util {
	import flash.filters.DropShadowFilter;
	import flash.sampler.StackFrame;
	import flash.text.TextFormat;
	import com.skynetsoft.util.LanguageType;
	import com.skynetsoft.util.LocalType;
	import com.skynetsoft.util.SwitchType;

	//常量类
	public class Constant {
        //定义配置文件的路径名称
		public static const INFO_DIR:String = "info";
		//定义内容文件的路径名称
		public static const CONTENT_DIR:String ="content";
		//定义语音文件的路径名称
		public static const SOUND_DIR:String ="content/sounds";
		//定义默认的内容文件名称
		public static const DEF_URL:String ="introduction";
		//定义默认的内容文件后缀 c
		public static const DEF_CODE:String = "swf";
		//定义默认的内容文件 key码
		public static const DEF_KEY:String ="{AC125273-2B23-49E9-9EF9-4D7C085BE90D}";
		//定义激活状态的颜色值
		public static const COLOR_ACTIVE:uint = 0x2184CE;
        //定义未激活状态的颜色值
		public static const COLOR_DEACTIVE:uint = 0x9E9E9E;
        //定义缓动的速率
		public static const MOTION_SPEED:Number= 2;
        //定义对话框缓动的速率
		public static const MOTION_DIALOG_SPEED:Number=0.5;
        //定义按钮缓动的速率
		public static const MOTION_BUTTON_SPEED:Number=0.2;
		//定义退出对话框的舞台深度
		public static const TOP_LEVEL:Number =9;
		//定义顶部装饰栏的舞台深度
		public static const TOP_BAR_LEVEL:Number =8;
		//定义目录面板的舞台深度
		public static const CATEGORY_LEVEL:Number =7;
		//定义内容容器遮罩的舞台深度
		public static const CONTENT_MASK_LEVEL:Number = 6;
		//定义系统对话框缓动开始事件
		public static const SYSTEM_DIALOG_MOTION_START_EVENT:String = "SYSTEM_DIALOG_MOTION_START";
		//定义系统对话框缓动完成事件
		public static const SYSTEM_DIALOG_MOTION_FINISH_EVENT:String = "SYSTEM_DIALOG_MOTION_FINISH";
		//定义遮罩的ahpha终值
		public static const MASK_ALPHA_FINAL:Number = 0.6;
		//定义目录配置文件的路径
		public static const CATEGORY_XML:String = INFO_DIR+"/"+"category.xml";
		//定义缩略词配置文件的路径
		public static const ACRONYMS_XML:String = INFO_DIR+"/"+"acronyms.xml";
		//定义默认的内容对象的绝对定位
		public static const CONTENT_X:Number = 0;
		public static const CONTENT_Y:Number = 50;
		public static const DEFAULT_HEIGHT:Number = 647;
		public static const DEFAULT_WIDTH:Number = 1024;
		//定义播放进度条的延迟隐藏时间
		public static const DELAY_TIME:uint = 5000;
		//初始化默认语言及语音值
		private static var _language:String = LanguageType.EN;
		private static var _speakAudio:String = LanguageType.EN;
		private static var _key:String = DEF_KEY;
		private static var _currURL:String;
		private static var _currCode:String;
		private static var _categoryIsLoaded:Boolean = false;
		private static var _progressLevel:uint = 0;
		private static var _subtitleSwitch:String = SwitchType.CLOSE;
		
		public static function set subtitleSwitch(s:String):void{
			     _subtitleSwitch = s;
			}
		public static function get subtitleSwitch():String{
			     return _subtitleSwitch;
			}	
		public static function set progressLevel(n:uint):void{
			    _progressLevel = n;
			}
		public static function get progressLevel():uint{
			   return _progressLevel;
			}	
		public static function set categoryIsLoaded(b:Boolean):void{
			   _categoryIsLoaded = b;
			}
		public static function get categoryIsLoaded():Boolean{
			   return _categoryIsLoaded;
			}
		public static function set currURL(s:String):void{
			  _currURL = s;
			}
		public static function get currURL():String{
			  return _currURL;
			}	
		public static function set currCode(s:String):void{
			  _currCode = s; 
			}
		public static function get currCode():String{
			   return _currCode;
			}	
		public static function getCurrentKey():String{
			  return _key;
			}
		public static function setCurrentKey(ob:String):void{
			  _key = ob;
			}	
		
		public static function setLanguage(ob:String){
			   _language = ob;
			}
		public static function getLanguage():String{
			   return _language;
			}	
			
		public static function setSpeakAudio(ob:String){
			  _speakAudio = ob; 
			}
		public static function getSpeakAudio():String{
			  return _speakAudio;
			}	
		//构造函数
		public function Constant() {
              
		}
		//默认全局变量初始化
		public static function init(){
			  //默认使用中文语言和中文语音
			  setLanguage(LanguageType.CN);
			  setSpeakAudio(LanguageType.CN);
			}
		public static function getDefaultDropShadow():DropShadowFilter{
			   var ob:DropShadowFilter = new DropShadowFilter();
			   ob.distance = 5;
			   ob.alpha =1;
			   ob.blurX =5;
			   ob.blurY =5;
			   ob.color =0x000000;
			   ob.quality =1;
			   ob.strength =0.5;
			   ob.inner = false;
			   ob.knockout =false;
			   return ob;
			}
			
		public static function getDefaBtnDpShadow():DropShadowFilter{
			   var ob:DropShadowFilter = new DropShadowFilter();
			   ob.distance = 3;
			   ob.alpha =1;
			   ob.blurX =3;
			   ob.blurY =3;
			   ob.color =0x000000;
			   ob.quality =1;
			   ob.strength =0.5;
			   ob.inner = false;
			   ob.knockout =false;
			   return ob;
			}
			
		public static function getDefaultTextFormat():TextFormat{
			  var _textfmt:TextFormat = new TextFormat();
			  _textfmt.font ="宋体";
			  _textfmt.size = 13;
			  return _textfmt;
			}
		public static function getDefaultMessageTextFormat():TextFormat{
			  var _textfmt:TextFormat = new TextFormat();
			  _textfmt.font ="宋体";
			  _textfmt.size = 155;
			  _textfmt.color = 0xFF0000;
			  return _textfmt;
			}	
		public static function getCurrentLanguage():String{
			   var result:String;
			   if (getLanguage().toString() ==  LanguageType.CN) {
				     result = LocalType.CN;
				   }
			   else if (getLanguage().toString() == LanguageType.EN ) {
				     result = LocalType.EN;
				   }  
			   return result;	   
			}	
	   public static function getCurrentSpeakAudio():String{
		         var result:String;
			   if (getSpeakAudio().toString() ==  LanguageType.CN) {
				     result = LocalType.CN;
				   }
			   else if (getSpeakAudio().toString() == LanguageType.EN ) {
				     result = LocalType.EN;
				   }  
			   return result;	   
		   }
		 
	}
	
}
