<chart>
id=133928069338743169
symbol=GBPUSDm
description=Great Britain Pound vs US Dollar
period_type=0
period_size=5
digits=5
tick_size=0.000000
position_time=0
scale_fix=0
scale_fixed_min=1.340800
scale_fixed_max=1.359600
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=2
mode=0
fore=0
grid=0
volume=0
scroll=1
shift=1
shift_size=19.848156
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
windows_total=1

<window>
height=113.000000
objects=61

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
InpATRPeriod=200
InpkATR=3.0
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
type=30
name=6046_DN_UP
hidden=1
color=16711680
selectable=0
date1=1747962900
value1=3306.532000
</object>

<object>
type=30
name=6046_DN_MD
hidden=1
color=8421504
selectable=0
date1=1747962900
value1=3300.173000
</object>

<object>
type=30
name=6046_DN_Dn
hidden=1
selectable=0
date1=1747962900
value1=3293.814000
</object>

<object>
type=30
name=7453_DN_UP
hidden=1
color=16711680
width=2
selectable=0
date1=1747962900
value1=1.130340
</object>

<object>
type=30
name=7453_DN_MD
hidden=1
color=8421504
width=2
selectable=0
date1=1747962900
value1=1.128985
</object>

<object>
type=30
name=7453_DN_Dn
hidden=1
width=2
selectable=0
date1=1747962900
value1=1.127630
</object>

<object>
type=102
name=VolumeLabel
hidden=1
descr=Prev Candle Volume: 4626
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

<object>
type=30
name=3625_NRTR_Res
hidden=1
color=8036607
width=2
selectable=0
date1=1747964700
value1=3306.239855
</object>

<object>
type=30
name=3625_NRTR_Sup
hidden=1
color=8036607
width=2
selectable=0
date1=1747964700
value1=3287.816000
</object>

<object>
type=30
name=1250_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748334600
value1=109677.450000
</object>

<object>
type=30
name=1250_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748334600
value1=109097.521050
</object>

<object>
type=30
name=3234_NRTR_Res
hidden=1
color=16760576
selectable=0
date1=1748334600
value1=1.353580
</object>

<object>
type=30
name=3234_NRTR_Sup
hidden=1
color=16760576
selectable=0
date1=1748334600
value1=1.352506
</object>

</window>
</chart>