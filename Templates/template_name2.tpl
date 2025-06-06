<chart>
id=133904904053209666
symbol=XAUUSDm
description=Gold vs US Dollar
period_type=0
period_size=1
digits=3
tick_size=0.000000
position_time=1747350900
scale_fix=0
scale_fixed_min=3281.780000
scale_fixed_max=3347.860000
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=1
mode=0
fore=0
grid=0
volume=0
scroll=1
shift=1
shift_size=20.036265
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
window_right=958
window_bottom=419
window_type=1
floating=0
floating_left=0
floating_top=0
floating_right=0
floating_bottom=0
floating_type=1
floating_toolbar=1
floating_tbstate=
background_color=6908265
foreground_color=16777215
barup_color=10156544
bardown_color=9639167
bullcandle_color=65407
bearcandle_color=9639167
chartline_color=65280
volumes_color=3329330
grid_color=10061943
bidline_color=10061943
askline_color=255
lastline_color=49152
stops_color=255
windows_total=2

<expert>
name=HighVMEa
path=Experts\HighVMEa.ex5
expertmode=5
<inputs>
Timeframe=0
LabelName=VolumeLabel
LabelX=20
LabelY=40
</inputs>
</expert>

<window>
height=113.000000
objects=49

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
expertmode=0
fixed_height=-1

<graph>
name=Up Trend; Down Trend
draw=7
style=0
width=1
arrow=251
color=16760576,16711935
</graph>
<inputs>
period=13
NRTR=false
Shift=0
AlertCount=0
AlertBar=0
</inputs>
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
expertmode=0
fixed_height=-1

<graph>
name=SDL(80)
draw=10
style=0
width=2
arrow=251
color=16711680,255
</graph>
<inputs>
InpMAPeriod=80
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
path=Indicators\supertrend.ex5
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
name=Filling
draw=7
style=0
width=1
arrow=251
color=12903679,10025880
</graph>

<graph>
name=SuperTrend
draw=10
style=0
width=1
arrow=251
color=32768,255
</graph>
<inputs>
Periode=10
Multiplier=3.0
Show_Filling=true
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\supertrend.ex5
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
name=Filling
draw=7
style=0
width=1
arrow=251
color=12903679,10025880
</graph>

<graph>
name=SuperTrend
draw=10
style=0
width=1
arrow=251
color=32768,255
</graph>
<inputs>
Periode=10
Multiplier=60.0
Show_Filling=true
</inputs>
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
expertmode=0
fixed_height=-1

<graph>
name=Upper Donchian
draw=1
style=0
width=1
arrow=251
shift=1
color=0
</graph>

<graph>
name=Middle Donchian
draw=1
style=0
width=1
arrow=251
shift=1
color=8421504
</graph>

<graph>
name=Lower Donchian
draw=1
style=0
width=1
arrow=251
shift=1
color=0
</graph>
<inputs>
InpDonchianPeriod=21
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
expertmode=0
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
iPeriod=3
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
color=16748574
</graph>

<graph>
name=PTL fast line
draw=1
style=2
width=1
arrow=251
color=3937500
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
arrow=251
color=16760576,16711935
</graph>
<inputs>
period=600
NRTR=false
Shift=0
AlertCount=0
AlertBar=0
</inputs>
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
arrow=251
color=16760576,16711935
</graph>
<inputs>
period=1200
NRTR=false
Shift=0
AlertCount=0
AlertBar=0
</inputs>
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
arrow=251
color=16760576,16711935
</graph>
<inputs>
period=6000
NRTR=false
Shift=0
AlertCount=0
AlertBar=0
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
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=5
color=16777215
</graph>
period=600
method=1
</indicator>
<object>
type=30
name=0093_PS_Upper
hidden=1
color=14772545
width=2
selectable=0
date1=1746017520
value1=3292.364000
</object>

<object>
type=30
name=0093_PS_Parabolic
hidden=1
color=16760576
width=2
selectable=0
date1=1746017520
value1=3298.156155
</object>

<object>
type=30
name=0093_PS_Lower
hidden=1
color=36095
width=2
selectable=0
date1=1746017520
value1=3283.660000
</object>

<object>
type=30
name=7625_PS_Upper
hidden=1
color=14772545
selectable=0
date1=1746095340
value1=95810.040000
</object>

<object>
type=30
name=7625_PS_Parabolic
hidden=1
color=16760576
selectable=0
date1=1746095340
value1=96191.800000
</object>

<object>
type=30
name=7625_PS_Lower
hidden=1
color=36095
selectable=0
date1=1746095340
value1=95486.390000
</object>

<object>
type=30
name=3718_DN_UP
hidden=1
color=16711680
width=2
selectable=0
date1=1746718200
value1=101529.440000
</object>

<object>
type=30
name=3718_DN_MD
hidden=1
color=8421504
width=2
selectable=0
date1=1746718200
value1=100085.140000
</object>

