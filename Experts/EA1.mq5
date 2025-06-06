//+------------------------------------------------------------------+
//|                                                          EA1.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"


#include <Trade\Trade.mqh>
CTrade trade;

input bool isShowSummaryInfo = false;
input int MAXORDER = 10;
input double lotSize = 0.01;
input bool isTradeBuy = false;
input bool isTradeSell = false;
input bool isSendToTelegram = false;
bool enableUpperNotify = true;
bool enableDownNotify = true;

double UP_NRTRValue = 0.0;
double DN_NRTRValue = 0.0;

int imageWidth = 1920; //1024;
int imageHeight = 1080; //768;

double totalProfit = 0.0;
int totalPositions = 0;

double totalProfitSymbol = 0.0;
int totalPositionsSymbol = 0;

string candleTimeLabel = "lblCandleRemaining";
   
double buy_profit = 0.0;
double sell_profit = 0.0;
int buy_without_tp = 0;
int sell_without_tp = 0;
int buy_without_sl = 0;
int sell_without_sl = 0;
int buy_count = 0;
int sell_count = 0;
double buy_profit_from_tp = 0.0;
double sell_profit_from_tp = 0.0;
double buy_loss_from_sl = 0.0;
double sell_loss_from_sl = 0.0;
bool blinkBuySL = false;
bool blinkSellSL = false;
datetime lastBlink = 0;


input int    IntervalSeconds  = 180; // Every 3 minutes

double spreadPip = 0.0;
const string TelegramBotToken = "7960128888:AAHwv-RbN77gaoCR1EJy7MlSIv573GWv2EM";
const string ChatId           = "-1002194122590";
const string TelegramApiUrl   = "https://api.telegram.org"; // Add this to Allow URLs

const int    UrlDefinedError  = 4014; // Because MT4 and MT5 are different
double iSar1_1 = 0.005;
double iSar1_2 = 0.015;
datetime lastShotTime = 0;

string SupabaseURL     = "https://zmppjqiekisbxwcioone.supabase.co/rest/v1/fxtrade1";
string SupabaseAPIKey  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InptcHBqcWlla2lzYnh3Y2lvb25lIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxNDczODYsImV4cCI6MjA2MjcyMzM4Nn0.ubanp2RSSTarEe09L5jD1DKmeETwB1kW1QAsMbjdYt0";
//string SupabaseAPIKey  = "wcE+rfwKSLI2RysITZNfbZG32YrlnEnlRAncgU69ox0rTycyi8+IBcpbVZVKxBqVill2K4XQzKSvEp9mAIchHg==";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
// ENUM for order type
enum PendingOrderType
{
   BuyLimit,
   SellLimit,
   BuyStop,
   SellStop
};

