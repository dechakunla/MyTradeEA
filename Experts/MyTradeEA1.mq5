#property strict
#property version   "1.14"

#include <Trade\Trade.mqh>
CTrade trade;

int MAXORDER = 4;
double LOT = 0.01;

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

bool blinkBuyTP = false;
bool blinkSellTP = false;
datetime lastBlinkTP = 0;

double iSar1_1 = 0.03;
double iSar1_2 = 0.001;
bool autoTradeEnabled = false;

int OnInit()
{
   DrawStyledText("txtBuyCurrentInfo", "-", 5, 120);
   DrawStyledText("txtSellCurrentInfo", "-", 5, 145);

   DrawStyledText("txtBuyTradeHistory", "txtBuyTradeHistory", 300, 5);
   DrawStyledText("txtSellTradeHistory", "txtSellTradeHistory", 300,25);

   CreateButton("btnCloseAll", 5, 80 + 100, "CLOSE ALL", 600);
   CreateButton("btnCloseBuy", 5, 20 + 120 + 100, "Close BUY", 600);
   CreateButton("btnCloseSell", 5, 80 + 120 + 100, "Close SELL", 600);
   CreateButton("btnSetBuyTP", 5, 140  + 20 + 120 + 80 + 100, "Set BUY TP");
   CreateButton("btnSetBuySL", 5, 140 + 20 + 120 + 80 + 60 + 100, "Set BUY SL");
   CreateButton("btnSetSellTP", 5, 140 + 20 + 20 + 120 + 80 + 60 + 60 + 100, "Set SELL TP");
   CreateButton("btnSetSellSL", 5, 140 + 20 + 20 + 120 + 80 + 60 + 60 + 60 + 100, "Set SELL SL");
   CreateButton("btnCloseMostProfitBuy", 620 + 230, 20 + 120 +  100, "Close Profit BUY");
   CreateButton("btnCloseMostProfitSell", 620 + 230, 80 + 120 + 100, "Close Profit SELL");
   CreateButton("btnCloseWorstBuy", 620, 20 + 120 + 100, "Close Worst BUY");
   CreateButton("btnCloseWorstSell", 620, 80 + 120 + 100, "Close Worst SELL");
   CreateButton("btnOpenBuy", 620 + 230, 140  + 20 + 120 + 80 + 100, "Open BUY");
   CreateButton("btnOpenSell", 620 + 230, 140 + 20 + 20 + 120 + 80 + 60 + 60 + 100, "Open SELL");
   
   CreateToggleButton("btnAutoTrade", 620, 5, "Auto Trade", autoTradeEnabled);
   
   EventSetTimer(1);
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   EventKillTimer();
   ObjectDelete(0,"sar_hline_"+iSar1_1+iSar1_2);
   ObjectDelete(0, "txtBuyCurrentInfo");
   ObjectDelete(0, "txtSellCurrentInfo");
   
   ObjectDelete(0, "txtBuyTradeHistory");
   ObjectDelete(0, "txtSellTradeHistory");

   ObjectDelete(0, "btnCloseBuy");
   ObjectDelete(0, "btnCloseSell");
   ObjectDelete(0, "btnCloseAll");
   ObjectDelete(0, "btnSetBuyTP");
   ObjectDelete(0, "btnSetSellTP");
   ObjectDelete(0, "btnSetBuySL");
   ObjectDelete(0, "btnSetSellSL");
   ObjectDelete(0, "btnCloseMostProfitBuy");
   ObjectDelete(0, "btnCloseMostProfitSell");
   ObjectDelete(0, "btnCloseWorstBuy");
   ObjectDelete(0, "btnCloseWorstSell");
   ObjectDelete(0, "btnOpenBuy");
   ObjectDelete(0, "btnOpenSell");
   
   ObjectDelete(0, "btnAutoTrade");
}

void OnTimer()
{
   DrawSARHLine(iSar1_1,iSar1_2,clrLime,1);
   //DrawSARHLine(0.01,0.001,clrLime,3);
   //DrawNRTRHLine("Free Indicators\NRTR Channel",0,200,6.0,clrRed,1);
   
   CalculateProfits();
   CalculatePotentialLossFromSL();
   ApplyMissingStopLosses();
   blinkBuyTP = !blinkBuyTP;
   blinkSellTP = !blinkSellTP;

   blinkBuySL = !blinkBuySL;
   blinkSellSL = !blinkSellSL;

   UpdateButtons();
   
   updateBuyTradeHistorySummary();
   updateSellTradeHistorySummary();   
}

