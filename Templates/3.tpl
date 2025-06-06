<chart>
id=133927679009590989
symbol=GBPUSDm
description=Great Britain Pound vs US Dollar
period_type=0
period_size=5
digits=5
tick_size=0.000000
position_time=0
scale_fix=0
scale_fixed_min=1.339500
scale_fixed_max=1.359700
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=2
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
window_top=0
window_right=0
window_bottom=0
window_type=1
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

<window>
height=92.480991
objects=14

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
InpATRPeriod=20
InpkATR=4.0
InpShowLabel=true
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
step=0.002500
max=0.001000
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\ssl_channel_chart.ex5
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
name=Up Trend; Down Trend
draw=7
style=0
width=1
color=16760576,16711935
</graph>
<inputs>
period=13
NRTR=true
Shift=0
AlertCount=0
AlertBar=0
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
name=0156_NRTR_Res
hidden=1
color=8036607
selectable=0
date1=1748322600
value1=1.356012
</object>

<object>
type=30
name=0156_NRTR_Sup
hidden=1
color=8036607
selectable=0
date1=1748322600
value1=1.354390
</object>

</window>
</chart>