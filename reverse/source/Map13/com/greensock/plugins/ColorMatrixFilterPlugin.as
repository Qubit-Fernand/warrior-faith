package com.greensock.plugins
{
   import com.greensock.*;
   import flash.filters.*;
   
   public class ColorMatrixFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = [];
      
      protected static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      protected static var _lumR:Number = 0.212671;
      
      protected static var _lumG:Number = 0.71516;
      
      protected static var _lumB:Number = 0.072169;
      
      protected var _matrix:Array;
      
      protected var _matrixTween:EndArrayPlugin;
      
      public function ColorMatrixFilterPlugin()
      {
         super();
         this.propName = "colorMatrixFilter";
         this.overwriteProps = ["colorMatrixFilter"];
      }
      
      public static function setSaturation(m:Array, n:Number) : Array
      {
         var inv:Number = NaN;
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var temp:Array = null;
         if(isNaN(n))
         {
            return m;
         }
         inv = 1 - n;
         r = inv * _lumR;
         g = inv * _lumG;
         b = inv * _lumB;
         temp = [r + n,g,b,0,0,r,g + n,b,0,0,r,g,b + n,0,0,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function setHue(m:Array, n:Number) : Array
      {
         var c:Number = NaN;
         var s:Number = NaN;
         var temp:Array = null;
         if(isNaN(n))
         {
            return m;
         }
         n *= Math.PI / 180;
         c = Math.cos(n);
         s = Math.sin(n);
         temp = [_lumR + c * (1 - _lumR) + s * -_lumR,_lumG + c * -_lumG + s * -_lumG,_lumB + c * -_lumB + s * (1 - _lumB),0,0,_lumR + c * -_lumR + s * 0.143,_lumG + c * (1 - _lumG) + s * 0.14,_lumB + c * -_lumB + s * -0.283,0,0,_lumR + c * -_lumR + s * -(1 - _lumR),_lumG + c * -_lumG + s * _lumG,_lumB + c * (1 - _lumB) + s * _lumB,0,0,0,0,0,1,0,0,0,0,0,1];
         return applyMatrix(temp,m);
      }
      
      public static function setContrast(m:Array, n:Number) : Array
      {
         var temp:Array = null;
         if(isNaN(n))
         {
            return m;
         }
         n += 0.01;
         temp = [n,0,0,0,128 * (1 - n),0,n,0,0,128 * (1 - n),0,0,n,0,128 * (1 - n),0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function applyMatrix(m:Array, m2:Array) : Array
      {
         var temp:Array = null;
         var i:int = 0;
         var z:int = 0;
         var y:int = 0;
         var x:int = 0;
         if(!(m is Array) || !(m2 is Array))
         {
            return m2;
         }
         temp = [];
         i = 0;
         z = 0;
         for(y = 0; y < 4; y += 1)
         {
            for(x = 0; x < 5; x += 1)
            {
               if(x == 4)
               {
                  z = int(m[i + 4]);
               }
               else
               {
                  z = 0;
               }
               temp[i + x] = m[i] * m2[x] + m[i + 1] * m2[x + 5] + m[i + 2] * m2[x + 10] + m[i + 3] * m2[x + 15] + z;
            }
            i += 5;
         }
         return temp;
      }
      
      public static function setThreshold(m:Array, n:Number) : Array
      {
         var temp:Array = null;
         if(isNaN(n))
         {
            return m;
         }
         temp = [_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function colorize(m:Array, color:Number, amount:Number = 1) : Array
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var inv:Number = NaN;
         var temp:Array = null;
         if(isNaN(color))
         {
            return m;
         }
         if(isNaN(amount))
         {
            amount = 1;
         }
         r = (color >> 16 & 0xFF) / 255;
         g = (color >> 8 & 0xFF) / 255;
         b = (color & 0xFF) / 255;
         inv = 1 - amount;
         temp = [inv + amount * r * _lumR,amount * r * _lumG,amount * r * _lumB,0,0,amount * g * _lumR,inv + amount * g * _lumG,amount * g * _lumB,0,0,amount * b * _lumR,amount * b * _lumG,inv + amount * b * _lumB,0,0,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function setBrightness(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         n = n * 100 - 100;
         return applyMatrix([1,0,0,0,n,0,1,0,0,n,0,0,1,0,n,0,0,0,1,0,0,0,0,0,1],m);
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var cmf:Object = null;
         var endMatrix:Array = null;
         _target = target;
         _type = ColorMatrixFilter;
         cmf = value;
         initFilter({
            "remove":value.remove,
            "index":value.index,
            "addFilter":value.addFilter
         },new ColorMatrixFilter(_idMatrix.slice()),_propNames);
         _matrix = ColorMatrixFilter(_filter).matrix;
         endMatrix = [];
         if(cmf.matrix != null && cmf.matrix is Array)
         {
            endMatrix = cmf.matrix;
         }
         else
         {
            if(cmf.relative == true)
            {
               endMatrix = _matrix.slice();
            }
            else
            {
               endMatrix = _idMatrix.slice();
            }
            endMatrix = setBrightness(endMatrix,cmf.brightness);
            endMatrix = setContrast(endMatrix,cmf.contrast);
            endMatrix = setHue(endMatrix,cmf.hue);
            endMatrix = setSaturation(endMatrix,cmf.saturation);
            endMatrix = setThreshold(endMatrix,cmf.threshold);
            if(!isNaN(cmf.colorize))
            {
               endMatrix = colorize(endMatrix,cmf.colorize,cmf.amount);
            }
         }
         _matrixTween = new EndArrayPlugin();
         _matrixTween.init(_matrix,endMatrix);
         return true;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         _matrixTween.changeFactor = n;
         ColorMatrixFilter(_filter).matrix = _matrix;
         super.changeFactor = n;
      }
   }
}