void OnTick() {}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      if(sparam == "btnCloseBuy") CloseBuyOrders();
      else if(sparam == "btnCloseSell") CloseSellOrders();
      else if(sparam == "btnCloseAll") CloseAllOrders();
      else if(sparam == "btnSetBuySL") SetBuyStopLossFromHLine();
      else if(sparam == "btnSetSellSL") SetSellStopLossFromHLine();
      else if(sparam == "btnSetBuyTP") SetBuyTakeProfitFromHLine();
      else if(sparam == "btnSetSellTP") SetSellTakeProfitFromHLine();
      else if(sparam == "btnCloseMostProfitBuy") CloseMostProfitBuyPosition();
      else if(sparam == "btnCloseMostProfitSell") CloseMostProfitSellPosition();
      else if(sparam == "btnCloseWorstBuy") CloseWorstBuyPosition();
      else if(sparam == "btnCloseWorstSell") CloseWorstSellPosition();
      else if(sparam == "btnOpenBuy") OpenBuyPosition();
      else if(sparam == "btnOpenSell") OpenSellPosition();
      
      if(sparam == "btnAutoTrade")
      {
         autoTradeEnabled = !autoTradeEnabled;
         CreateToggleButton("btnAutoTrade", 620, 5, "Auto Trade", autoTradeEnabled);
      }

   }
}

void CreateToggleButton(string name, int x, int y, string label, bool enabled)
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


void CreateButton(string name, int x, int y, string label, int width = 200)
{
   ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 50);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
   ObjectSetString(0, name, OBJPROP_TEXT, label);

   if(name == "btnCloseBuy")       ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrLime);
   else if(name == "btnCloseSell") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrOrange);
   else if(name == "btnOpenBuy") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrLime);
   else if(name == "btnOpenSell") ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrRed);
}

void UpdateButtons()
{
   ObjectSetString(0, "txtBuyCurrentInfo", OBJPROP_TEXT,
      "BUY [" + IntegerToString(buy_count) + " pos] [Profit: " +
      DoubleToString(buy_profit, 2) + "] [No SL: " + IntegerToString(buy_without_sl) +
      "] [+" + DoubleToString(buy_profit_from_tp, 2) + "] [" + DoubleToString(buy_loss_from_sl, 2) + "]");
      
      ObjectSetString(0, "btnCloseBuy", OBJPROP_TEXT,
      "X BUY [" + IntegerToString(buy_count) + " pos] [Profit: " +
      DoubleToString(buy_profit, 2) + "]");

   ObjectSetString(0, "txtSellCurrentInfo", OBJPROP_TEXT,
      "SELL [" + IntegerToString(sell_count) + " pos] [Profit: " +
      DoubleToString(sell_profit, 2) + "] [No SL: " + IntegerToString(sell_without_sl) +
      "] [+" + DoubleToString(sell_profit_from_tp, 2) + "] [" + DoubleToString(sell_loss_from_sl, 2) + "]");
      
   ObjectSetString(0, "btnCloseSell", OBJPROP_TEXT,
      "X SELL [" + IntegerToString(sell_count) + " pos] [Profit: " +
      DoubleToString(sell_profit, 2) + "]");

   ObjectSetString(0, "btnCloseAll", OBJPROP_TEXT,
      "X ALL [Profit: " + DoubleToString(buy_profit + sell_profit, 2) + "]");

   ObjectSetInteger(0, "btnSetBuySL", OBJPROP_BGCOLOR, buy_without_sl > 0 ? (blinkBuySL ? clrRed : clrWhite) : clrSkyBlue);
   ObjectSetInteger(0, "btnSetSellSL", OBJPROP_BGCOLOR, sell_without_sl > 0 ? (blinkSellSL ? clrRed : clrWhite) : clrThistle);

   ObjectSetInteger(0, "btnSetBuyTP", OBJPROP_BGCOLOR, buy_without_tp > 0 ? (blinkBuyTP ? clrRed : clrWhite) : clrSkyBlue);
   ObjectSetInteger(0, "btnSetSellTP", OBJPROP_BGCOLOR, sell_without_tp > 0 ? (blinkSellTP ? clrRed : clrWhite) : clrThistle);
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

void CalculatePotentialLossFromSL()
{
   buy_profit_from_tp = 0;
   sell_profit_from_tp = 0;
   buy_loss_from_sl = 0;
   sell_loss_from_sl = 0;
   string symbol = _Symbol;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double price_open = PositionGetDouble(POSITION_PRICE_OPEN);
         double tp = PositionGetDouble(POSITION_TP);
         double sl = PositionGetDouble(POSITION_SL);
         double volume = PositionGetDouble(POSITION_VOLUME);
         int type = (int)PositionGetInteger(POSITION_TYPE);
         double tick_value = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
         double tick_size = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);

         if(tp <= 0.0) continue;
         if(sl <= 0.0) continue;

         double price_diff_tp = 0;
         double price_diff_sl = 0;

         if(type == POSITION_TYPE_BUY && tp > price_open && sl < price_open)
         {
            price_diff_tp =  tp - price_open;
            price_diff_sl = price_open - sl;
         }
         else if(type == POSITION_TYPE_SELL && tp < price_open && sl > price_open)
         {
            price_diff_tp = price_open - tp;
            price_diff_sl = sl - price_open;
         }

         double profit = (price_diff_tp / tick_size) * tick_value * volume;
         double loss = (price_diff_sl / tick_size) * tick_value * volume;
         if(type == POSITION_TYPE_BUY) 
         {
            buy_profit_from_tp += MathAbs(profit);
            buy_loss_from_sl -= MathAbs(loss);
         }
         if(type == POSITION_TYPE_SELL)
         {
            sell_profit_from_tp += MathAbs(profit);
            sell_loss_from_sl -= MathAbs(loss);
         }
      }
   }
}