int OnInit()
  {
//---
      if(isShowSummaryInfo)
      {
         DrawChartText("labSymbol_name",_Symbol, 10, 100, clrWhite, 42);
         DrawChartText("labBuyInfo","-", 10, 200, clrWhite, 14);
         DrawChartText("labSellInfo","-", 10, 240, clrWhite, 14);
         DrawChartText("labSummaryInfo","-", 10, 270, clrWhite, 14);
      }
//---
   //CreateToggleButton("btnEnableUpperNotify", "Up.Notify", enableUpperNotify);
   //CreateToggleButton("btnEnableDownNotify", "DN.Notify", enableDownNotify, 170, 300);
   
   //CreateButton("btnPlacePendding", 360, 300, "Place Pendding", 200);
   //SendPhotoToTelegram("C:\Users\admin\AppData\Roaming\MetaQuotes\Terminal\53785E099C927DB68A545C249CDBCE06\MQL5\Files\EURUSDm_20250527_15_52_27.png");
   
   EventSetTimer(IntervalSeconds);
   return INIT_SUCCEEDED;
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectDelete(0, candleTimeLabel);
   ObjectDelete(0, "labSymbol_name");
   ObjectDelete(0, "labBuyInfo");
   ObjectDelete(0, "labSellInfo");
   ObjectDelete(0, "labSummaryInfo");
   ObjectDelete(0, "UP_NRTR_"+_Symbol);
   ObjectDelete(0, "MID_NRTR_"+_Symbol);
   ObjectDelete(0, "DN_NRTR_"+_Symbol);
   //ObjectDelete(0, "btnPlacePendding");
   EventKillTimer();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
   double pipSize = (_Digits == 3 || _Digits == 5) ? 1 * _Point : _Point;
   double pipDifference = MathAbs(UP_NRTRValue - DN_NRTRValue) / pipSize;
   int pipInt = (int)MathRound(pipDifference * 0.5);
   
   GetSpreadPips();
   UpdateCandleRemainingTime();
   
   DrawSARHLine(iSar1_1,iSar1_2,clrAqua,1);
   
   CalculateProfits();
   GetTotalProfit();
   GetTotalProfitForSymbol(_Symbol);
   updateInfo();
   
   //if (!GlobalVariableCheck("UP_TRENDARROW_"+_Symbol))
   //   return;
   
   //double UP_TRENDARROWValue = GlobalVariableGet("UP_TRENDARROW_"+_Symbol);  
   
   //if (!GlobalVariableCheck("DN_TRENDARROW_"+_Symbol))
   //   return;
   
   //double DN_TRENDARROWValue = GlobalVariableGet("DN_TRENDARROW_"+_Symbol);  
   
   //if(_Symbol=="USDJPYm") Print("UP=" + UP_TRENDARROWValue + ",DN=" + DN_TRENDARROWValue);
   //if(DN_TRENDARROWValue == DN_TRENDARROWValue)
   
   if (!GlobalVariableCheck("UP_NRTR_"+_Symbol))
      return;

   UP_NRTRValue = GlobalVariableGet("UP_NRTR_"+_Symbol);   
   //DrawNRTRHLine("UP_NRTR_"+_Symbol, UP_NRTRValue, clrWhite, 1); 
   
   //if(enableUpperNotify && ask >= UP_NRTRValue){
   
   //   double tp  = pipInt + 300;
   //   double sl  = pipInt + 60;
   //   double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 3.0;
   //   if(GetOrderCount(POSITION_TYPE_BUY) >= MAXORDER) return;
      //PlacePendingOrder(_Symbol, BuyLimit, lotSize, middlePrice, sl, tp, "Buy Limit");
      
   //   tp  = pipInt + 300;
   //   sl  = pipInt + 40;
      //PlacePendingOrder(_Symbol, SellLimit, lotSize, DN_NRTRValue + 50 * _Point, sl, tp, "Buy Stop");
      //string message = "🔔 UP " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
      //              "\nAsk: " + DoubleToString(ask, _Digits);

      //SendNotification(message);
   //} 

   if (!GlobalVariableCheck("DN_NRTR_"+_Symbol))
      return;

   DN_NRTRValue = GlobalVariableGet("DN_NRTR_"+_Symbol);  
   //DrawNRTRHLine("DN_NRTR_"+_Symbol, DN_NRTRValue, clrWhite, 1);  
    
   double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 2.0;
   //DrawNRTRHLine("MID_NRTR_"+_Symbol, middlePrice, clrYellow, 1);  
   
   //if(enableDownNotify && bid <= DN_NRTRValue){
   //   double tp  = pipInt + 300;
   //   double sl  = pipInt + 60;
   //   double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 3.0;
      
   //   if(GetOrderCount(POSITION_TYPE_SELL) >= MAXORDER) return;
      //PlacePendingOrder(_Symbol, SellLimit, lotSize, middlePrice, sl, tp, "Sell Limit");
      
   //   tp  = pipInt + 300;
   //   sl  = pipInt + 40;
      //PlacePendingOrder(_Symbol, BuyStop, lotSize, UP_NRTRValue + 50 * _Point, sl, tp, "Sell Stop");
      //string message = "🔔 DN " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
      //              "\nAsk: " + DoubleToString(ask, _Digits);

      //SendNotification(message);
   //} 
   
   if(isTradeSell && (UP_NRTRValue - DN_NRTRValue) != 0) //Invest Trading
   {
      double tp  = pipInt + 300;
      double sl  = pipInt + 60;
      //double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 3.0;
      //if(GetOrderCount(POSITION_TYPE_BUY) >= MAXORDER) return;
         PlacePendingOrder(_Symbol, BuyLimit, lotSize, UP_NRTRValue, sl, tp, "Buy Limit");
      
         //tp  = pipInt + 300;
         //sl  = pipInt + 40;
         //PlacePendingOrder(_Symbol, SellLimit, lotSize, DN_NRTRValue + 50 * _Point, sl, tp, "Buy Stop");
         //string message = "🔔 UP " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
         //          "\nAsk: " + DoubleToString(ask, _Digits);
      //}
   }
   
   if(isTradeBuy && (UP_NRTRValue - DN_NRTRValue) != 0) //Invest Trading
   {
      double tp  = pipInt + 300;
      double sl  = pipInt + 60;
      double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 3.0;
      
      //if(GetOrderCount(POSITION_TYPE_SELL) >= MAXORDER) return;
         PlacePendingOrder(_Symbol, SellLimit, lotSize, DN_NRTRValue, sl, tp, "Sell Limit");
      
         //tp  = pipInt + 300;
         //sl  = pipInt + 40;
         //PlacePendingOrder(_Symbol, BuyStop, lotSize, UP_NRTRValue + 50 * _Point, sl, tp, "Sell Stop");
         //string message = "🔔 DN " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
         //           "\nAsk: " + DoubleToString(ask, _Digits);
      //}
      
   }   
}