<object>
type=30
name=3718_DN_Dn
hidden=1
width=2
selectable=0
date1=1746718200
value1=98640.840000
</object>

<object>
type=30
name=3734_DN_UP
hidden=1
color=16711680
width=2
selectable=0
date1=1746718200
value1=101529.440000
</object>

<object>
type=30
name=3734_DN_MD
hidden=1
color=8421504
width=2
selectable=0
date1=1746718200
value1=97425.055000
</object>

<object>
type=30
name=3734_DN_Dn
hidden=1
width=2
selectable=0
date1=1746718200
value1=93320.670000
</object>

<object>
type=30
name=6578_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747752180
value1=3285.837000
</object>

<object>
type=30
name=6578_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747752180
value1=3265.335500
</object>

<object>
type=30
name=6578_DN_Dn
hidden=1
selectable=0
date1=1747752180
value1=3244.834000
</object>

<object>
type=30
name=6593_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747752180
value1=3285.837000
</object>

<object>
type=30
name=6593_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747752180
value1=3259.320500
</object>

<object>
type=30
name=6593_DN_Dn
hidden=1
selectable=0
date1=1747752180
value1=3232.804000
</object>

<object>
type=30
name=5421_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747758900
value1=1.337300
</object>

<object>
type=30
name=5421_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747758900
value1=1.336575
</object>

<object>
type=30
name=5421_DN_Dn
hidden=1
selectable=0
date1=1747758900
value1=1.335850
</object>

<object>
type=30
name=5437_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747758900
value1=1.337390
</object>

<object>
type=30
name=5437_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747758900
value1=1.335395
</object>

<object>
type=30
name=5437_DN_Dn
hidden=1
selectable=0
date1=1747758900
value1=1.333400
</object>

<object>
type=30
name=6453_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747784760
value1=107312.330000
</object>

<object>
type=30
name=6453_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747784760
value1=106601.105000
</object>

<object>
type=30
name=6453_DN_Dn
hidden=1
selectable=0
date1=1747784760
value1=105889.880000
</object>

<object>
type=30
name=6000_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747784760
value1=107053.360000
</object>

<object>
type=30
name=6000_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747784760
value1=106888.255000
</object>

<object>
type=30
name=6000_DN_Dn
hidden=1
selectable=0
date1=1747784760
value1=106723.150000
</object>

<object>
type=30
name=9015_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747869240
value1=3321.473000
</object>

<object>
type=30
name=9015_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747869240
value1=3319.123500
</object>

<object>
type=30
name=9015_DN_Dn
hidden=1
selectable=0
date1=1747869240
value1=3316.774000
</object>

<object>
type=30
name=9062_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747869240
value1=3324.897000
</object>

<object>
type=30
name=9062_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747869240
value1=3318.557000
</object>

<object>
type=30
name=9062_DN_Dn
hidden=1
selectable=0
date1=1747869240
value1=3312.217000
</object>

<object>
type=30
name=3625_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747895940
value1=1.134070
</object>

<object>
type=30
name=3625_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747895940
value1=1.133185
</object>

<object>
type=30
name=3625_DN_Dn
hidden=1
selectable=0
date1=1747895940
value1=1.132300
</object>

<object>
type=30
name=2921_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747905780
value1=1.130240
</object>

<object>
type=30
name=2921_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747905780
value1=1.129705
</object>

<object>
type=30
name=2921_DN_Dn
hidden=1
selectable=0
date1=1747905780
value1=1.129170
</object>

<object>
type=30
name=9609_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747911180
value1=1.129900
</object>

<object>
type=30
name=9609_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747911180
value1=1.129480
</object>

<object>
type=30
name=9609_DN_Dn
hidden=1
selectable=0
date1=1747911180
value1=1.129060
</object>

<object>
type=30
name=1421_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747912440
value1=3296.458000
</object>

<object>
type=30
name=1421_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747912440
value1=3289.717500
</object>

<object>
type=30
name=1421_DN_Dn
hidden=1
selectable=0
date1=1747912440
value1=3282.977000
</object>

<object>
type=102
name=VolumeLabel
hidden=1
descr=Prev Candle Volume: 289
Current Candle Volume: 1
color=16760576
selectable=0
angle=0
pos_x=20
pos_y=40
fontsz=12
fontnm=Arial
anchorpos=0
refpoint=0
</object>

</window>

<window>
height=50.000000
objects=0

<indicator>
name=Volumes
path=
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=1
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=1221.140000
expertmode=0
fixed_height=-1

<graph>
name=
draw=11
style=0
width=1
color=32768,255
</graph>
real_volumes=0
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=3319.956730
scale_fix_min=0
scale_fix_min_val=3307.930111
scale_fix_max=0
scale_fix_max_val=3331.983349
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=5
color=16777215
</graph>
period=600
method=1
</indicator>
</window>
</chart>