void ApplyMissingStopLosses()
{
   string symbol = _Symbol;
   double commonBuyTP = 0;
   double commonSellTP = 0;
   double commonBuySL = 0;
   double commonSellSL = 0;
   bool buyTPFound = false;
   bool sellTPFound = false;
   bool buySLFound = false;
   bool sellSLFound = false;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         int type = (int)PositionGetInteger(POSITION_TYPE);
         double tp = PositionGetDouble(POSITION_TP);
         double sl = PositionGetDouble(POSITION_SL);
         if(type == POSITION_TYPE_BUY)
         {
            if(sl > 0 && !buySLFound)
            {
               commonBuySL = sl;
               buySLFound = true;
            }
            else if(tp > 0 && !buyTPFound){
               commonBuyTP = tp;
               buyTPFound = true;
            }            
         }
         else if(type == POSITION_TYPE_SELL)
         {
            if(sl > 0 && !sellSLFound)
            {
               commonSellSL = sl;
               sellSLFound = true;
            }
            else if(tp > 0 && !sellTPFound)
            {
               commonSellTP = tp;
               sellTPFound = true;
            }
         }
      }
   }

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         int type = (int)PositionGetInteger(POSITION_TYPE);
         double sl = PositionGetDouble(POSITION_SL);
         double tp = PositionGetDouble(POSITION_TP);

         if(type == POSITION_TYPE_BUY)
         {
            if(sl <= 0 && buySLFound)
            {
               trade.PositionModify(ticket, commonBuySL, tp);
            }
            else if(tp <= 0 && buyTPFound)
            {
               trade.PositionModify(ticket, sl, commonBuyTP);
            }
            
         }
         else if(type == POSITION_TYPE_SELL)
         {
            if(sl <= 0 && sellSLFound)
            {
               trade.PositionModify(ticket, commonSellSL, tp);
            }
            else if(tp <= 0 && sellTPFound)
            {
               trade.PositionModify(ticket, sl, commonSellTP);
            }            
         }
      }
   }
}

void CloseBuyOrders()
{
   string symbol = _Symbol;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY &&
         PositionGetString(POSITION_SYMBOL) == symbol)
         trade.PositionClose(ticket);
   }
}