//+------------------------------------------------------------------+
//| Function to get current spread in points                         |
//+------------------------------------------------------------------+
double GetSpreadPoints()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   
   if (ask == 0 || bid == 0 || point == 0)
      return 0;

   return (ask - bid) / point;
}
//+------------------------------------------------------------------+
//| Function to get current spread in pips                          |
//+------------------------------------------------------------------+
void GetSpreadPips()
{
   spreadPip = GetSpreadPoints() / 10.0;
}

void DrawSARHLine(double iStep, double iMaximume, color iColor, int iWidth = 1)
{
   double sar[];
   int handle = iSAR(_Symbol, _Period, iStep, iMaximume);
   if(handle != INVALID_HANDLE)
   {
      if(CopyBuffer(handle, 0, 0, 1, sar) > 0)
      {
         double sarValue = sar[0];
         string name = "sar_hline_"+iStep+iMaximume;
         if(!ObjectCreate(0, name, OBJ_HLINE, 0, 0, 0))
            ObjectDelete(0, name);

         ObjectCreate(0, name, OBJ_HLINE, 0, TimeCurrent(), sarValue);
         ObjectSetInteger(0, name, OBJPROP_COLOR, iColor);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, iWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
      }
      IndicatorRelease(handle);
   }
}

int GetOrderCount(int positionType)
{
   int returnVar = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
      {
         if(PositionGetInteger(POSITION_TYPE) == positionType &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            returnVar += 1;
         }
      }
   }
   return returnVar;
}

void CalculateProfits()
{
   buy_profit = 0;
   sell_profit = 0;
   buy_without_tp = 0;
   sell_without_tp = 0;
   buy_without_sl = 0;
   sell_without_sl = 0;
   buy_count = 0;
   sell_count = 0;

   string symbol = _Symbol;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         double sl = PositionGetDouble(POSITION_SL);
         double tp = PositionGetDouble(POSITION_TP);
         int type = (int)PositionGetInteger(POSITION_TYPE);

         if(type == POSITION_TYPE_BUY)
         {
            buy_profit += profit;
            buy_count++;
            if(tp <= 0.0) buy_without_tp++;
            if(sl <= 0.0) buy_without_sl++;
         }
         else if(type == POSITION_TYPE_SELL)
         {
            sell_profit += profit;
            sell_count++;
            if(tp <= 0.0) sell_without_tp++;
            if(sl <= 0.0) sell_without_sl++;
         }
      }
   }
}

double GetTotalProfit()
{

   totalProfit = 0.0;
   totalPositions = PositionsTotal();
   
   for (int i = 0; i < totalPositions; i++)
   {
      if (PositionGetTicket(i))
      {
         totalProfit += PositionGetDouble(POSITION_PROFIT);
      }
   }

   return totalProfit;
}

double GetTotalProfitForSymbol(string symbol)
{
   totalProfitSymbol = 0.0;
   totalPositionsSymbol = PositionsTotal();

   for (int i = 0; i < totalPositions; i++)
   {
      if (PositionGetTicket(i))
      {
         if (PositionGetString(POSITION_SYMBOL) == symbol)
         {
            totalProfit += PositionGetDouble(POSITION_PROFIT);
         }
      }
   }

   return totalProfit;
}

