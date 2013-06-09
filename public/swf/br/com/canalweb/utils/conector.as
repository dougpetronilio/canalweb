
    import br.com.canalweb.comps.canal;
    import br.com.canalweb.comps.canalRecp;
    import br.com.canalweb.utils.Singleton;

    import mx.controls.Alert;

    private var change:Boolean = false;
    private var success:Boolean = false;
    private var clear:Boolean = false;
    private var deletes:Boolean = false;

    private var users:Object = new Object();

    private var iniDate:Date = new Date();

    private var servidor:String = "dougpetronilio.asaweb.com.br";

    [Bindable]
    public var idUser:String;
    [Bindable]
    public var idCanal:String;
    [Bindable]
    public var idApresentador:String;

    [Bindable]
    private var model:Singleton = Singleton.getInstance();

    private function init():void
    {
        idUser = Application.application.parameters.id;
        idApresentador = Application.application.parameters.code;
        idCanal = Application.application.parameters.canal;
        conecta();
    }

    private function conecta():void
    {
        model.nc = new NetConnection();

        model.nc.addEventListener(NetStatusEvent.NET_STATUS, nsHandler);

        model.key = idCanal;
        model.canalId = idCanal;
        model.meuId = idUser;

        model.nc.connect("rtmp://dougpetronilio.asaweb.com.br/canalweb");

        model.nc.client = this;
    }

    private function nsHandler(event:NetStatusEvent):void
    {
        model.connectStatus = event.info.code;

        switch(event.info.code)
        {
            case "NetConnection.Connect.Success":
                model.nc.call("setCanal", null, {name: model.name,
                                                    key: model.key,
                                                    id: model.key});
                model.canalSO = SharedObject.getRemote("canalSO", model.nc.uri, false);
                model.canalSO.addEventListener(SyncEvent.SYNC, usersSyncHandler);
                model.canalSO.connect(model.nc);
                model.canalSO.client = this;
            break;
        }
    }

    private function usersSyncHandler(event:SyncEvent):void
    {
        var results:Object = event.target.data;

        for(var a:String in event.changeList)
        {
            change = (event.changeList[a].code == "change");
            success = (event.changeList[a].code == "success");
            clear = (event.changeList[a].code == "clear");
            deletes = (event.changeList[a].code == "delete");

            if(change)
            {
                for(var con:Object in results)
                {
                    if(users[results[con].key] == undefined)
                    {
                        createCanal(results[con]);
                    }
                }
            }

            if(clear)
            {
                for(var conn:Object in results)
                {
                    if(users[results[conn].key] == undefined)
                    {
                        createCanal(results[conn]);
                    }
                }
            }

            if(deletes)
            {
                _container.removeChild(users[event.changeList[a].name]);
                delete users[event.changeList[a].name];
            }
        }
    }

    private function createCanal(obj:Object):void
    {
        if(idUser == idApresentador)
        {
            var can:canal = new canal();

            can.chave = obj.key;
            can.id = obj.id;
            can.name = obj.name;

            users[obj.key] = can;

            _container.addChild(can);
        }else
        {
            var can1:canalRecp = new canalRecp();

            can1.chave = obj.key;
            can1.id = obj.id;
            can1.name = obj.name;

            users[obj.key] = can1;

            _container.addChild(can1);
        }

    }
