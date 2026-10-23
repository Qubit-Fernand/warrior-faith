package src.tool
{
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Qinghu4_btn extends SimpleButton
   {
      
      public function Qinghu4_btn()
      {
         super();
         Show();
      }
      
      private function Show() : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[10] != 0)
         {
            this.x = 5000;
            this.y = 5000;
            this.visible = false;
            removeEventListener(MouseEvent.CLICK,onCLICK);
         }
         else
         {
            this.x = 465;
            this.y = 150;
            this.visible = true;
            addEventListener(MouseEvent.CLICK,onCLICK);
         }
      }
      
      private function onCLICK(param1:*) : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = int(StoragePanel.storage.backOtherEmptyNum());
         var _loc3_:int = int(StoragePanel.storage.backGemEmptyNum());
         if(_loc2_ >= 3 && _loc3_ >= 2)
         {
            StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(63140));
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(63155));
               StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(63147));
               _loc4_++;
            }
            _loc5_ = 0;
            while(_loc5_ < 2)
            {
               StoragePanel.storage.addGemStorage(GemFactory.creatGemById(33314));
               _loc5_++;
            }
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功 物品已放入仓库");
            ++TeShuHuoDong.TeShuHuoDongArr[10];
            Show();
         }
         else
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"仓库空间不足");
         }
      }
   }
}

