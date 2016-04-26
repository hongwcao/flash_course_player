package  {
	
	import flash.display.MovieClip;
	import com.skynetsoft.util.Constant;
	
	//目录内容类
	public class ContentOfCategory extends MovieClip {
		private var _tree:CategoryTree;
		private function createTree(){
			   //if 
			}
		public function getCategoyTree():CategoryTree{
			  return _tree;
			}	
		public function ContentOfCategory() {
			this.x = 6; 
			this.y = 48;
			_tree = new CategoryTree();
			addChild(_tree);
		}
	}
	
}
