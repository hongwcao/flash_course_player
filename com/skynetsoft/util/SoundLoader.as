package com.skynetsoft.util {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	import com.skynetsoft.events.LoaderEvent;
	
	public class SoundLoader extends Loader{
        private var _url:String;
		private var _code:String;
		private var _key:String;
		private var _content:MovieClip;
		private var _speakAudio:String;
		
		public function getSpeakAudio():String{
			   return _speakAudio;
			}
		public function setSpeakAudio(ob:String){
			   _speakAudio = ob;
			}	
		public function getURL():String{
			   return _url;
			}
		public function setURL(ob:String){
			   _url = ob;
			}	
		public function getKey():String{
			   return _key;
			}	
		public function setKey(ob:String){
			   _key = ob;
			}	
		public function getCode():String{
			   return _code;
			}	
		public function setCode(ob:String){
			   _code = ob;
			}	
		private function getContent():MovieClip{
			   return _content;
			}	
		private function setContent(ob:MovieClip){
			   _content = ob;
			}	
			
		public function getCodeURL():String{
			  //trace("sound file url is "+Constant.SOUND_DIR + "/"+getURL() + ".sound."+Constant.getCurrentSpeakAudio()+"."+getCode())
			  return Constant.SOUND_DIR + "/"+getURL() + ".sound."+getSpeakAudio()+"."+getCode(); 
			}
		
		//注册SoundLoader的侦听事件
		private function registerEvents(ob:SoundLoader){
			  //注册在加载操作开始时的事件调度
			  ob.contentLoaderInfo.addEventListener(Event.OPEN,onOpen);
			  //注册当已加载的 SWF 文件的属性和方法可供访问并做好使用准备时进行调度
			  ob.contentLoaderInfo.addEventListener(Event.INIT,onInit);
			  //在下载操作过程中收到数据时调度。
			  ob.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			  ob.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			}
		
		private function onOpen(evt:Event):void{
			
			}
		private function onInit(evt:Event):void{
			    setContent(this.content as MovieClip);
				getContent().stop();
				
			}
		private function onComplete(evt:Event):void{
				var loadEvt:LoaderEvent = new LoaderEvent(LoaderEvent.READY_FOR_PLAY);
				loadEvt.setMediaType("SOUND");
				dispatchEvent(loadEvt);
			}	
		private function onProgress(evt:ProgressEvent):void{
			   var ob:Number = Math.round((evt.bytesLoaded/evt.bytesTotal)*100);
			}	
        //支持外部重载语音文件
		public function reloadSound(evt:MouseEvent){
			  reload(getURL(),getCode(),Constant.getCurrentKey(),getSpeakAudio());    
			}
		public function reload(_url:String,_code:String,_key:String,_speakAudio):void{
			   //var urlReq:URLRequest
			   this.setURL(_url);
			   this.setCode(_code);
			   this.setKey(_key);
			   this.setSpeakAudio(_speakAudio);
			   //Constant.setCurrentKey(_key);
			   loadURL(getCodeURL());
			}	
		public function loadURL(_url:String):void{
			   var urlReq:URLRequest = new URLRequest(_url);
               //this.getContent().stop();
			   this.unloadAndStop()
			   //this.unload();
			   this.load(urlReq);
			}	
		public function initParams(_url:String=Constant.DEF_URL,_code:String=Constant.DEF_CODE,_key:String=Constant.DEF_KEY,_speakAudio:String=LocalType.CN):void{
			   //bug
			   /*
			   if (_url != Constant.currURL) {
				    this.setURL(Constant.currURL);
					this.setCode(Constant.currCode);
				    this.setKey(Constant.getCurrentKey());
				   }
				   else 
				   {
					   */
				   
			        this.setURL(_url);
			        this.setCode(_code);
			        this.setKey(_key);
				   //}
				   this.setSpeakAudio(_speakAudio);
			}	
		public function SoundLoader(_url:String=Constant.DEF_URL,_code:String=Constant.DEF_CODE,_key:String=Constant.DEF_KEY,_speakAudio:String=LocalType.CN):void{
			initParams(_url,_code,_key,_speakAudio);
			registerEvents(this);
			//reload(_url,_code,_key);
		}

	}
	
}
