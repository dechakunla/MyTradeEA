#property copyright "xAI"
#property link      "https://x.ai"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 50
#property indicator_plots   50

//--- Input parameters
input ENUM_MA_METHOD MA_Type = MODE_EMA; // MA Type
input ENUM_APPLIED_PRICE MA_Price = PRICE_CLOSE; // MA Price

//--- Indicator buffers
double MA_Buffer0[], MA_Buffer1[], MA_Buffer2[], MA_Buffer3[], MA_Buffer4[],
       MA_Buffer5[], MA_Buffer6[], MA_Buffer7[], MA_Buffer8[], MA_Buffer9[],
       MA_Buffer10[], MA_Buffer11[], MA_Buffer12[], MA_Buffer13[], MA_Buffer14[],
       MA_Buffer15[], MA_Buffer16[], MA_Buffer17[], MA_Buffer18[], MA_Buffer19[],
       MA_Buffer20[], MA_Buffer21[], MA_Buffer22[], MA_Buffer23[], MA_Buffer24[],
       MA_Buffer25[], MA_Buffer26[], MA_Buffer27[], MA_Buffer28[], MA_Buffer29[],
       MA_Buffer30[], MA_Buffer31[], MA_Buffer32[], MA_Buffer33[], MA_Buffer34[],
       MA_Buffer35[], MA_Buffer36[], MA_Buffer37[], MA_Buffer38[], MA_Buffer39[],
       MA_Buffer40[], MA_Buffer41[], MA_Buffer42[], MA_Buffer43[], MA_Buffer44[],
       MA_Buffer45[], MA_Buffer46[], MA_Buffer47[], MA_Buffer48[], MA_Buffer49[];

//--- MA handles
int MA_Handles[50];

//--- Color array for rainbow effect
color RainbowColors[50] = {
   clrRed, clrOrangeRed, clrDarkOrange, clrOrange, clrGoldenrod,
   clrGold, clrYellow, clrLightYellow, clrLemonChiffon, clrPaleGreen,
   clrLimeGreen, clrLime, clrGreen, clrDarkGreen, clrSeaGreen,
   clrMediumSeaGreen, clrSpringGreen, clrAquamarine, clrAqua, clrCyan,
   clrLightCyan, clrPaleTurquoise, clrTurquoise, clrMediumTurquoise, clrDarkTurquoise,
   clrCadetBlue, clrSteelBlue, clrLightBlue, clrSkyBlue, clrDeepSkyBlue,
   clrDodgerBlue, clrBlue, clrMediumBlue, clrDarkBlue, clrNavy,
   clrMidnightBlue, clrIndigo, clrDarkViolet, clrPurple, clrMagenta,
   clrDarkMagenta, clrOrchid, clrMediumOrchid, clrPlum, clrThistle,
   clrLavender, clrMistyRose, clrPink, clrLightPink, clrHotPink
};