void CloseSellOrders()
{
   string symbol = _Symbol;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL &&
         PositionGetString(POSITION_SYMBOL) == symbol)
         trade.PositionClose(ticket);
   }
}

void CloseAllOrders()
{
   string symbol = _Symbol;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
         trade.PositionClose(ticket);
   }
}

//+------------------------------------------------------------------+
void SetBuyTakeProfitFromHLine()
{
   string symbol = _Symbol;
   double tp = 0.0;
   bool found = false;

   for(int i = ObjectsTotal(0) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
      {
         tp = ObjectGetDouble(0, name, OBJPROP_PRICE);
         found = true;
      }
   }

   if(!found) return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double sl = PositionGetDouble(POSITION_SL);
         trade.PositionModify(ticket, sl, tp);
      }
   }

   DeleteAllHLINES();
   Print("✅ BUY TP set to ", DoubleToString(tp, _Digits));
}

//+------------------------------------------------------------------+
void SetSellTakeProfitFromHLine()
{
   string symbol = _Symbol;
   double tp = 0.0;
   bool found = false;

   for(int i = ObjectsTotal(0) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
      {
         tp = ObjectGetDouble(0, name, OBJPROP_PRICE);
         found = true;
      }
   }

   if(!found) return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double sl = PositionGetDouble(POSITION_SL);
         trade.PositionModify(ticket, sl, tp);
      }
   }

   DeleteAllHLINES();
   Print("✅ SELL TP set to ", DoubleToString(tp, _Digits));
}

void SetBuyStopLossFromHLine()
{
   string symbol = _Symbol;
   double sl = 0.0;
   bool found = false;

   for(int i = ObjectsTotal(0) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
      {
         sl = ObjectGetDouble(0, name, OBJPROP_PRICE);
         found = true;
      }
   }

   if(!found) return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double tp = PositionGetDouble(POSITION_TP);
         trade.PositionModify(ticket, sl, tp);
      }
   }

   DeleteAllHLINES();
   Print("✅ BUY SL set to ", DoubleToString(sl, _Digits));
}

void SetSellStopLossFromHLine()
{
   string symbol = _Symbol;
   double sl = 0.0;
   bool found = false;

   for(int i = ObjectsTotal(0) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
      {
         sl = ObjectGetDouble(0, name, OBJPROP_PRICE);
         found = true;
      }
   }

   if(!found) return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double tp = PositionGetDouble(POSITION_TP);
         trade.PositionModify(ticket, sl, tp);
      }
   }

   DeleteAllHLINES();
   Print("✅ SELL SL set to ", DoubleToString(sl, _Digits));
}

void DeleteAllHLINES()
{
   for(int i = ObjectsTotal(0) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
         ObjectDelete(0, name);
   }
}

void CloseMostProfitBuyPosition()
{
   string symbol = _Symbol;
   double mostProfit = 0;
   ulong mostTicket = 0;
   bool found = false;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         if(!found || profit > mostProfit)
         {
            mostProfit = profit;
            mostTicket = ticket;
            found = true;
         }
      }
   }

   if(found)
      trade.PositionClose(mostTicket);
}


void CloseMostProfitSellPosition()
{
   string symbol = _Symbol;
   double mostProfit = 0;
   ulong mostTicket = 0;
   bool found = false;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         if(!found || profit > mostProfit)
         {
            mostProfit = profit;
            mostTicket = ticket;
            found = true;
         }
      }
   }

   if(found)
      trade.PositionClose(mostTicket);
}

void CloseWorstBuyPosition()
{
   string symbol = _Symbol;
   double worstProfit = 0;
   ulong worstTicket = 0;
   bool found = false;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         if(!found || profit < worstProfit)
         {
            worstProfit = profit;
            worstTicket = ticket;
            found = true;
         }
      }
   }

   if(found)
      trade.PositionClose(worstTicket);
}

void CloseWorstSellPosition()
{
   string symbol = _Symbol;
   double worstProfit = 0;
   ulong worstTicket = 0;
   bool found = false;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) &&
         PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL &&
         PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         if(!found || profit < worstProfit)
         {
            worstProfit = profit;
            worstTicket = ticket;
            found = true;
         }
      }
   }

   if(found)
      trade.PositionClose(worstTicket);
}

