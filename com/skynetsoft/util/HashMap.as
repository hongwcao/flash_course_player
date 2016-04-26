package com.skynetsoft.util {

import flash.utils.Dictionary;

/**
* as3-HashMap类
* 扩展as3的Dictionary类
* 新增加的功能：
* 1. 提供了长度
* 2. 可以顺序遍历此字典类(效率较低)
* 3. 字典类索引，并提供了indexOf函数返回指定值索引
* 
* */
public class HashMap
{
   private var _dict:Dictionary = null;
   private var _keyList:Array = null; //可以控制字典类序列

   public function HashMap(weakKeys:Boolean=false)
     {
       _dict = new Dictionary();
       _keyList = [];
      }

   public function put(key:Object, value:Object):void
      {
        if(key != null)
           {
            _keyList.push(key);
            _dict[key] = value;
            }
         else
             {
             throw new ArgumentError("cannot put a value with undefined or null key!");
            }
        }
	//返回第一个key
	public function firstKey():String{
		var result:String = undefined;
		if (_keyList.length <= 0) {
			  return result;
			}
		result = _keyList[0];	
		return result;
		}
	//返回最后一个key
	public function lastkey():String{
		var result:String = undefined;
		if (_keyList.length <=0) {
			 return result;
			}
		result =_keyList[_keyList.length-1];
		return result;
		}
	//返回指定key的下一个key
	public function nextKey(key:Object):String{
		var result:String = undefined;
		var _index = _keyList.indexOf(key);
		if (_index == -1){
			  return result;
			}
		if (_index == (_keyList.length -1)){
		      return undefined; 
		    }
		if (_index < (_keyList.length -1)){
			  return _keyList[_index+1];
			 }
		return result 	 
		}	
	//返回指定key的上一个key
	public function previousKey(key:Object):String{
		var result:String = undefined;
		var _index = _keyList.indexOf(key);
		if (_index == -1){
			  return result;
			}
		if (_index == (0)){
		      return undefined; 
		    }
		if (_index > 0){
			  return _keyList[_index-1];
			 }
		
		return result;
		}	
    public function removeAt(key:Object):void
       {
         var i:int = _keyList.indexOf(key);
         _keyList.splice(i, 1);
         if(_dict[key])
              {
               delete _dict[key];
              }
        }

     public function clear():void
        {
          _keyList.length = 0;
          _keyList = [];
          for(var key:Object in _dict)
           {
             delete _dict[key];
            }
         }

     public function get(key:Object):Object
         {
            return _dict[key];
          }

     public function indexOf(value:Object):int
          {
          var i:int = 0;
           for(var key:Object in _dict)
            {
              if(_dict[key] == value)
               {
                 return i;
             }
           i++;
           }
          return -1;
          }

      public function length():int
             {
              return _keyList.length;
              }

      public function isEmpty():Boolean
              {
               return _keyList.length == 0;
               }

       public function clone():HashMap
               {
                var hashMap:HashMap = new HashMap();
                 for each(var key:Object in _keyList)
                 {
                    hashMap.keyList.push(key);
                    hashMap.put(key, _dict[key]);
                  }
              return hashMap;
                 }

public function containsKey(key:Object):Boolean
{
for each(var k:Object in _keyList)
{
if(k === key)
{
return true;
}
}
return false;
}

public function containsValue(value:Object):Boolean
{
for each(var v:Object in _dict)
{
if(v === value)
{
return true;
}
}
return false;
}

public function toString():String
{
var str:String = "HashMap Content:\n";
for each(var key:Object in _keyList)
{
str += key + " -> " + _dict[key] + "\n";
}
return str;
}

public function get dict():Dictionary
{
return _dict;
}

public function get keyList():Array
{
return _keyList;
}

public function set keyList(value:Array):void
{
_keyList = value;
}

}
}
