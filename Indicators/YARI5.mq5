#property copyright "Ramdass - Conversion only"
#property link      ""
#property version   "1.10"
#property indicator_chart_window 
#property indicator_buffers 5
#property indicator_plots   1
#property indicator_type1   DRAW_COLOR_CANDLES
#property indicator_color1  clrLimeGreen,clrBlack,clrGray,clrChocolate,clrGold
#property indicator_label1  "BykovTrendOpen;BykovTrendHigh;BykovTrendLow;BykovTrendClose"
#define RESET  0
input int RISK=3;
input int SSP=9;
double ExtOpenBuffer[],ExtHighBuffer[],ExtLowBuffer[],ExtCloseBuffer[],ExtColorsBuffer[];
int K,WPR_Handle,min_rates_total;
int OnInit()
  {
   K=33-RISK;
   min_rates_total=int(SSP)+1;
   WPR_Handle=iWPR(NULL,0,SSP);
   if(WPR_Handle==INVALID_HANDLE)
     {
      Print(" Не удалось получить хендл индикатора iWPR");
      return(INIT_FAILED);
     }
   SetIndexBuffer(0,ExtOpenBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,ExtHighBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,ExtLowBuffer,INDICATOR_DATA);
   SetIndexBuffer(3,ExtCloseBuffer,INDICATOR_DATA);
   SetIndexBuffer(4,ExtColorsBuffer,INDICATOR_COLOR_INDEX);
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,min_rates_total);
   ArraySetAsSeries(ExtOpenBuffer,true);
   ArraySetAsSeries(ExtHighBuffer,true);
   ArraySetAsSeries(ExtLowBuffer,true);
   ArraySetAsSeries(ExtCloseBuffer,true);
   ArraySetAsSeries(ExtColorsBuffer,true);
   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
   string short_name="BykovTrend_V2";
   IndicatorSetString(INDICATOR_SHORTNAME,short_name);
   return(INIT_SUCCEEDED);
  }
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
   if(BarsCalculated(WPR_Handle)<rates_total || rates_total<min_rates_total)
      return(RESET);
   int to_copy,limit,bar,trend;
   double WPR[];
   static int oldtrend;
   if(prev_calculated>rates_total || prev_calculated<=0)
     {
      limit=rates_total-min_rates_total;
      oldtrend=0;
     }
   else
     {
      limit=rates_total-prev_calculated;
     }
   to_copy=limit+1;
   if(CopyBuffer(WPR_Handle,0,0,to_copy,WPR)<=0) return(RESET);
   ArraySetAsSeries(WPR,true);
   ArraySetAsSeries(open,true);
   ArraySetAsSeries(high,true);
   ArraySetAsSeries(low,true);
   ArraySetAsSeries(close,true);
   for(bar=limit; bar>=0 && !IsStopped(); bar--)
     {
      ExtOpenBuffer[bar]=open[bar];
      ExtHighBuffer[bar]=high[bar];
      ExtLowBuffer[bar]=low[bar];
      ExtCloseBuffer[bar]=close[bar];
      ExtColorsBuffer[bar]=2;
      trend=oldtrend;
      if(WPR[bar]<-100+K) trend=-1;
      if(WPR[bar]>-K) trend=+1;
      if(trend>0)
        {
         if(open[bar]<=close[bar]) ExtColorsBuffer[bar]=0;
         else ExtColorsBuffer[bar]=1;
        }
      if(trend<0)
        {
         if(open[bar]>=close[bar]) ExtColorsBuffer[bar]=4;
         else ExtColorsBuffer[bar]=3;
        }
      if(bar) oldtrend=trend;
     }
   return(rates_total);
  }