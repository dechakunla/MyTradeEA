<chart>
id=133928178968435594
symbol=GBPUSDm
description=Great Britain Pound vs US Dollar
period_type=0
period_size=15
digits=5
tick_size=0.000000
position_time=1747924200
scale_fix=0
scale_fixed_min=1.339400
scale_fixed_max=1.359000
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=4
mode=0
fore=0
grid=0
volume=1
scroll=1
shift=1
shift_size=19.444444
fixed_pos=0.000000
ticker=1
ohlc=0
one_click=1
one_click_btn=1
bidline=1
askline=1
lastline=0
days=1
descriptions=0
tradelines=1
tradehistory=0
window_left=0
window_top=419
window_right=958
window_bottom=838
window_type=3
floating=0
floating_left=0
floating_top=0
floating_right=0
floating_bottom=0
floating_type=1
floating_toolbar=1
floating_tbstate=
background_color=0
foreground_color=16777215
barup_color=16776960
bardown_color=255
bullcandle_color=0
bearcandle_color=16777215
chartline_color=6908265
volumes_color=3329330
grid_color=10061943
bidline_color=10061943
askline_color=255
lastline_color=49152
stops_color=255
windows_total=1

<expert>
name=EA1
path=Experts\EA1.ex5
expertmode=5
<inputs>
isShowSummaryInfo=false
MAXORDER=10
lotSize=0.01
isTradeBuy=false
isTradeSell=false
IntervalSeconds=300
</inputs>
</expert>

<window>
height=100.000000
objects=22

<indicator>
name=Main
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\slopedirectionline.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=SDL(15)
draw=10
style=0
width=2
arrow=251
color=16711680,255
</graph>
<inputs>
InpMAPeriod=15
InpMAMethod=3
InpAppliedPrice=1
InpShift=0
InpAlert=true
InpMail=true
InpSound=true
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\trend_arrows.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=trend_arrows Up
draw=3
style=0
width=2
arrow=159
color=16711680
</graph>

<graph>
name=trend_arrows Down
draw=3
style=0
width=2
arrow=159
color=255
</graph>

<graph>
name=Buy trend_arrows signal
draw=3
style=0
width=2
arrow=108
color=16748574
</graph>

<graph>
name=Sell trend_arrows signal
draw=3
style=0
width=2
arrow=108
color=36095
</graph>
<inputs>
iPeriod=60
iFullPeriods=1
Shift=0
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Perfect trend line (ptl).ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=PTL trend candles
draw=17
style=0
width=1
arrow=251
color=16748574,3937500
</graph>

<graph>
name=PTL slow line
draw=1
style=2
width=1
arrow=251
color=-1
</graph>

<graph>
name=PTL fast line
draw=1
style=2
width=1
arrow=251
color=-1
</graph>

<graph>
name=PTL trend start
draw=12
style=0
width=2
arrow=159
color=16748574,3937500
</graph>
<inputs>
inpFastLength=3
inpSlowLength=7
</inputs>
</indicator>

<indicator>
name=Parabolic SAR
path=
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=3
style=0
width=1
arrow=159
color=65280
</graph>
step=0.010000
max=0.001000
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Free Indicators\NRTR Channel.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=Long Resistance
draw=3
style=0
width=1
arrow=159
color=16760576
</graph>

<graph>
name=Long Support
draw=3
style=0
width=1
arrow=251
color=16760576
</graph>

<graph>
name=Short Support
draw=3
style=0
width=1
arrow=251
color=8036607
</graph>

<graph>
name=Short Resistance
draw=3
style=0
width=1
arrow=159
color=8036607
</graph>
<inputs>
InpATRPeriod=40
InpkATR=2.0
InpShowLabel=true
</inputs>
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=3297.231890
scale_fix_min=0
scale_fix_min_val=3279.753836
scale_fix_max=0
scale_fix_max_val=3314.709944
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=2
arrow=251
color=16777215
</graph>
period=60
method=1
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Free Indicators\Donchian Channel.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=Upper Donchian
draw=1
style=0
width=4
shift=1
color=16711680
</graph>

<graph>
name=Middle Donchian
draw=1
style=0
width=2
shift=1
color=8421504
</graph>

<graph>
name=Lower Donchian
draw=1
style=0
width=4
shift=1
color=255
</graph>
<inputs>
InpDonchianPeriod=200
InpShowLabel=true
</inputs>
</indicator>
<object>
type=30
name=5406_NRTR_Res
hidden=1
color=8036607
width=2
selectable=0
date1=1747965600
value1=3306.239855
</object>

<object>
type=30
name=5406_NRTR_Sup
hidden=1
color=8036607
width=2
selectable=0
date1=1747965600
value1=3287.816000
</object>

<object>
type=30
name=8500_NRTR_Res
hidden=1
color=8036607
width=2
selectable=0
date1=1747967400
value1=3306.239855
</object>

<object>
type=30
name=8500_NRTR_Sup
hidden=1
color=8036607
width=2
selectable=0
date1=1747967400
value1=3287.816000
</object>

<object>
type=30
name=5203_NRTR_Res
hidden=1
color=8036607
selectable=0
date1=1747981980
value1=110564.196950
</object>

<object>
type=30
name=5203_NRTR_Sup
hidden=1
color=8036607
selectable=0
date1=1747981980
value1=110397.800000
</object>

<object>
type=30
name=4125_NRTR_Res
hidden=1
color=8036607
selectable=0
date1=1748033700
value1=5182.407230
</object>

<object>
type=30
name=4125_NRTR_Sup
hidden=1
color=8036607
selectable=0
date1=1748033700
value1=5166.275000
</object>

<object>
type=30
name=4515_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748218920
value1=1.138800
</object>

<object>
type=30
name=4515_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748218920
value1=1.138190
</object>

<object>
type=30
name=1968_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748239860
value1=1.141770
</object>

<object>
type=30
name=1968_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748239860
value1=1.140829
</object>

<object>
type=30
name=6359_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748349900
value1=1.356060
</object>

<object>
type=30
name=6359_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748349900
value1=1.354117
</object>

<object>
type=30
name=2968_NRTR_Res
hidden=1
color=8036607
selectable=0
date1=1748430900
value1=1.350872
</object>

<object>
type=30
name=2968_NRTR_Sup
hidden=1
color=8036607
selectable=0
date1=1748430900
value1=1.348990
</object>

<object>
type=30
name=1515_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748529000
value1=1.349660
</object>

<object>
type=30
name=1515_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748529000
value1=1.347684
</object>

<object>
type=1
name=sar_hline_0.010.001
hidden=1
color=65280
selectable=0
value1=1.343177
</object>

<object>
type=30
name=8890_DN_UP
hidden=1
color=16711680
width=2
selectable=0
date1=1748529000
value1=1.356450
</object>

<object>
type=30
name=8890_DN_MD
hidden=1
color=8421504
width=2
selectable=0
date1=1748529000
value1=1.348970
</object>

<object>
type=30
name=8890_DN_Dn
hidden=1
width=2
selectable=0
date1=1748529000
value1=1.341490
</object>

</window>
</chart>