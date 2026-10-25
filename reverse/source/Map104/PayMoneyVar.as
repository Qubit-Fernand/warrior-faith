package
{
   public class PayMoneyVar
   {
      
      public static var instance:PayMoneyVar;
      
      private var _money:Object;
      
      public function PayMoneyVar()
      {
         super();
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
         var tmpMoney:Object = null;
         varMoney = Math.abs(varMoney);
         tmpMoney = {"value":varMoney};
         tmpMoney = {"value":tmpMoney.value};
         _money = tmpMoney;
      }
      
      public function get money() : int
      {
         var tmpMoney:Object = null;
         if(_money == null)
         {
            return 0;
         }
         tmpMoney = new Object();
         tmpMoney.value = _money.value;
         return int(tmpMoney.value);
      }
   }
}

