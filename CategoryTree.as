package  {
	import com.yahoo.astra.fl.controls.Tree;
	import com.yahoo.astra.fl.controls.treeClasses.TreeDataProvider;
	import com.yahoo.astra.fl.events.TreeEvent;
	import com.yahoo.astra.fl.controls.treeClasses.TNode;
    import com.yahoo.astra.fl.controls.treeClasses.RootNode;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.skynetsoft.util.Constant;
	import flash.security.X500DistinguishedName;
	import flash.text.TextFormat;
	import fl.events.ListEvent;
	import com.skynetsoft.util.HashMap;
	import com.skynetsoft.cmi.scorm.LessonStatus;
	import com.skynetsoft.util.ContentMetaType;
	import flash.events.MouseEvent;
	import com.skynetsoft.events.LoaderEvent;
	import com.skynetsoft.util.LocalType;
	import com.skynetsoft.util.Constant;
	import com.skynetsoft.events.CategoryTitleRefreshEvent;
    
	//目录树类,用于载入并处理目录树业务 
    public class CategoryTree extends Tree{
		private var _loader:URLLoader;
		private var _xml:XML;
		private var _chapterName:String;
		private var _sectionName:String;
		private var _chapterName_en:String;
		private var _sectionName_en:String;
		private var _completedMap:HashMap = new HashMap();
		private function setXML(ob:XML){
			   _xml = ob;
			}
		public function getCompletedMap():HashMap {
			   return _completedMap;
			}
		public function getXML():XML{
			   return _xml;
			}
		public function getChapterName():String{
			   return _chapterName;
			}	
		public function setChapterName(ob:String) {
			  _chapterName = ob; 
			}	
		public function setSectionName(ob:String) {
			  _sectionName = ob;
			}	
		public function getSectionName():String{
			  return _sectionName;
			}
		public function getChapterName_en():String{
			   return _chapterName_en;
			}	
		public function setChapterName_en(ob:String) {
			  _chapterName_en = ob; 
			}	
		public function setSectionName_en(ob:String) {
			  _sectionName_en = ob;
			}	
		public function getSectionName_en():String{
			  return _sectionName_en;
			}	
			
		//返回当前课程的完成比率
		public function getCompletedProgress(_completedMap:HashMap):String{
			   var result:String = "---";
			   if (_completedMap.length() <= 0) { return result}
			   else {
				     var _total:Number = _completedMap.length();
					 var _count:Number = 0;
					 var _cm:ContentMetaType;
					 for each (var key:String in _completedMap.keyList) 
                     { 
                         _cm = _completedMap.get(key) as ContentMetaType;
						 if ((_cm.getLessonStatus() == LessonStatus.BROWSED) ||
						    (_cm.getLessonStatus() == LessonStatus.COMPLETED) ||
							(_cm.getLessonStatus() == LessonStatus.PASSED))
							{
								++_count;
								}
                       }
					  return Math.round((_count/_total)*100).toString();
				}
			}	
		//装载初始化函数
		private function initLoader(){
			//定义当前显示的标签的语言的匿名函数(中文、英文)
			this.labelFunction = function(data:Object):String{
				 if (Constant.getCurrentLanguage() == LocalType.CN) {
					    return  data.label; 
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				        return data.label;
						//return  data.label_en;
				      }
				   return undefined;	  
				  };
			_loader = new URLLoader();
			var url:URLRequest = new URLRequest(Constant.CATEGORY_XML);
			//目录xml文件被载入完成后，将触发onLoaded函数
			_loader.addEventListener(Event.COMPLETE, onLoaded);
			_loader.load(url);
			}	
		
		//预载目录的xml文件完毕后，执行数据及控件处理函数
		private function onLoaded(evt:Event){
			  setXML(new XML((URLLoader)(evt.target).data));
			  initChapterName(getXML());
			  this.dataProvider = new TreeDataProvider(getXML());
			  initCompletedProgress(getXML());
			  onInitLoaded();
			}
		//目前只支持目录树配置一个章节
		private function initChapterName(ob:XML){
				  if (ob.children()[0].name() == "chapter") {
				  setChapterName((ob.children()[0].@label));
				  setChapterName_en((ob.children()[0].@label_en));
				  }
			      if (ob.children()[0].children()[0].name() == "section" ) {
				  setSectionName(ob.children()[0].children()[0].@label);
				  setSectionName_en(ob.children()[0].children()[0].@label_en);
				  }
				  if (ob.children()[0].children()[0].children()[0].name() == "section"){
				  setSectionName(getSectionName() + "-" +  ob.children()[0].children()[0].children()[0].@label);
				  setSectionName_en(getSectionName_en() + "-" +  ob.children()[0].children()[0].children()[0].@label_en);
				  }
			}	
		
		//初始化针对目录xml文件中的页信息的完成进度的对象实例化
		private function initCompletedProgress(ob:XML){
               for each (var prop:XML in ob..item){
				    var _cmt:ContentMetaType = new ContentMetaType(); 
					_cmt.setLabel(prop.@label);
					_cmt.setLabel_en(prop.@label_en);
					_cmt.setCode(prop.@code);
					_cmt.setKey(prop.@key);
					_cmt.setURL(prop.@url);
					_cmt.setPath(prop.@path);
					_cmt.setLessonStatus(LessonStatus.NOT_ATTEMPTED);
					_cmt.setFullTitle(getChapterName()+"-"+getSectionName()+"-"+prop.@label);
					_cmt.setFullTitle_en(getChapterName_en()+"-"+getSectionName_en()+"-"+prop.@label_en);
					getCompletedMap().put(_cmt.getKey(),_cmt);
				 }
				 //onRefreshTitle(_cmt.getLabel());
				 if (Constant.getCurrentLanguage() == LocalType.CN) {
					onRefreshTitle(_cmt.getLabel());
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				    //onRefreshTitle(_cmt.getLabel_en());
					onRefreshTitle(_cmt.getLabel());
				  }
				 onCompletedProcess(getCompletedMap());
				 
				 
				 //trace(getCompletedMap());
			  /* _completedProgress = getCompletedProgress(getCompletedMap());
			   var _evt:CategoryEvent = new CategoryEvent(CategoryEvent.COMPLETED_PROCRESS);
			   _evt.setCompletedProcess(_completedProgress);
			   dispatchEvent(_evt);*/
		}
		
		/*
		private function onTitleRefresh(_map:HashMap) {
			   var _evt:CategoryTitleRefreshEvent = new CategoryTitleRefreshEvent(CategoryTitleRefreshEvent.ON_REFRESH);
			   _evt.setTitleText(getChapterName() + "-"+ getSectionName());
			   dispatchEvent(_evt);
			}
			*/
		//产生当前页信息完成比率的事件，该事件抛出之后有首页的学习页完成进度显示组件负责接收事件并刷新显示
		private function onCompletedProcess(_map:HashMap){
			   var _completedProgress:String = getCompletedProgress(_map);
			   var _evt:CategoryEvent = new CategoryEvent(CategoryEvent.COMPLETED_PROCRESS);
			   _evt.setCompletedProcess(_completedProgress);
			   dispatchEvent(_evt);
			}
		private function getTextFormat():TextFormat{
			  var _textfmt:TextFormat = new TextFormat();
			  _textfmt.font ="宋体";
			  _textfmt.size = 13;
			  return _textfmt;
			}
		private function initStyles(){
		       this.setRendererStyle("textFormat",getTextFormat());
			}
			
		//only for test	
		private function showStyleDefinition():void {
              var styles:Object = getStyleDefinition();
			  for(var i:* in styles) {
                    //trace(i + " : " + styles[i]);
			  }
		}

		//目录xml文件及相关示例对象实例化后的处理程序
		private function onInitLoaded(){
			    var _fkey:String = getCompletedMap().firstKey();
				var _cm:ContentMetaType = getCompletedMap().get(_fkey) as ContentMetaType;
				var evt:CategoryEvent = new CategoryEvent(CategoryEvent.INIT_LOADED);
				evt.setCode(_cm.getCode());
				evt.setKey(_cm.getKey());
				evt.setURL(_cm.getURL());
				evt.setPath(_cm.getPath());
				evt.setLabel(_cm.getLabel());
				//设定当前目录的xml文件已经完成装载并实现了相关实例的初始化工作
				if (!Constant.categoryIsLoaded) {
					   Constant.categoryIsLoaded = true;
					}
				Constant.currCode = evt.getCode();
				Constant.currURL = evt.getURL();
				dispatchEvent(evt);
				if (Constant.getCurrentLanguage() == LocalType.CN) {
					onRefreshTitle(_cm.getLabel());
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				    onRefreshTitle(_cm.getLabel());
					//onRefreshTitle(_cm.getLabel_en());
				  }
				
				//onRefreshTitle(_cm.getLabel());
			}
			
		private function onRefreshTitle(label:String){
			    var _evt:CategoryTitleRefreshEvent = new CategoryTitleRefreshEvent(CategoryTitleRefreshEvent.ON_REFRESH);
				 if (Constant.getCurrentLanguage() == LocalType.CN) {
					_evt.setTitleText(getChapterName() + "-" + getSectionName() + "-" + label);
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				     _evt.setTitleText(getChapterName() + "-" + getSectionName() + "-" + label);
				       //_evt.setTitleText(getChapterName_en() + "-" + getSectionName_en() + "-" + label);
				  }
                //_evt.setTitleText(getChapterName() + "-" + getSectionName() + "-" + label);
				dispatchEvent(_evt);
			}	
		private function onItemClick (evt:ListEvent) {
              try {
			  if (evt.item.url.toString() != undefined as String ) {
				      var itemClickEvt:CategoryEvent = new CategoryEvent(CategoryEvent.ITEM_CLICK);
					  //获取目录树及其属性，并派发CategoryEvent事件
					  itemClickEvt.setURL(evt.item.url.toString());
					  itemClickEvt.setCode(evt.item.code.toString());
					  itemClickEvt.setKey(evt.item.key.toString());
					  itemClickEvt.setLabel(evt.item.label.toString());
					  itemClickEvt.setPath(evt.item.path.toString());
					  dispatchEvent(itemClickEvt);
					  if (Constant.getCurrentLanguage() == LocalType.CN) {
					onRefreshTitle(evt.item.label.toString());
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				    onRefreshTitle(evt.item.label.toString());
					//onRefreshTitle(evt.item.label_en.toString());
				  }
					//  onRefreshTitle(evt.item.label.toString());
				  }
			  }
			  catch(e:Error) {
				   //trace(e);
				  }
			  // If the item has an 'image' attribute
              //mytext.text = ev.item.label;
			  //trace("Item has been clicked!");
			  //trace(evt.item.code);
			  //trace(evt.item.url);
			  /*if (ev.item.image != null) {
		      // Use the 'image' attribute to get a movie clip by that name from the library
		          var myClip:Class = getDefinitionByName(ev.item.image) as Class;
		          removeChild(myMC);
		          myMC = new myClip() as MovieClip;
		      // Position the new movie clip
		          myMC.x = 240;
		          myMC.y = 41;
		      // Add the new movie clip to the display list
		         addChild(myMC);
	          }*/
            }
			
		//根据key值,在目录结构中进行查找,并打开该节点
		private function openItem(_key:String):void{
			  var foundNode:TNode = this.findNode("key", _key);
	          var nodeIndex:int = this.showNode(foundNode);
	          this.selectedIndex = nodeIndex;
	          this.scrollToSelected();
			};
		
        //响应课程学习状态修改事件
		public function onLessonStatusChange(e:LoaderEvent):void{
			   (getCompletedMap().get(e.key) as ContentMetaType).setLessonStatus(e.lessonStatus) ;
			   onCompletedProcess(getCompletedMap());
			}
		//响应语言状态修改事件
		public function onLanguageStatusChange(e:LoaderEvent):void{
			   openItem(e.key);
			}
		
		//抛出播放那个下一页事件
        public function onNextPage(e:MouseEvent):void{
			    e.stopImmediatePropagation();
				var _fkey:String = getCompletedMap().nextKey(Constant.getCurrentKey());
				if (_fkey != undefined as String){
				var _cm:ContentMetaType = getCompletedMap().get(_fkey) as ContentMetaType;
				var evt:CategoryEvent = new CategoryEvent(CategoryEvent.ITEM_CLICK);
				evt.setCode(_cm.getCode());
				evt.setKey(_cm.getKey());
				evt.setURL(_cm.getURL());
				evt.setPath(_cm.getPath());
				evt.setLabel(_cm.getLabel());
				dispatchEvent(evt);
				if (Constant.getCurrentLanguage() == LocalType.CN) {
					onRefreshTitle(_cm.getLabel());
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				    onRefreshTitle(_cm.getLabel());
					//onRefreshTitle(_cm.getLabel_en());
				  }
				//onRefreshTitle(_cm.getLabel());
				}
			}
		
		//抛出播放上一页事件	
		public function onPreviousPage(e:MouseEvent):void{
                e.stopImmediatePropagation();
				var _fkey:String = getCompletedMap().previousKey(Constant.getCurrentKey());
				if (_fkey != undefined as String) {
				var _cm:ContentMetaType = getCompletedMap().get(_fkey) as ContentMetaType;
				var evt:CategoryEvent = new CategoryEvent(CategoryEvent.ITEM_CLICK);
				evt.setCode(_cm.getCode());
				evt.setKey(_cm.getKey());
				evt.setURL(_cm.getURL());
				evt.setPath(_cm.getPath());
				evt.setLabel(_cm.getLabel());
				dispatchEvent(evt);
				//onRefreshTitle(_cm.getLabel());
				if (Constant.getCurrentLanguage() == LocalType.CN) {
					onRefreshTitle(_cm.getLabel());
					 }
				  else if (Constant.getCurrentLanguage() == LocalType.EN) {	 
				    onRefreshTitle(_cm.getLabel());
					//onRefreshTitle(_cm.getLabel_en());
				  }
				}
			}	
		public function CategoryTree() {
			this.x = 15;
			this.y = 50;
			this.width = 270;
			this.height = 535;
			initLoader();
            initStyles(); 
			this.addEventListener(ListEvent.ITEM_CLICK,onItemClick);
			
			//showStyleDefinition();
		}

    }
	
}