void updateInfo()
{
   ObjectSetString(0, "labSummaryInfo", OBJPROP_TEXT,
      "ALL [Profit (" + _Symbol + "): " + totalPositionsSymbol + "/" + DoubleToString(buy_profit + sell_profit, 2) + "] , [" + totalPositions + "/" + DoubleToString(totalProfit,2) + "]");
      
   ObjectSetString(0, "labBuyInfo", OBJPROP_TEXT,
      "BUY [" + IntegerToString(buy_count) + " pos] [Profit: " +
      DoubleToString(buy_profit, 2) + "] [No SL: " + IntegerToString(buy_without_sl) +
      "] [+" + DoubleToString(buy_profit_from_tp, 2) + "] [" + DoubleToString(buy_loss_from_sl, 2) + "]");
      
   ObjectSetString(0, "labSellInfo", OBJPROP_TEXT,
      "SELL [" + IntegerToString(sell_count) + " pos] [Profit: " +
      DoubleToString(sell_profit, 2) + "] [No SL: " + IntegerToString(sell_without_sl) +
      "] [+" + DoubleToString(sell_profit_from_tp, 2) + "] [" + DoubleToString(sell_loss_from_sl, 2) + "]");
}

bool SendTelegramMessage( string url, string token, string chat, string text,
                          string fileName = "" ) {

   string headers    = "";
   string requestUrl = "";
   char   postData[];
   char   resultData[];
   string resultHeaders;
   int    timeout = 5000; // 1 second, may be too short for a slow connection

   ResetLastError();
   if(!isSendToTelegram) return false;

   if ( fileName == "" ) {
      requestUrl =
         StringFormat( "%s/bot%s/sendmessage?chat_id=%s&text=%s", url, token, chat, text );
   }
   else {
      requestUrl = StringFormat( "%s/bot%s/sendPhoto", url, token );
      if ( !GetPostData( postData, headers, chat, text, fileName ) ) {
         return ( false );
      }
   }

   ResetLastError();
   int response =
      WebRequest( "POST", requestUrl, headers, timeout, postData, resultData, resultHeaders );

   switch ( response ) {
   case -1: {
      int errorCode = GetLastError();
      Print( "Error in WebRequest. Error code  =", errorCode );
      if ( errorCode == UrlDefinedError ) {
         //--- url may not be listed
         PrintFormat( "Add the address '%s' in the list of allowed URLs", url );
      }
      break;
   }
   case 200:
      //--- Success
      Print( "The message has been successfully sent" );
      break;
   default: {
      string result = CharArrayToString( resultData );
      PrintFormat( "Unexpected Response '%i', '%s'", response, result );
      break;
   }
   }

   return ( response == 200 );
}

bool GetPostData( char &postData[], string &headers, string chat, string text, string fileName ) {

   ResetLastError();

   if ( !FileIsExist( fileName ) ) {
      PrintFormat( "File '%s' does not exist", fileName );
      return ( false );
   }

   int flags = FILE_READ | FILE_BIN;
   int file  = FileOpen( fileName, flags );
   if ( file == INVALID_HANDLE ) {
      int err = GetLastError();
      PrintFormat( "Could not open file '%s', error=%i", fileName, err );
      return ( false );
   }

   int   fileSize = ( int )FileSize( file );
   uchar photo[];
   ArrayResize( photo, fileSize );
   FileReadArray( file, photo, 0, fileSize );
   FileClose( file );

   string hash = "";
   AddPostData( postData, hash, "chat_id", chat );
   if ( StringLen( text ) > 0 ) {
      AddPostData( postData, hash, "caption", text );
   }
   AddPostData( postData, hash, "photo", photo, fileName );
   ArrayCopy( postData, "--" + hash + "--\r\n" );

   headers = "Content-Type: multipart/form-data; boundary=" + hash + "\r\n";

   return ( true );
}

void AddPostData( uchar &data[], string &hash, string key = "", string value = "" ) {

   uchar valueArr[];
   StringToCharArray( value, valueArr, 0, StringLen( value ) );

   AddPostData( data, hash, key, valueArr );
   return;
}

