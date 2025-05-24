//+------------------------------------------------------------------+
//|                                                   CloseButtonsEA |
//|                        DIYZ Creative                             |
//+------------------------------------------------------------------+
#property strict
#property script_show_inputs
#property version   "1.00"
#property description "Closes BUY, SELL, or ALL positions with profit shown in buttons"

#include <Trade\Trade.mqh>
CTrade trade;

input int x_offset = 10;
input int y_offset = 20;

double buy_profit = 0.0;
double sell_profit = 0.0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   ObjectCreate(0, "TestLabel", OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, "TestLabel", OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, "TestLabel", OBJPROP_XDISTANCE, 20);
   ObjectSetInteger(0, "TestLabel", OBJPROP_YDISTANCE, 20);
   ObjectSetString(0, "TestLabel", OBJPROP_TEXT, "EA is working!");
   Print("Init EA");
   EventSetTimer(1);
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();
   ObjectsDeleteAll(0, "", OBJ_BUTTON); // Clear only buttons
}

//+------------------------------------------------------------------+
//| Timer to update profit display                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
   CalculateProfits();
   UpdateButtonText();
}

//+------------------------------------------------------------------+
//| Calculate BUY and SELL profits                                   |
//+------------------------------------------------------------------+
void CalculateProfits()
{
   buy_profit = 0.0;
   sell_profit = 0.0;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionGetTicket(i) > 0 && PositionSelectByTicket(PositionGetTicket(i)))
      {
         double profit = PositionGetDouble(POSITION_PROFIT);
         int type = (int)PositionGetInteger(POSITION_TYPE);
         if(type == POSITION_TYPE_BUY)
            buy_profit += profit;
         else if(type == POSITION_TYPE_SELL)
            sell_profit += profit;
      }
   }
}

//+------------------------------------------------------------------+
//| Update text on each button                                       |
//+------------------------------------------------------------------+
void UpdateButtonText()
{
   ObjectSetString(0, "btnCloseBuy", OBJPROP_TEXT, "Close BUY\nProfit: " + DoubleToString(buy_profit, 2));
   ObjectSetString(0, "btnCloseSell", OBJPROP_TEXT, "Close SELL\nProfit: " + DoubleToString(sell_profit, 2));
   ObjectSetString(0, "btnCloseAll", OBJPROP_TEXT, "CLOSE ALL\nProfit: " + DoubleToString(buy_profit + sell_profit, 2));
}

//+------------------------------------------------------------------+
//| Expert tick function (creates buttons if missing)                |
//+------------------------------------------------------------------+
void OnTick()
{
   CreateButtons();
}

//+------------------------------------------------------------------+
//| Create UI buttons                                                |
//+------------------------------------------------------------------+
void CreateButtons()
{
   CreateButton("btnCloseBuy", x_offset, y_offset);
   CreateButton("btnCloseSell", x_offset, y_offset + 60);
   CreateButton("btnCloseAll", x_offset, y_offset + 120);
}

void CreateButton(string name, int x, int y)
{
   if(!ObjectFind(0, name))
   {
      if(!ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0))
         Print("Failed to create button: ", name, " Error: ", GetLastError());
      ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(0, name, OBJPROP_XSIZE, 140);
      ObjectSetInteger(0, name, OBJPROP_YSIZE, 50);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
   }
   
   
}

//+------------------------------------------------------------------+
//| Handle chart button clicks                                       |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      if(sparam == "btnCloseBuy")
         CloseBuyOrders();
      else if(sparam == "btnCloseSell")
         CloseSellOrders();
      else if(sparam == "btnCloseAll")
         CloseAllOrders();
   }
}

//+------------------------------------------------------------------+
//| Close only BUY orders                                            |
//+------------------------------------------------------------------+
void CloseBuyOrders()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
         trade.PositionClose(ticket);
   }
}

//+------------------------------------------------------------------+
//| Close only SELL orders                                           |
//+------------------------------------------------------------------+
void CloseSellOrders()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket) && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
         trade.PositionClose(ticket);
   }
}

//+------------------------------------------------------------------+
//| Close ALL orders                                                 |
//+------------------------------------------------------------------+
void CloseAllOrders()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
         trade.PositionClose(ticket);
   }
}
