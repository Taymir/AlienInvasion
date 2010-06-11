package common
{
    import flash.utils.Dictionary;
   
    public class TRegistry
    {
        private static var _instance:TRegistry = new TRegistry();
        private static var _dict:Dictionary;
       
        public function TRegistry():void {
            _dict = new Dictionary();
            if( _instance ) throw new Error( "This class is a singleton and can only be accessed through TRegistry.getInstance()" );
        }
       
        public static function get instance():TRegistry {
            return _instance;
        }
       
        public  function setValue(aKey:*,aValue:*):void {
            _dict[aKey] = aValue;
        }
       
        public function getValue(aKey:*):* {
            return _dict[aKey];
        }
    }
}