//--- Initialization
int OnInit()
{
   // Set up indicator plots and buffers
   SetIndexBuffer(0, MA_Buffer0, INDICATOR_DATA);
   SetIndexBuffer(1, MA_Buffer1, INDICATOR_DATA);
   SetIndexBuffer(2, MA_Buffer2, INDICATOR_DATA);
   SetIndexBuffer(3, MA_Buffer3, INDICATOR_DATA);
   SetIndexBuffer(4, MA_Buffer4, INDICATOR_DATA);
   SetIndexBuffer(5, MA_Buffer5, INDICATOR_DATA);
   SetIndexBuffer(6, MA_Buffer6, INDICATOR_DATA);
   SetIndexBuffer(7, MA_Buffer7, INDICATOR_DATA);
   SetIndexBuffer(8, MA_Buffer8, INDICATOR_DATA);
   SetIndexBuffer(9, MA_Buffer9, INDICATOR_DATA);
   SetIndexBuffer(10, MA_Buffer10, INDICATOR_DATA);
   SetIndexBuffer(11, MA_Buffer11, INDICATOR_DATA);
   SetIndexBuffer(12, MA_Buffer12, INDICATOR_DATA);
   SetIndexBuffer(13, MA_Buffer13, INDICATOR_DATA);
   SetIndexBuffer(14, MA_Buffer14, INDICATOR_DATA);
   SetIndexBuffer(15, MA_Buffer15, INDICATOR_DATA);
   SetIndexBuffer(16, MA_Buffer16, INDICATOR_DATA);
   SetIndexBuffer(17, MA_Buffer17, INDICATOR_DATA);
   SetIndexBuffer(18, MA_Buffer18, INDICATOR_DATA);
   SetIndexBuffer(19, MA_Buffer19, INDICATOR_DATA);
   SetIndexBuffer(20, MA_Buffer20, INDICATOR_DATA);
   SetIndexBuffer(21, MA_Buffer21, INDICATOR_DATA);
   SetIndexBuffer(22, MA_Buffer22, INDICATOR_DATA);
   SetIndexBuffer(23, MA_Buffer23, INDICATOR_DATA);
   SetIndexBuffer(24, MA_Buffer24, INDICATOR_DATA);
   SetIndexBuffer(25, MA_Buffer25, INDICATOR_DATA);
   SetIndexBuffer(26, MA_Buffer26, INDICATOR_DATA);
   SetIndexBuffer(27, MA_Buffer27, INDICATOR_DATA);
   SetIndexBuffer(28, MA_Buffer28, INDICATOR_DATA);
   SetIndexBuffer(29, MA_Buffer29, INDICATOR_DATA);
   SetIndexBuffer(30, MA_Buffer30, INDICATOR_DATA);
   SetIndexBuffer(31, MA_Buffer31, INDICATOR_DATA);
   SetIndexBuffer(32, MA_Buffer32, INDICATOR_DATA);
   SetIndexBuffer(33, MA_Buffer33, INDICATOR_DATA);
   SetIndexBuffer(34, MA_Buffer34, INDICATOR_DATA);
   SetIndexBuffer(35, MA_Buffer35, INDICATOR_DATA);
   SetIndexBuffer(36, MA_Buffer36, INDICATOR_DATA);
   SetIndexBuffer(37, MA_Buffer37, INDICATOR_DATA);
   SetIndexBuffer(38, MA_Buffer38, INDICATOR_DATA);
   SetIndexBuffer(39, MA_Buffer39, INDICATOR_DATA);
   SetIndexBuffer(40, MA_Buffer40, INDICATOR_DATA);
   SetIndexBuffer(41, MA_Buffer41, INDICATOR_DATA);
   SetIndexBuffer(42, MA_Buffer42, INDICATOR_DATA);
   SetIndexBuffer(43, MA_Buffer43, INDICATOR_DATA);
   SetIndexBuffer(44, MA_Buffer44, INDICATOR_DATA);
   SetIndexBuffer(45, MA_Buffer45, INDICATOR_DATA);
   SetIndexBuffer(46, MA_Buffer46, INDICATOR_DATA);
   SetIndexBuffer(47, MA_Buffer47, INDICATOR_DATA);
   SetIndexBuffer(48, MA_Buffer48, INDICATOR_DATA);
   SetIndexBuffer(49, MA_Buffer49, INDICATOR_DATA);

   // Set plot properties and create MA handles
   for(int i = 0; i < 50; i++)
   {
      PlotIndexSetInteger(i, PLOT_LINE_COLOR, RainbowColors[i]);
      PlotIndexSetInteger(i, PLOT_LINE_STYLE, STYLE_SOLID);
      PlotIndexSetInteger(i, PLOT_LINE_WIDTH, 1);
      PlotIndexSetString(i, PLOT_LABEL, "MA(" + IntegerToString(2 + i * 2) + ")");
      MA_Handles[i] = iMA(NULL, 0, 2 + i * 2, 0, MA_Type, MA_Price);
      if(MA_Handles[i] == INVALID_HANDLE)
      {
         Print("Failed to create MA handle for period ", 2 + i * 2);
         return(INIT_FAILED);
      }
   }
   return(INIT_SUCCEEDED);
}

//--- Deinitialization
void OnDeinit(const int reason)
{
   for(int i = 0; i < 50; i++)
   {
      if(MA_Handles[i] != INVALID_HANDLE)
         IndicatorRelease(MA_Handles[i]);
   }
}

