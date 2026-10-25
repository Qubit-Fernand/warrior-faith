package com.hotpoint.braveManIII.views.achPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.achievement.Achievement;
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import src.*;
   
   public class AchPanel extends MovieClip
   {
      
      private static var _instance:AchPanel;
      
      private var _data:AchData;
      
      private var bigState:Number = 0;
      
      private var bye:Number = 0;
      
      private var sstate:Number = 0;
      
      private var ye:Number = 0;
      
      private var dataArr:Array = [];
      
      private var dataBigArr:Array = [];
      
      private var acSlot:AchSlot;
      
      private var tSlot:AcTiaoSlot;
      
      private var bigTyeArr:Array = [["落月之原_0","落月之森_1","c_2","d_3","e_4","f_5","g_6"],["A_0","B_1","C_2","D_3","E_4","F_5","G_6"]];
      
      public function AchPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(AchPanel._instance == null)
         {
            AchPanel._instance = new AchPanel();
            AchPanel._instance._data = new AchData();
            AchPanel._instance.acSlot = new AchSlot();
            AchPanel._instance.tSlot = new AcTiaoSlot();
         }
         AchPanel._instance.updeAc();
         Main._this.addChild(AchPanel._instance);
         AchPanel._instance.initPanel();
         AchPanel._instance.addEvent();
         AchPanel._instance.visible = true;
         AchPanel._instance.y = 100;
      }
      
      public static function close() : void
      {
         if(AchPanel._instance != null)
         {
            if(AchPanel._instance.visible == true)
            {
               AchPanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         bigState = 0;
         bye = 0;
         sstate = 0;
         ye = 0;
         initTiao(bigState,bye);
         initType(bigState,sstate,ye);
      }
      
      private function updeAc() : void
      {
         var ac:Achievement = null;
         var arr:Array = AchData.allDataArr;
         for(var i:uint = 0; i < arr.length; i++)
         {
            ac = arr[i];
            if(ac.getStata() == 3)
            {
               if(Main.serverTime.getValue() != ac.getOverTimer())
               {
                  ac.setStata(0);
               }
            }
         }
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
      }
      
      public function doChange(e:BtnEvent) : void
      {
         var str:String = e.target.name;
         var nameId:String = str.substr(0,1);
         var id:Number = Number(str.substr(3,1));
         if(nameId == "b")
         {
            bigState = id;
            sstate = 0;
            ye = 0;
            bye = 0;
            initTiao(bigState,bye);
            initType(bigState,sstate,ye);
         }
         else if(nameId == "n")
         {
            if(tSlot.getName(id) != null)
            {
               ye = 0;
               sstate = getTypeByeNameId(id);
               initType(bigState,sstate,ye);
            }
         }
      }
      
      public function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      private function getTypeByeNameId(id:Number = 0) : Number
      {
         var acName:String = null;
         var type:Number = 0;
         if(tSlot.getName(id) != null)
         {
            acName = tSlot.getName(id);
            type = Number(acName.substring(acName.lastIndexOf("_") + 1,acName.length));
         }
         return type;
      }
      
      public function doClick(e:BtnEvent) : void
      {
         var str:String = e.target.name;
         var nameId:String = str.substr(0,1);
         var id:Number = Number(str.substr(3,1));
         if(nameId == "b")
         {
            trace("大分页按钮");
            ye = 0;
            bye = addOrJian(id,bye,dataBigArr);
            initTiao(bigState,bye);
            sstate = getTypeByeNameId(0);
            initType(bigState,sstate,ye);
         }
         else if(nameId == "s")
         {
            ye = addOrJian(id,ye,dataArr);
            initType(bigState,sstate,ye);
         }
      }
      
      private function addOrJian(btnId:Number, ye:Number, allNum:Array) : Number
      {
         var num:Number = ye;
         if(allNum != null)
         {
            if(btnId == 0)
            {
               if(num > 0)
               {
                  num--;
               }
            }
            else if(btnId == 1)
            {
               if(num < allNum.length - 1)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      private function getArr6(type:Number) : Array
      {
         bigTyeArr = [["落月之原_0","落月之森_1","c_2","d_3","e_4","f_5","g_6"],["A_0","B_1","C_2","D_3","E_4","F_5","G_6"]];
         var arr:Array = [];
         var arr2:Array = [];
         var allArr:Array = [];
         arr = bigTyeArr[type];
         for(var i:uint = 0; i < 100; i++)
         {
            if(arr.length < 6)
            {
               arr2 = arr.splice(0);
               if(arr2.length > 0)
               {
                  allArr.push(arr2);
               }
               break;
            }
            arr2 = arr.splice(0,6);
            allArr.push(arr2);
         }
         return allArr;
      }
      
      private function initTiao(type:Number = 0, num:Number = 0) : void
      {
         dataBigArr = getArr6(type);
         tSlot.clearAc();
         iniTiaoSlot(dataBigArr,num);
         initTiaoVisble();
         byeNum(this.b_text,bye,dataBigArr);
      }
      
      private function byeNum(t:TextField, nowNum:Number, arr:Array) : void
      {
         var allNum:* = undefined;
         if(arr != null)
         {
            allNum = arr.length;
            if(allNum < 1)
            {
               allNum = 1;
            }
            t.text = nowNum + 1 + "/" + allNum;
         }
         else
         {
            t.text = nowNum + 1 + "/" + 1;
         }
      }
      
      private function initTiaoVisble() : void
      {
         var str:String = null;
         for(var i:uint = 0; i < 6; i++)
         {
            this["na_" + i].n_text.text = "";
            if(tSlot.getName(i) != null)
            {
               str = tSlot.getName(i);
               this["na_" + i].n_text.text = String(str);
            }
         }
      }
      
      private function initType(type:Number = 0, sType:Number = 0, num:Number = 0) : void
      {
         trace("大类型:" + type,"小类型:" + sType,"分页:" + num);
         dataArr = _data.getEvOrGa(type,sType);
         acSlot.clearAc();
         iniSlot(dataArr,num);
         initAc();
         byeNum(this.s_text,ye,dataArr);
      }
      
      private function iniTiaoSlot(typeArr:Array, num:Number = 0) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(typeArr != null)
         {
            arr = typeArr[num];
            for(i = 0; i < arr.length; i++)
            {
               tSlot.addName(arr[i]);
            }
         }
      }
      
      private function iniSlot(typeArr:Array, num:Number = 0) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(typeArr != null)
         {
            arr = typeArr[num];
            for(i = 0; i < arr.length; i++)
            {
               acSlot.addSlot(arr[i]);
            }
         }
      }
      
      private function initAc() : void
      {
         var ac:Achievement = null;
         for(var i:uint = 0; i < 10; i++)
         {
            if(acSlot.getAc(i) != null)
            {
               ac = acSlot.getAc(i);
               this["a_" + i].a_name.text = String(ac.getName());
               this["a_" + i].a_jieShao.text = String(ac.getSm());
               if(ac.getStata() != 0)
               {
                  this["a_" + i].m_st.gotoAndStop(2);
               }
            }
            else
            {
               this["a_" + i].a_name.text = "";
               this["a_" + i].a_jieShao.text = "";
               this["a_" + i].m_st.gotoAndStop(1);
            }
         }
      }
   }
}