void AddPostData( uchar &data[], string &hash, string key, uchar &value[], string fileName = "" ) {

   if ( hash == "" ) {
      hash = Hash();
   }

   ArrayCopy( data, "\r\n" );
   ArrayCopy( data, "--" + hash + "\r\n" );
   if ( fileName == "" ) {
      ArrayCopy( data, "Content-Disposition: form-data; name=\"" + key + "\"\r\n" );
   }
   else {
      ArrayCopy( data, "Content-Disposition: form-data; name=\"" + key + "\"; filename=\"" +
                          fileName + "\"\r\n" );
   }
   ArrayCopy( data, "\r\n" );
   ArrayCopy( data, value, ArraySize( data ) );
   ArrayCopy( data, "\r\n" );

   return;
}

void ArrayCopy( uchar &dst[], string src ) {

   uchar srcArray[];
   StringToCharArray( src, srcArray, 0, StringLen( src ) );
   ArrayCopy( dst, srcArray, ArraySize( dst ), 0, ArraySize( srcArray ) );
   return;
}

string Hash() {

   uchar  tmp[];
   string seed = IntegerToString( TimeCurrent() );
   int    len  = StringToCharArray( seed, tmp, 0, StringLen( seed ) );
   string hash = "";
   for ( int i = 0; i < len; i++ )
      hash += StringFormat( "%02X", tmp[i] );
   hash = StringSubstr( hash, 0, 16 );

   return ( hash );
}


void DrawChartText(string name, string text, int x_offset, int y_offset, color clr = clrWhite, int font_size = 12)
{
   // If already exists, delete and re-create
   if (ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);

   // Create the text object
   if (!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
   {
      Print("❌ Failed to create label: ", name);
      return;
   }

   // Set text properties
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER); // Top-left corner
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x_offset);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y_offset);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true); // Hide from object list

   ObjectSetString(0, name, OBJPROP_TEXT, text);
   ObjectSetString(0, name, OBJPROP_FONT, "Arial");
}


//+------------------------------------------------------------------+
//| Timer event - Take screenshot                                    |
//+------------------------------------------------------------------+
void OnTimer()
{
   datetime now = TimeCurrent();

   if (now - lastShotTime >= IntervalSeconds)
   {
      string symbol   = _Symbol;
      string dateStr  = TimeToString(now, TIME_DATE);   // "2025.05.27"
      string timeStr  = TimeToString(now, TIME_SECONDS); // "08:45:00"
      StringReplace(dateStr, ".", "");
      StringReplace(timeStr, ":", "_");

      string fileName = symbol + "/" + symbol + "_" + dateStr + "_" + timeStr + ".png";

      if (ChartScreenShot(0, fileName, imageWidth, imageHeight, ALIGN_RIGHT))
      {
         Print("✅ Screenshot saved: ", fileName);
         //SendPhoto(fileName,"Test message");
         Sleep(10);
         //printf(fileName);
         //SendTelegramMessage( TelegramApiUrl, TelegramBotToken, ChatId,
         //                       "Test message " + TimeToString( TimeLocal() ) ); // no image attached

         if (_Symbol == "EURUSDm")
         {
            SendTelegramMessage(TelegramApiUrl, TelegramBotToken, "-1002194122590_191",
                                _Symbol + ", UP=" + UP_NRTRValue + ", DN=" + DN_NRTRValue, fileName);
         }
         else if (_Symbol == "GBPUSDm")
         {
            SendTelegramMessage(TelegramApiUrl, TelegramBotToken, "-1002194122590_192",
                                _Symbol + ", UP=" + UP_NRTRValue + ", DN=" + DN_NRTRValue, fileName);
         }
         else if (_Symbol == "USDJPYm")
         {
            SendTelegramMessage(TelegramApiUrl, TelegramBotToken, "-1002194122590_193",
                                _Symbol + ", UP=" + UP_NRTRValue + ", DN=" + DN_NRTRValue, fileName);
         }
         else if (_Symbol == "BTCUSDm")
         {
            SendTelegramMessage(TelegramApiUrl, TelegramBotToken, "-1002194122590_194",
                                _Symbol + ", UP=" + UP_NRTRValue + ", DN=" + DN_NRTRValue, fileName);
         }
         
         //SendTextToTelegram(fileName);
         //SendPhotoToTelegram2(fileName);
         //SendPhotoToTelegram(fileName);
         //SendPhotoToTelegram("GBPUSDm30-20246260101.png");
         //string message = "Test message from MT5 to group";
         //string url = "https://api.telegram.org/bot"+"7960128888:AAHwv-RbN77gaoCR1EJy7MlSIv573GWv2EM"+"/sendMessage?chat_id="+"-1002194122590"+"&text=Hello+from+MT5XX";
         //string headers;
         //char post[], result[];
         //int res = WebRequest("GET", url, headers, 10000, post, result, headers);
         //if (res != 200) {
         //   string response = CharArrayToString(result);
         //   Print("Error sending message: HTTP ", res, ", Response: ", response);
         //} else {
         //   Print("Message sent successfully");
         //}
         
         lastShotTime = now;
      }
      else
      {
         Print("❌ Screenshot failed: ", GetLastError());
      }
   }
}

