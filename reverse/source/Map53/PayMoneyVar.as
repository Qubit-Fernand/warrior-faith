package
{
   public class PayMoneyVar
   {
      
      public static var instance:PayMoneyVar;
      
      private var _money:Object;
      
      public function PayMoneyVar()
      {
         super();
         if(PayMoneyVar.instance != null)
         {
            throw new Error("只能实例一次！");
         }
      }
      
      public static function getInstance() : PayMoneyVar
      {
         if(instance == null)
         {
            instance = new PayMoneyVar();
         }
         return instance;
      }
      
      public function set money(varMoney:int) : void
      {
         varMoney = Math.abs(varMoney);
         var tmpMoney:Object = {"value":varMoney};
         tmpMoney = {"value":tmpMoney.value};
         _money = tmpMoney;
      }
      
      public function get money() : int
      {
         if(_money == null)
         {
            return 0;
         }
         var tmpMoney:Object = new Object();
         tmpMoney.value = _money.value;
         return int(tmpMoney.value);
      }
   }
}

