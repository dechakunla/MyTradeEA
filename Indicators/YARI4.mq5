#property copyright "Copyright © 2006, Nick A. Zhilin"
#property link      "rebus@dialup.etr.ru"
#property version   "1.00"
#property indicator_chart_window 
#property indicator_buffers 7
#property indicator_plots   5

#property indicator_type1   DRAW_FILLING
#property indicator_color1  clrPaleGreen
#property indicator_label1  "Upper Cloud"

#property indicator_type2   DRAW_LINE
#property indicator_color2  clrLimeGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  2
#property indicator_label2  "Upper FloatPivot"

#property indicator_type3   DRAW_LINE
#property indicator_color3  clrSlateBlue
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2
#property indicator_label3  "Middle FloatPivot"

#property indicator_type4   DRAW_LINE
#property indicator_color4  clrMagenta
#property indicator_style4  STYLE_SOLID
#property indicator_width4  2
#property indicator_label4  "Lower FloatPivot"

#property indicator_type5   DRAW_FILLING
#property indicator_color5  clrViolet
#property indicator_label5  "Lower Cloud"

input int IPeriod=100;
input int Shift=0;

double ExtUp1Buffer[];
double ExtUp2Buffer[];
double ExtABuffer[];
double ExtBBuffer[];
double ExtCBuffer[];
double ExtDn1Buffer[];
double ExtDn2Buffer[];

int  min_rates_total;

int iHighest(const double &array[], int count, int startPos)
{
   int index=startPos;
   if(startPos<0)
   {
      Print("Invalid value in function iHighest, startPos = ",startPos);
      return(0);
   }
   if(startPos-count<0)
      count=startPos;
   double max=array[startPos];
   for(int i=startPos; i>startPos-count; i--)
   {
      if(array[i]>max)
      {
         index=i;
         max=array[i];
      }
   }
   return(index);
}

int iLowest(const double &array[], int count, int startPos)
{
   int index=startPos;
   if(startPos<0)
   {
      Print("Invalid value in function iLowest, startPos = ",startPos);
      return(0);
   }
   if(startPos-count<0)
      count=startPos;
   double min=array[startPos];
   for(int i=startPos; i>startPos-count; i--)
   {
      if(array[i]<min)
      {
         index=i;
         min=array[i];
      }
   }
   return(index);
}

void OnInit()
{
   min_rates_total=int(MathMax(3,IPeriod));
   SetIndexBuffer(0,ExtUp1Buffer,INDICATOR_DATA);
   SetIndexBuffer(1,ExtUp2Buffer,INDICATOR_DATA);
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,min_rates_total);
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetInteger(0,PLOT_SHIFT,Shift);

   SetIndexBuffer(2,ExtABuffer,INDICATOR_DATA);
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,min_rates_total);
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetInteger(1,PLOT_SHIFT,Shift);

   SetIndexBuffer(3,ExtBBuffer,INDICATOR_DATA);
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,min_rates_total);
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetInteger(2,PLOT_SHIFT,Shift);

   SetIndexBuffer(4,ExtCBuffer,INDICATOR_DATA);
   PlotIndexSetInteger(3,PLOT_DRAW_BEGIN,min_rates_total);
   PlotIndexSetDouble(3,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetInteger(3,PLOT_SHIFT,Shift);

   SetIndexBuffer(5,ExtDn1Buffer,INDICATOR_DATA);
   SetIndexBuffer(6,ExtDn2Buffer,INDICATOR_DATA);
   PlotIndexSetInteger(4,PLOT_DRAW_BEGIN,min_rates_total);
   PlotIndexSetDouble(4,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetInteger(4,PLOT_SHIFT,Shift);

   string shortname;
   StringConcatenate(shortname,"FloatPivot( IPeriod = ",IPeriod,")");
   IndicatorSetString(INDICATOR_SHORTNAME,shortname);
   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
}

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[], const double &open[], const double &high[], const double &low[], const double &close[], const long &tick_volume[], const long &volume[], const int &spread[])
{
   if(rates_total<min_rates_total) return(0);
   int first,bar;
   if(prev_calculated==0)
   {
      first=min_rates_total-1;
   }
   else
   {
      first=prev_calculated-1;
   }
   for(bar=first; bar<rates_total && !IsStopped(); bar++)
   {
      double max=high[iHighest(high,IPeriod,bar)];
      double min=low[iLowest(low,IPeriod,bar)];
      double pivot=(close[bar-1]+close[bar-2]+close[bar-3])/3;
      double res=(max+min+pivot)/3;
      ExtABuffer[bar]=ExtUp1Buffer[bar]=((2*res-min)+res)/2;
      ExtCBuffer[bar]=ExtDn2Buffer[bar]=(res+(2*res-max))/2;      
      ExtBBuffer[bar]=ExtUp2Buffer[bar]=ExtDn1Buffer[bar]=res;
   }
   return(rates_total);
}