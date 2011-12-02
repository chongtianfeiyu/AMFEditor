package turbosqel.analizer {
	import flash.utils.getQualifiedClassName;
	import turbosqel.data.LVar;
	
	/**
	 * ...
	 * @author Gerard Sławiński || turbosqel
	 * 
	 * base analize element
	 */
	public class ValueType implements IAnalize {
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		// <-------------------------- PARAMS
		
		public var parent:IAnalizeParent;
		protected var content:LVar;
		protected var paramAccess:String;
		protected var paramType:String;
		internal var _root:Analize;
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		// <-------------------------- INIT
		
		public function ValueType(parent:IAnalizeParent , target:LVar , access:String = null , forceType:String = null):void {
			this.parent = parent;
			_root = parent.root;
			content = target;
			paramAccess = access || AnalizeType.READWRITE;
			paramType = forceType;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		// <-------------------------- GETTERS / SETTERS
		
		// <---------- TARGET VALUE
		
		/**
		 * return target value
		 */
		public function get target():* {
			if ( access == AnalizeType.READWRITE || access == AnalizeType.READ){
				return content.value;
			};
		};
		/**
		 * set target value and dispatch invalidate on root
		 */
		public function set target(v:*):void {
			if ( access == AnalizeType.READWRITE || access == AnalizeType.WRITE){
				content.value = v;
			};
			invalidate();
		};
		
		
		// <---------- INTERFACE GETTERS
		
		/**
		 * access mode
		 */
		public function get access():String {
			return paramAccess;
		};
		
		/**
		 * root Analize object
		 */
		public function get root():Analize {
			return _root;
		};
		
		/**
		 * return label formated string
		 */
		public function get label():String {
			return Analize.makeLabel(this);
		};
		
		/**
		 * parent key to target object / param name
		 */
		public function get name():String {
			return String(content.key);
		};
		
		/**
		 * value type
		 */
		public function get type():String {
			return paramType || getQualifiedClassName(content.value);
		};
		
		/**
		 * 
		 */
		public function get analizeType():Class {
			return this["constructor"];
		};
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		// <-------------------------- FUNCTIONS
		
		/**
		 * invalidate
		 */
		public function invalidate():void {
			root.invalidate();
		};
		
		/**
		 * formated string value
		 * @return		info
		 */
		public function toString():String {
			return "[ IAnalize:" + content.key + " , access :" + paramAccess + " ]" ;
		};
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		// <-------------------------- REMOVE
		
		/**
		 * remove and release objects
		 */
		public function remove():void {
			_root = null;
			parent = null;
			content.remove();
			content = null;
		}
		
	}

}