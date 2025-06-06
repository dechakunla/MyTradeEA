//+------------------------------------------------------------------+
//|                             MyTRADER1.mq5                        |
//|                         DIYZ Creative                            |
//+------------------------------------------------------------------+
#property strict
#property version   "1.05"

#include <Trade\Trade.mqh>
CTrade trade;

double buy_profit = 0.0;
double sell_profit = 0.0;
int buy_without_sl = 0;
int sell_without_sl = 0;

//+------------------------------------------------------------------+
//| Set SL using last HLINE and delete all HLINEs                    |
//+------------------------------------------------------------------+
void CheckAndSetStopLossFromHLine()
{
   string symbol = _Symbol;
   int total = ObjectsTotal(0);

   double selectedSL = 0.0;
   bool foundLine = false;

   for(int i = total - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
      {
         selectedSL = ObjectGetDouble(0, name, OBJPROP_PRICE);
         foundLine = true;
      }
   }

   if(!foundLine)
      return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double tp = PositionGetDouble(POSITION_TP);
         double current_sl = PositionGetDouble(POSITION_SL);

         if(MathAbs(current_sl - selectedSL) < SymbolInfoDouble(symbol, SYMBOL_POINT))
            continue;

         trade.PositionModify(ticket, selectedSL, tp);
      }
   }

   for(int i = total - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i);
      if(ObjectGetInteger(0, name, OBJPROP_TYPE) == OBJ_HLINE)
         ObjectDelete(0, name);
   }

   Print("✅ SL set to ", DoubleToString(selectedSL, _Digits), " and all HLINEs deleted.");
}

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   CreateButton("btnCloseBuy", 5, 20 + 120 + 400, "Close BUY");
   CreateButton("btnCloseSell", 5, 80 + 20 + 120 + 400, "Close SELL");
   CreateButton("btnCloseAll", 5, 140 + 20 + 20 + 120 + 400, "CLOSE ALL");

   EventSetTimer(1);
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();
   ObjectDelete(0, "btnCloseBuy");
   ObjectDelete(0, "btnCloseSell");
   ObjectDelete(0, "btnCloseAll");
}

//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void OnTimer()
{
   CalculateProfits();
   UpdateButtons();
   CheckAndSetStopLossFromHLine();
}

//+------------------------------------------------------------------+
//| Unused                                                           |
//+------------------------------------------------------------------+
void OnTick() {}

//+------------------------------------------------------------------+
//| OnClick Events                                                   |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      if(sparam == "btnCloseBuy") CloseBuyOrders();
      if(sparam == "btnCloseSell") CloseSellOrders();
      if(sparam == "btnCloseAll") CloseAllOrders();
   }
}

//+------------------------------------------------------------------+
//| Create Button                                                    |
//+------------------------------------------------------------------+
void CreateButton(string name, int x, int y, string label)
{
   ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, 300);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 50);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
   ObjectSetString(0, name, OBJPROP_TEXT, label);

   if(name == "btnCloseBuy")
      ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrLime);
   else if(name == "btnCloseSell")
      ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrOrange);
}

//+------------------------------------------------------------------+
//| Update Profit Labels                                             |
//+------------------------------------------------------------------+
void UpdateButtons()
{
   ObjectSetString(0, "btnCloseBuy", OBJPROP_TEXT,
      "Close BUY [Profit: " + DoubleToString(buy_profit, 2) +
      "]   [No SL: " + IntegerToString(buy_without_sl)+"]");

   ObjectSetString(0, "btnCloseSell", OBJPROP_TEXT,
      "Close SELL[Profit: " + DoubleToString(sell_profit, 2) +
      "]   [No SL: " + IntegerToString(sell_without_sl)+"]");

   ObjectSetString(0, "btnCloseAll", OBJPROP_TEXT,
      "CLOSE ALL [Profit: " + DoubleToString(buy_profit + sell_profit, 2)+"]");
}

//+------------------------------------------------------------------+
//| Calculate Profit + SL count                                      |
//+------------------------------------------------------------------+
void CalculateProfits()
{
   buy_profit = 0;
   sell_profit = 0;
   buy_without_sl = 0;
   sell_without_sl = 0;

   string symbol = _Symbol;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         double sl = PositionGetDouble(POSITION_SL);
         int type = (int)PositionGetInteger(POSITION_TYPE);

         if(type == POSITION_TYPE_BUY)
         {
            buy_profit += profit;
            if(sl <= 0.0)
               buy_without_sl++;
         }
         else if(type == POSITION_TYPE_SELL)
         {
            sell_profit += profit;
            if(sl <= 0.0)
               sell_without_sl++;
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Close BUY Positions                                              |
//+------------------------------------------------------------------+
void CloseBuyOrders()
{
   string symbol = _Symbol;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            trade.PositionClose(ticket);
      }
   }
}

//+------------------------------------------------------------------+
//| Close SELL Positions                                             |
//+------------------------------------------------------------------+
void CloseSellOrders()
{
   string symbol = _Symbol;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetString(POSITION_SYMBOL) == symbol)
      {
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
            trade.PositionClose(ticket);
      }
   }
}

//+------------------------------------------------------------------+
//| Close ALL Positions                                              |
//+------------------------------------------------------------------+
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