//--- Calculation
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
   // Ensure enough bars
   if(rates_total < 100) return(0);

   // Copy data to each buffer
   if(CopyBuffer(MA_Handles[0], 0, 0, rates_total, MA_Buffer0) <= 0) return(0);
   if(CopyBuffer(MA_Handles[1], 0, 0, rates_total, MA_Buffer1) <= 0) return(0);
   if(CopyBuffer(MA_Handles[2], 0, 0, rates_total, MA_Buffer2) <= 0) return(0);
   if(CopyBuffer(MA_Handles[3], 0, 0, rates_total, MA_Buffer3) <= 0) return(0);
   if(CopyBuffer(MA_Handles[4], 0, 0, rates_total, MA_Buffer4) <= 0) return(0);
   if(CopyBuffer(MA_Handles[5], 0, 0, rates_total, MA_Buffer5) <= 0) return(0);
   if(CopyBuffer(MA_Handles[6], 0, 0, rates_total, MA_Buffer6) <= 0) return(0);
   if(CopyBuffer(MA_Handles[7], 0, 0, rates_total, MA_Buffer7) <= 0) return(0);
   if(CopyBuffer(MA_Handles[8], 0, 0, rates_total, MA_Buffer8) <= 0) return(0);
   if(CopyBuffer(MA_Handles[9], 0, 0, rates_total, MA_Buffer9) <= 0) return(0);
   if(CopyBuffer(MA_Handles[10], 0, 0, rates_total, MA_Buffer10) <= 0) return(0);
   if(CopyBuffer(MA_Handles[11], 0, 0, rates_total, MA_Buffer11) <= 0) return(0);
   if(CopyBuffer(MA_Handles[12], 0, 0, rates_total, MA_Buffer12) <= 0) return(0);
   if(CopyBuffer(MA_Handles[13], 0, 0, rates_total, MA_Buffer13) <= 0) return(0);
   if(CopyBuffer(MA_Handles[14], 0, 0, rates_total, MA_Buffer14) <= 0) return(0);
   if(CopyBuffer(MA_Handles[15], 0, 0, rates_total, MA_Buffer15) <= 0) return(0);
   if(CopyBuffer(MA_Handles[16], 0, 0, rates_total, MA_Buffer16) <= 0) return(0);
   if(CopyBuffer(MA_Handles[17], 0, 0, rates_total, MA_Buffer17) <= 0) return(0);
   if(CopyBuffer(MA_Handles[18], 0, 0, rates_total, MA_Buffer18) <= 0) return(0);
   if(CopyBuffer(MA_Handles[19], 0, 0, rates_total, MA_Buffer19) <= 0) return(0);
   if(CopyBuffer(MA_Handles[20], 0, 0, rates_total, MA_Buffer20) <= 0) return(0);
   if(CopyBuffer(MA_Handles[21], 0, 0, rates_total, MA_Buffer21) <= 0) return(0);
   if(CopyBuffer(MA_Handles[22], 0, 0, rates_total, MA_Buffer22) <= 0) return(0);
   if(CopyBuffer(MA_Handles[23], 0, 0, rates_total, MA_Buffer23) <= 0) return(0);
   if(CopyBuffer(MA_Handles[24], 0, 0, rates_total, MA_Buffer24) <= 0) return(0);
   if(CopyBuffer(MA_Handles[25], 0, 0, rates_total, MA_Buffer25) <= 0) return(0);
   if(CopyBuffer(MA_Handles[26], 0, 0, rates_total, MA_Buffer26) <= 0) return(0);
   if(CopyBuffer(MA_Handles[27], 0, 0, rates_total, MA_Buffer27) <= 0) return(0);
   if(CopyBuffer(MA_Handles[28], 0, 0, rates_total, MA_Buffer28) <= 0) return(0);
   if(CopyBuffer(MA_Handles[29], 0, 0, rates_total, MA_Buffer29) <= 0) return(0);
   if(CopyBuffer(MA_Handles[30], 0, 0, rates_total, MA_Buffer30) <= 0) return(0);
   if(CopyBuffer(MA_Handles[31], 0, 0, rates_total, MA_Buffer31) <= 0) return(0);
   if(CopyBuffer(MA_Handles[32], 0, 0, rates_total, MA_Buffer32) <= 0) return(0);
   if(CopyBuffer(MA_Handles[33], 0, 0, rates_total, MA_Buffer33) <= 0) return(0);
   if(CopyBuffer(MA_Handles[34], 0, 0, rates_total, MA_Buffer34) <= 0) return(0);
   if(CopyBuffer(MA_Handles[35], 0, 0, rates_total, MA_Buffer35) <= 0) return(0);
   if(CopyBuffer(MA_Handles[36], 0, 0, rates_total, MA_Buffer36) <= 0) return(0);
   if(CopyBuffer(MA_Handles[37], 0, 0, rates_total, MA_Buffer37) <= 0) return(0);
   if(CopyBuffer(MA_Handles[38], 0, 0, rates_total, MA_Buffer38) <= 0) return(0);
   if(CopyBuffer(MA_Handles[39], 0, 0, rates_total, MA_Buffer39) <= 0) return(0);
   if(CopyBuffer(MA_Handles[40], 0, 0, rates_total, MA_Buffer40) <= 0) return(0);
   if(CopyBuffer(MA_Handles[41], 0, 0, rates_total, MA_Buffer41) <= 0) return(0);
   if(CopyBuffer(MA_Handles[42], 0, 0, rates_total, MA_Buffer42) <= 0) return(0);
   if(CopyBuffer(MA_Handles[43], 0, 0, rates_total, MA_Buffer43) <= 0) return(0);
   if(CopyBuffer(MA_Handles[44], 0, 0, rates_total, MA_Buffer44) <= 0) return(0);
   if(CopyBuffer(MA_Handles[45], 0, 0, rates_total, MA_Buffer45) <= 0) return(0);
   if(CopyBuffer(MA_Handles[46], 0, 0, rates_total, MA_Buffer46) <= 0) return(0);
   if(CopyBuffer(MA_Handles[47], 0, 0, rates_total, MA_Buffer47) <= 0) return(0);
   if(CopyBuffer(MA_Handles[48], 0, 0, rates_total, MA_Buffer48) <= 0) return(0);
   if(CopyBuffer(MA_Handles[49], 0, 0, rates_total, MA_Buffer49) <= 0) return(0);

   return(rates_total);
}