void DrawNRTRHLine(string iName, int iIndex, double iPeriod, double iMultiply, color iColor, int iWidth = 1)
{
   double cus[];
   int handle = iCustom(_Symbol, _Period,iName, iPeriod, iMultiply,iIndex);
   if(handle != INVALID_HANDLE)
   {
      if(CopyBuffer(handle, 0, 0, 1, cus) > 0)
      {
         double curValue = cus[0];
         string name = iName+"_NRTRHLine_"+iIndex+iPeriod+iMultiply;
         if(!ObjectCreate(0, name, OBJ_HLINE, 0, 0, 0))
            ObjectDelete(0, name);

         ObjectCreate(0, name, OBJ_HLINE, 0, TimeCurrent(), curValue);
         ObjectSetInteger(0, name, OBJPROP_COLOR, iColor);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, iWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
      }
      IndicatorRelease(handle);
   }
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
      int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
      double pipSize = (_Digits == 3 || _Digits == 5) ? 1 * _Point : _Point;
      double pipDifference = MathAbs(UP_NRTRValue - DN_NRTRValue) / pipSize;
      int pipInt = (int)MathRound(pipDifference * 0.5);
      
      double lotSize = 0.1;
      
      if(sparam == "btnPlacePendding")
      {
         if(enableUpperNotify)
         {
            if (UP_NRTRValue != 0 && DN_NRTRValue != 0)
            {
               double tp  = pipInt + 300;
               double sl  = pipInt + 60;
               double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 2.0;
               PlacePendingOrder(_Symbol, BuyLimit, lotSize, middlePrice, sl, tp, "Buy Limit");
               
               tp  = pipInt + 300;
               sl  = pipInt + 40;
               PlacePendingOrder(_Symbol, SellLimit, lotSize, DN_NRTRValue + 50 * _Point, sl, tp, "Buy Stop");
            }
         }
         
         if(enableDownNotify)
         {
            if (UP_NRTRValue != 0 && DN_NRTRValue != 0)
            {
               double tp  = pipInt + 300;
               double sl  = pipInt + 60;
               double middlePrice = (UP_NRTRValue + DN_NRTRValue) / 2.0;
               PlacePendingOrder(_Symbol, SellLimit, lotSize, middlePrice, sl, tp, "Sell Limit");
               
               tp  = pipInt + 300;
               sl  = pipInt + 40;
               PlacePendingOrder(_Symbol, BuyStop, lotSize, UP_NRTRValue + 50 * _Point, sl, tp, "Sell Stop");
            }
         }
      }
         
      if(sparam == "btnEnableUpperNotify")
      {
         
         enableUpperNotify = !enableUpperNotify;
         string message = "🔔 UP  (" + enableUpperNotify + ") " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
                    "\nAsk: " + DoubleToString(ask, _Digits);

         SendNotification(message);
      
         CreateToggleButton("btnEnableUpperNotify", "Up.Notify" , enableUpperNotify);
         
      
         
      
      }
      
      if(sparam == "btnEnableDownNotify")
      {
         enableDownNotify = !enableDownNotify;
         string message = "🔔 DN (" +enableDownNotify + ") " + _Symbol + "\nBid: " + DoubleToString(bid, _Digits) +
                    "\nAsk: " + DoubleToString(ask, _Digits);

         SendNotification(message);
         CreateToggleButton("btnEnableDownNotify", "DN.Notify" , enableDownNotify, 170, 300);
         
         
      }
   }
}


