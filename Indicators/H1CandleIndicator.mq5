//+------------------------------------------------------------------+
//| H4CandleIndicator.mq5                                           |
//| This indicator draws H4 candlesticks on the current chart         |
//+------------------------------------------------------------------+
#property copyright "Your Name"
#property link      "https://www.example.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_plots 0

// Input parameters
input int NumberOfCandles = 100;          // Number of H4 candles to draw
input color BullishCandleColor = clrLimeGreen; // Color for bullish candles
input color BearishCandleColor = clrRed;       // Color for bearish candles
input int CandleWidth = 5;                    // Width of candle body in pixels

//+------------------------------------------------------------------+
//| Custom indicator initialization function                          |
//+------------------------------------------------------------------+
int OnInit()
{
   // Clear existing objects to avoid duplicates
   ObjectsDeleteAll(0, "H4Candle_");
   // Draw H4 candles on initialization
   DrawH4Candles();
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                        |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Remove all drawn objects when indicator is removed
   ObjectsDeleteAll(0, "H4Candle_");
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                               |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   // Redraw candles on new M1 bar
   static datetime lastBar;
   datetime currentBar = iTime(_Symbol, PERIOD_M1, 0);
   if(lastBar != currentBar)
   {
      DrawH4Candles();
      lastBar = currentBar;
   }
   return(rates_total);
}

//+------------------------------------------------------------------+
//| Function to draw H4 candles on the current chart                  |
//+------------------------------------------------------------------+
void DrawH4Candles()
{
   // Clear previous objects
   ObjectsDeleteAll(0, "H4Candle_");
   
   // Loop through the number of H4 candles to draw
   for(int i = 0; i < NumberOfCandles; i++)
   {
      // Get H4 candle data
      datetime time = iTime(_Symbol, PERIOD_H4, i);
      double open = iOpen(_Symbol, PERIOD_H4, i);
      double high = iHigh(_Symbol, PERIOD_H4, i);
      double low = iLow(_Symbol, PERIOD_H4, i);
      double close = iClose(_Symbol, PERIOD_H4, i);
      
      // Check if data is valid
      if(time == 0 || open == 0 || high == 0 || low == 0 || close == 0)
         continue;
      
      // Determine if candle is bullish or bearish
      bool isBullish = close >= open;
      color candleColor = isBullish ? BullishCandleColor : BearishCandleColor;
      
      // Draw candle body
      string bodyName = "H4Candle_Body_" + IntegerToString(i);
      double bodyTop = MathMax(open, close);
      double bodyBottom = MathMin(open, close);
      ObjectCreate(0, bodyName, OBJ_RECTANGLE, 0, time, bodyTop, time + PeriodSeconds(PERIOD_H4), bodyBottom);
      ObjectSetInteger(0, bodyName, OBJPROP_COLOR, candleColor);
      ObjectSetInteger(0, bodyName, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, bodyName, OBJPROP_WIDTH, CandleWidth);
      ObjectSetInteger(0, bodyName, OBJPROP_FILL, false);
      ObjectSetInteger(0, bodyName, OBJPROP_BACK, false);
      
      // Draw upper wick
      if(high > bodyTop)
      {
         string upperWickName = "H4Candle_UpperWick_" + IntegerToString(i);
         ObjectCreate(0, upperWickName, OBJ_TREND, 0, time + PeriodSeconds(PERIOD_H4)/2, bodyTop, time + PeriodSeconds(PERIOD_H4)/2, high);
         ObjectSetInteger(0, upperWickName, OBJPROP_COLOR, candleColor);
         ObjectSetInteger(0, upperWickName, OBJPROP_WIDTH, 1);
         ObjectSetInteger(0, upperWickName, OBJPROP_BACK, false);
         ObjectSetInteger(0, upperWickName, OBJPROP_RAY, false);
      }
      
      // Draw lower wick
      if(low < bodyBottom)
      {
         string lowerWickName = "H4Candle_LowerWick_" + IntegerToString(i);
         ObjectCreate(0, lowerWickName, OBJ_TREND, 0, time + PeriodSeconds(PERIOD_H4)/2, bodyBottom, time + PeriodSeconds(PERIOD_H4)/2, low);
         ObjectSetInteger(0, lowerWickName, OBJPROP_COLOR, candleColor);
         ObjectSetInteger(0, lowerWickName, OBJPROP_WIDTH, 1);
         ObjectSetInteger(0, lowerWickName, OBJPROP_BACK, false);
         ObjectSetInteger(0, lowerWickName, OBJPROP_RAY, false);
      }
   }
   
   // Update chart to reflect changes
   ChartRedraw();
}
//+------------------------------------------------------------------+