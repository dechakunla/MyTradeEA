//+------------------------------------------------------------------+
//| iCustomReaderEA.mq5                                              |
//| Read iCustom indicator and display buffer value                  |
//+------------------------------------------------------------------+
#property strict

input string IndicatorName = "slopedirectionline"; // *.ex5 file in Indicators folder
input int BufferIndex = 0;                    // Which buffer to read from
input int Shift = 0;                          // 0 = current candle, 1 = last closed, etc.
input string LabelName = "CustomIndicatorValue";
input int LabelX = 20;
input int LabelY = 40;

int OnInit()
{
   ObjectDelete(0, LabelName);
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   ObjectDelete(0, LabelName);
}

void OnTick()
{
   // Load iCustom indicator handle
   static int handle = INVALID_HANDLE;
   if (handle == INVALID_HANDLE)
   {
      handle = iCustom(_Symbol, PERIOD_CURRENT, IndicatorName,15);
      if (handle == INVALID_HANDLE)
      {
         Print("Failed to load iCustom: ", IndicatorName);
         return;
      }
   }

   // Read buffer value
   double bufferValue[];
   if (CopyBuffer(handle, BufferIndex, Shift, 1, bufferValue) != 1)
   {
      Print("Failed to read iCustom buffer.");
      return;
   }

   string valueStr = DoubleToString(bufferValue[0], 5);
   string text = "iCustom Value: " + valueStr;

   DrawTextObject(LabelName, text, LabelX, LabelY);
}

//+------------------------------------------------------------------+
//| Draw or update chart text label                                  |
//+------------------------------------------------------------------+
void DrawTextObject(string name, string text, int x, int y)
{
   if (!ObjectFind(0, name))
   {
      ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
   }

   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 12);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrGold);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
}