//+------------------------------------------------------------------+
//| Main trade transaction handler                                   |
//+------------------------------------------------------------------+
//void OnTradeTransaction(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result)
//{
//   if (trans.type == TRADE_TRANSACTION_DEAL_ADD)
//   {
//      ulong   dealTicket = trans.deal;
//
//      if (!HistoryDealSelect(dealTicket))
//      {
//         Print("❌ Failed to select deal #", dealTicket);
//         return;
//      }
//
//      string symbol     = HistoryDealGetString(dealTicket, DEAL_SYMBOL);
//      double price      = HistoryDealGetDouble(dealTicket, DEAL_PRICE);
//      double sl         = HistoryDealGetDouble(dealTicket, DEAL_SL);
//     double tp         = HistoryDealGetDouble(dealTicket, DEAL_TP);
//      string comment    = HistoryDealGetString(dealTicket, DEAL_COMMENT);
//      string refId      = IntegerToString((int)HistoryDealGetInteger(dealTicket, DEAL_ORDER));
//      ENUM_DEAL_TYPE dealType = (ENUM_DEAL_TYPE)HistoryDealGetInteger(dealTicket, DEAL_TYPE);
//      string orderType  = DealTypeToString(dealType);
//
//      InsertTradeToSupabase(symbol, orderType, price, sl, tp, comment, refId);
//   }
//}

//+------------------------------------------------------------------+
//| Converts DEAL_TYPE to string                                     |
//+------------------------------------------------------------------+
string DealTypeToString(ENUM_DEAL_TYPE dealType)
{
   switch (dealType)
   {
      case DEAL_TYPE_BUY:  return "BUY";
      case DEAL_TYPE_SELL: return "SELL";
      default:             return "OTHER";
   }
}

//+------------------------------------------------------------------+
//| Sends trade data to Supabase                                     |
//+------------------------------------------------------------------+
void InsertTradeToSupabase(string currency, string type, double price, double sl, double tp, string comment, string refId)
{
   ResetLastError();

   string headers = 
      "Content-Type: application/json\r\n" +
      "apikey: " + SupabaseAPIKey + "\r\n" +
      "Authorization: Bearer " + SupabaseAPIKey;

   // Construct JSON
   string jsonPayload = "{";
   jsonPayload += "\"currency\":\"" + currency + "\",";
   jsonPayload += "\"type\":\"" + type + "\",";
   jsonPayload += "\"price\":" + DoubleToString(price, _Digits) + ",";
   jsonPayload += "\"sl\":" + DoubleToString(sl, _Digits) + ",";
   jsonPayload += "\"tp\":" + DoubleToString(tp, _Digits) + ",";
   jsonPayload += "\"comment\":" + (comment == "" ? "null" : "\"" + comment + "\"") + ",";
   jsonPayload += "\"ref\":\"" + refId + "\"";
   jsonPayload += "}";

   // Convert to UTF-8 bytes WITHOUT null terminator
   uchar postData[];
   StringToCharArray(jsonPayload, postData, 0, WHOLE_ARRAY, CP_UTF8);
   ArrayResize(postData, StringLen(jsonPayload));

   uchar result[];
   string responseHeaders;

   int res = WebRequest("POST", SupabaseURL, headers, 5000, postData, result, responseHeaders);

   if (res == 200 || res == 201)
      Print("✅ Trade sent to Supabase: ", jsonPayload);
   else
      Print("❌ WebRequest failed. Error: ", GetLastError(), ", Response: ", CharArrayToString(result));
}


void CreateButton(string name, int x, int y, string label, int width = 200)
{
   ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 25);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
   ObjectSetString(0, name, OBJPROP_TEXT, label);

   if(name == "btnCloseBuy")       ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrLime);
   else if(name == "btnCloseSell") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrOrange);
   else if(name == "btnOpenBuy") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrLime);
   else if(name == "btnOpenSell") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrRed);
}

void CreateToggleButton(string name, string label, bool enabled, int x = 5, int y = 300)
{
   ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, 150);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 25);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 9);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, enabled ? clrLime : clrRed);
   ObjectSetString(0, name, OBJPROP_TEXT, label + ": " + (enabled ? "ON" : "OFF"));
}


