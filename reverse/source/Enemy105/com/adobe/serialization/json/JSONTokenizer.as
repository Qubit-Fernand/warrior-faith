package com.adobe.serialization.json
{
   public class JSONTokenizer
   {
      
      private var strict:Boolean;
      
      private var obj:Object;
      
      private var jsonString:String;
      
      private var loc:int;
      
      private var ch:String;
      
      private var controlCharsRegExp:RegExp = /[\x00-\x1F]/;
      
      public function JSONTokenizer(s:String, strict:Boolean)
      {
         super();
         jsonString = s;
         this.strict = strict;
         loc = 0;
         nextChar();
      }
      
      public function getNextToken() : JSONToken
      {
         var possibleTrue:String = null;
         var possibleFalse:String = null;
         var possibleNull:String = null;
         var possibleNaN:String = null;
         var token:JSONToken = new JSONToken();
         skipIgnored();
         switch(ch)
         {
            case "{":
               token.type = JSONTokenType.LEFT_BRACE;
               token.value = "{";
               nextChar();
               break;
            case "}":
               token.type = JSONTokenType.RIGHT_BRACE;
               token.value = "}";
               nextChar();
               break;
            case "[":
               token.type = JSONTokenType.LEFT_BRACKET;
               token.value = "[";
               nextChar();
               break;
            case "]":
               token.type = JSONTokenType.RIGHT_BRACKET;
               token.value = "]";
               nextChar();
               break;
            case ",":
               token.type = JSONTokenType.COMMA;
               token.value = ",";
               nextChar();
               break;
            case ":":
               token.type = JSONTokenType.COLON;
               token.value = ":";
               nextChar();
               break;
            case "t":
               possibleTrue = "t" + nextChar() + nextChar() + nextChar();
               if(possibleTrue == "true")
               {
                  token.type = JSONTokenType.TRUE;
                  token.value = true;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'true\' but found " + possibleTrue);
               }
               break;
            case "f":
               possibleFalse = "f" + nextChar() + nextChar() + nextChar() + nextChar();
               if(possibleFalse == "false")
               {
                  token.type = JSONTokenType.FALSE;
                  token.value = false;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'false\' but found " + possibleFalse);
               }
               break;
            case "n":
               possibleNull = "n" + nextChar() + nextChar() + nextChar();
               if(possibleNull == "null")
               {
                  token.type = JSONTokenType.NULL;
                  token.value = null;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'null\' but found " + possibleNull);
               }
               break;
            case "N":
               possibleNaN = "N" + nextChar() + nextChar();
               if(possibleNaN == "NaN")
               {
                  token.type = JSONTokenType.NAN;
                  token.value = NaN;
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'NaN\' but found " + possibleNaN);
               }
               break;
            case "\"":
               token = readString();
               break;
            default:
               if(Boolean(isDigit(ch)) || ch == "-")
               {
                  token = readNumber();
               }
               else
               {
                  if(ch == "")
                  {
                     return null;
                  }
                  parseError("Unexpected " + ch + " encountered");
               }
         }
         return token;
      }
      
      private function readString() : JSONToken
      {
         var backspaceCount:int = 0;
         var backspaceIndex:* = 0;
         var quoteIndex:int = int(loc);
         while(true)
         {
            quoteIndex = int(jsonString.indexOf("\"",quoteIndex));
            if(quoteIndex >= 0)
            {
               backspaceCount = 0;
               backspaceIndex = int(quoteIndex - 1);
               while(jsonString.charAt(backspaceIndex) == "\\")
               {
                  backspaceCount++;
                  backspaceIndex--;
               }
               if(backspaceCount % 2 == 0)
               {
                  break;
               }
               quoteIndex++;
            }
            else
            {
               parseError("Unterminated string literal");
            }
         }
         var token:JSONToken = new JSONToken();
         token.type = JSONTokenType.STRING;
         token.value = unescapeString(jsonString.substr(loc,quoteIndex - loc));
         loc = quoteIndex + 1;
         nextChar();
         return token;
      }
      
      public function unescapeString(input:String) : String
      {
         var afterBackslashIndex:int = 0;
         var escapedChar:String = null;
         var hexValue:String = null;
         var i:int = 0;
         var possibleHexChar:String = null;
         if(Boolean(strict) && Boolean(controlCharsRegExp.test(input)))
         {
            parseError("String contains unescaped control character (0x00-0x1F)");
         }
         var result:String = "";
         var backslashIndex:int = 0;
         var nextSubstringStartPosition:int = 0;
         var len:int = input.length;
         do
         {
            backslashIndex = input.indexOf("\\",nextSubstringStartPosition);
            if(backslashIndex < 0)
            {
               result += input.substr(nextSubstringStartPosition);
               break;
            }
            result += input.substr(nextSubstringStartPosition,backslashIndex - nextSubstringStartPosition);
            nextSubstringStartPosition = backslashIndex + 2;
            afterBackslashIndex = backslashIndex + 1;
            escapedChar = input.charAt(afterBackslashIndex);
            switch(escapedChar)
            {
               case "\"":
                  result += "\"";
                  break;
               case "\\":
                  result += "\\";
                  break;
               case "n":
                  result += "\n";
                  break;
               case "r":
                  result += "\r";
                  break;
               case "t":
                  result += "\t";
                  break;
               case "u":
                  hexValue = "";
                  if(nextSubstringStartPosition + 4 > len)
                  {
                     parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                  }
                  for(i = nextSubstringStartPosition; i < nextSubstringStartPosition + 4; i++)
                  {
                     possibleHexChar = input.charAt(i);
                     if(!isHexDigit(possibleHexChar))
                     {
                        parseError("Excepted a hex digit, but found: " + possibleHexChar);
                     }
                     hexValue += possibleHexChar;
                  }
                  result += String.fromCharCode(parseInt(hexValue,16));
                  nextSubstringStartPosition += 4;
                  break;
               case "f":
                  result += "\f";
                  break;
               case "/":
                  result += "/";
                  break;
               case "b":
                  result += "\b";
                  break;
               default:
                  result += "\\" + escapedChar;
            }
         }
         while(nextSubstringStartPosition < len);
         return result;
      }
      
      private function readNumber() : JSONToken
      {
         var token:JSONToken = null;
         var input:String = "";
         if(ch == "-")
         {
            input += "-";
            nextChar();
         }
         if(!isDigit(ch))
         {
            parseError("Expecting a digit");
         }
         if(ch == "0")
         {
            input += ch;
            nextChar();
            if(isDigit(ch))
            {
               parseError("A digit cannot immediately follow 0");
            }
            else if(!strict && ch == "x")
            {
               input += ch;
               nextChar();
               if(isHexDigit(ch))
               {
                  input += ch;
                  nextChar();
               }
               else
               {
                  parseError("Number in hex format require at least one hex digit after \"0x\"");
               }
               while(isHexDigit(ch))
               {
                  input += ch;
                  nextChar();
               }
            }
         }
         else
         {
            while(isDigit(ch))
            {
               input += ch;
               nextChar();
            }
         }
         if(ch == ".")
         {
            input += ".";
            nextChar();
            if(!isDigit(ch))
            {
               parseError("Expecting a digit");
            }
            while(isDigit(ch))
            {
               input += ch;
               nextChar();
            }
         }
         if(ch == "e" || ch == "E")
         {
            input += "e";
            nextChar();
            if(ch == "+" || ch == "-")
            {
               input += ch;
               nextChar();
            }
            if(!isDigit(ch))
            {
               parseError("Scientific notation number needs exponent value");
            }
            while(isDigit(ch))
            {
               input += ch;
               nextChar();
            }
         }
         var num:Number = Number(input);
         if(Boolean(isFinite(num)) && !isNaN(num))
         {
            token = new JSONToken();
            token.type = JSONTokenType.NUMBER;
            token.value = num;
            return token;
         }
         parseError("Number " + num + " is not valid!");
         return null;
      }
      
      private function nextChar() : String
      {
         return ch = jsonString.charAt(loc++);
      }
      
      private function skipIgnored() : void
      {
         var originalLoc:int = 0;
         do
         {
            originalLoc = int(loc);
            skipWhite();
            skipComments();
         }
         while(originalLoc != loc);
      }
      
      private function skipComments() : void
      {
         if(ch == "/")
         {
            nextChar();
            switch(ch)
            {
               case "/":
                  do
                  {
                     nextChar();
                  }
                  while(ch != "\n" && ch != "");
                  nextChar();
                  break;
               case "*":
                  nextChar();
                  while(true)
                  {
                     if(ch == "*")
                     {
                        nextChar();
                        if(ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        nextChar();
                     }
                     if(ch == "")
                     {
                        parseError("Multi-line comment not closed");
                     }
                  }
                  nextChar();
                  break;
               default:
                  parseError("Unexpected " + ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private function skipWhite() : void
      {
         while(isWhiteSpace(ch))
         {
            nextChar();
         }
      }
      
      private function isWhiteSpace(ch:String) : Boolean
      {
         if(ch == " " || ch == "\t" || ch == "\n" || ch == "\r")
         {
            return true;
         }
         if(!strict && ch.charCodeAt(0) == 160)
         {
            return true;
         }
         return false;
      }
      
      private function isDigit(ch:String) : Boolean
      {
         return ch >= "0" && ch <= "9";
      }
      
      private function isHexDigit(ch:String) : Boolean
      {
         return Boolean(isDigit(ch)) || ch >= "A" && ch <= "F" || ch >= "a" && ch <= "f";
      }
      
      public function parseError(message:String) : void
      {
         throw new JSONParseError(message,loc,jsonString);
      }
   }
}

