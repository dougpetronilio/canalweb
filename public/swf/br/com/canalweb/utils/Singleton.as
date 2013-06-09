package br.com.canalweb.utils
{
    import flash.net.NetConnection;
    import flash.net.SharedObject;

    [Bindable]
    public class Singleton
    {
        private static var modelLocator:Singleton;

        public var name:String = "Anonymous";
        public var role:String = "user";
        public var key:String = "";
        public var nc:NetConnection;
        public var canalSO:SharedObject;
        public var connectStatus:String;
        public var meuId:String="1";
        public var canalId:String="1";

        public static function getInstance():Singleton
        {
            if(modelLocator == null)
            {
                modelLocator = new Singleton();
            }
            return modelLocator;
        }

        public function Singleton()
        {
            if(modelLocator != null)
            {
                throw new Error("Já existe uma instancia do modelLocator criada...");
            }
        }
    }
}