double GetLastLotSize(int positionType)
{
   double lastLot = 0.1;
   datetime latestTime = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
      {
         if(PositionGetInteger(POSITION_TYPE) == positionType &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            datetime time = (datetime)PositionGetInteger(POSITION_TIME);
            if(time > latestTime)
            {
               latestTime = time;
               lastLot = PositionGetDouble(POSITION_VOLUME);
            }
         }
      }
   }
   return lastLot;
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

void OpenBuyPosition()
{
   //double lot = GetLastLotSize(POSITION_TYPE_BUY);
   
   if(GetOrderCount(POSITION_TYPE_BUY) >= MAXORDER) return;
   
   if(!trade.Buy(LOT, _Symbol))
      Print("❌ Failed to open BUY: ", trade.ResultRetcodeDescription());
   else
      Print("✅ Opened BUY position with lot ", LOT);
}

void OpenSellPosition()
{
   //double lot = GetLastLotSize(POSITION_TYPE_SELL);
   if(GetOrderCount(POSITION_TYPE_SELL) >= MAXORDER) return;
   
   if(!trade.Sell(LOT, _Symbol))
      Print("❌ Failed to open SELL: ", trade.ResultRetcodeDescription());
   else
      Print("✅ Opened SELL position with lot ", LOT);
}


double GetLastTP(int positionType)
{
   double lastTP = 0.0;
   datetime latestTime = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
      {
         if(PositionGetInteger(POSITION_TYPE) == positionType &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            datetime time = (datetime)PositionGetInteger(POSITION_TIME);
            if(time > latestTime)
            {
               latestTime = time;
               lastTP = PositionGetDouble(POSITION_TP);
            }
         }
      }
   }
   return lastTP;
}

void DrawStyledText(string name, string text, int x = 10, int y = 30)
{
   if (!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
      Print("Failed to create label: ", name);

   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 9);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrWhite);         // Text color
   ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, BORDER_RAISED);
   ObjectSetInteger(0, name, OBJPROP_BACK, true);              // Enable background
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
   ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrRed);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
}


void updateBuyTradeHistorySummary()
{
   double sumProfit = 0;
   string summary = "Buy Trade history:";
   string symbol = _Symbol;

   for(int i = HistoryDealsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = HistoryDealGetTicket(i);
      if(HistoryDealSelect(ticket))
      {
         if(HistoryDealGetString(ticket, DEAL_SYMBOL) == symbol &&
            HistoryDealGetInteger(ticket, DEAL_TYPE) == DEAL_TYPE_BUY)
         {
            double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
            sumProfit += profit;
            if(profit == 0)
            {
               summary += " | SUM=" + DoubleToString(sumProfit, 2);
               sumProfit = 0;
            }
         }
      }
   }
   summary += " | SUM=" + DoubleToString(sumProfit, 2);
   ObjectSetString(0, "txtBuyTradeHistory", OBJPROP_TEXT, summary);
}

void updateSellTradeHistorySummary()
{
   double sumProfit = 0;
   string summary = "Sell Trade history:";
   string symbol = _Symbol;

   for(int i = HistoryDealsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = HistoryDealGetTicket(i);
      if(HistoryDealSelect(ticket))
      {
         if(HistoryDealGetString(ticket, DEAL_SYMBOL) == symbol &&
            HistoryDealGetInteger(ticket, DEAL_TYPE) == DEAL_TYPE_SELL)
         {
            double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
            sumProfit += profit;
            if(profit == 0)
            {
               summary += " | SUM=" + DoubleToString(sumProfit, 2);
               sumProfit = 0;
            }
         }
      }
   }
   summary += " | SUM=" + DoubleToString(sumProfit, 2);
   
   ObjectSetString(0, "txtSellTradeHistory", OBJPROP_TEXT, summary);
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

void DrawNRTRHLine(string iName, int iIndex, double iPeriod, double iMultiply, color iColor, int iWidth = 1)
{
   double cus[];
   int handle = iCustom(_Symbol, _Period,iName, iPeriod, iMultiply,iIndex);
   if(handle != INVALID_HANDLE)
   {
      if(CopyBuffer(handle, 0, 0, 1, cus) > 0)
      {
         double curValue = cus[0];
         string name = iName+"_hline_"+iIndex+iPeriod+iMultiply;
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