void DrawNRTRHLine(string iName, double iPrice, color iColor, int iWidth = 1)
{
   if(!ObjectCreate(0, iName, OBJ_HLINE, 0, 0, 0))
      ObjectDelete(0, iName);

   ObjectCreate(0, iName, OBJ_HLINE, 0, TimeCurrent(), iPrice);
   ObjectSetInteger(0, iName, OBJPROP_COLOR, iColor);
   ObjectSetInteger(0, iName, OBJPROP_WIDTH, iWidth);
   ObjectSetInteger(0, iName, OBJPROP_STYLE, STYLE_SOLID);
}

// Function to place a pending order of any supported type
bool PlacePendingOrder(
   string symbol,
   PendingOrderType orderType,
   double lotSize,
   double entryPrice,
   double stopLossPoints,
   double takeProfitPoints,
   string comment = "Pending Order"
)
{
   double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
   double stopLoss   = 0;
   double takeProfit = 0;

   switch (orderType)
   {
      case BuyLimit:
         stopLoss   = entryPrice - stopLossPoints * point;
         takeProfit = entryPrice + takeProfitPoints * point;
         if (!trade.BuyLimit(lotSize, entryPrice, symbol, stopLoss, takeProfit, ORDER_TIME_GTC, 0, comment))
         {
            Print("❌ Buy Limit failed: ", trade.ResultRetcodeDescription());
            return false;
         }
         Print("✅ Buy Limit placed at ", DoubleToString(entryPrice, _Digits));
         break;

      case SellLimit:
         stopLoss   = entryPrice + stopLossPoints * point;
         takeProfit = entryPrice - takeProfitPoints * point;
         if (!trade.SellLimit(lotSize, entryPrice, symbol, stopLoss, takeProfit, ORDER_TIME_GTC, 0, comment))
         {
            Print("❌ Sell Limit failed: ", trade.ResultRetcodeDescription());
            return false;
         }
         Print("✅ Sell Limit placed at ", DoubleToString(entryPrice, _Digits));
         break;

      case BuyStop:
         stopLoss   = entryPrice - stopLossPoints * point;
         takeProfit = entryPrice + takeProfitPoints * point;
         if (!trade.BuyStop(lotSize, entryPrice, symbol, stopLoss, takeProfit, ORDER_TIME_GTC, 0, comment))
         {
            Print("❌ Buy Stop failed: ", trade.ResultRetcodeDescription());
            return false;
         }
         Print("✅ Buy Stop placed at ", DoubleToString(entryPrice, _Digits));
         break;

      case SellStop:
         stopLoss   = entryPrice + stopLossPoints * point;
         takeProfit = entryPrice - takeProfitPoints * point;
         if (!trade.SellStop(lotSize, entryPrice, symbol, stopLoss, takeProfit, ORDER_TIME_GTC, 0, comment))
         {
            Print("❌ Sell Stop failed: ", trade.ResultRetcodeDescription());
            return false;
         }
         Print("✅ Sell Stop placed at ", DoubleToString(entryPrice, _Digits));
         break;

      default:
         Print("⚠️ Unsupported order type.");
         return false;
   }

   return true;
}

void UpdateCandleRemainingTime()
{
   datetime now = TimeCurrent();
   datetime candleStart = iTime(_Symbol, _Period, 0);
   int candleSeconds = PeriodSeconds(_Period); // candle duration
   int elapsed = (int)(now - candleStart);
   int remaining = candleSeconds - elapsed;

   if (remaining < 0) remaining = 0;

   int minutes = remaining / 60;
   int seconds = remaining % 60;
   string timeText = StringFormat("🕒 Left: %02d:%02d" + " [SP:" + DoubleToString(spreadPip,0) + "] [" + totalPositionsSymbol + "/" + DoubleToString(buy_profit + sell_profit, 2) + "] , [" + totalPositions + "/" + DoubleToString(totalProfit,2) + "]", minutes, seconds);

   if (ObjectFind(0, candleTimeLabel) < 0)
   {
      ObjectCreate(0, candleTimeLabel, OBJ_LABEL, 0, 0, 0);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_XDISTANCE, 600);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_YDISTANCE, 200);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_FONTSIZE, 12);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_COLOR, clrBlack);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, candleTimeLabel, OBJPROP_HIDDEN, true);
   }

   ObjectSetString(0, candleTimeLabel, OBJPROP_TEXT, timeText);
}
