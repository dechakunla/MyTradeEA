<chart>
id=133883816051842820
symbol=BTCUSDm
description=Bitcoin vs US Dollar
period_type=0
period_size=5
digits=2
tick_size=0.000000
position_time=1745932320
scale_fix=0
scale_fixed_min=99667.100000
scale_fixed_max=106419.400000
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=2
mode=1
fore=0
grid=0
volume=1
scroll=1
shift=1
shift_size=20.027624
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
window_right=1505
window_bottom=600
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
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=65280
volumes_color=3329330
grid_color=10061943
bidline_color=10061943
askline_color=255
lastline_color=49152
stops_color=255
windows_total=1

<expert>
name=HLineEA01
path=Experts\HLineEA01.ex5
expertmode=1
<inputs>
</inputs>
</expert>

<window>
height=100.000000
objects=5

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
path=Indicators\YARI4.ex5
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
name=Upper Cloud
draw=7
style=0
width=1
arrow=251
shift=-20
color=10025880
</graph>

<graph>
name=Upper FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=3329330
</graph>

<graph>
name=Middle FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=13458026
</graph>

<graph>
name=Lower FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=16711935
</graph>

<graph>
name=Lower Cloud
draw=7
style=0
width=1
arrow=251
shift=-20
color=15631086
</graph>
<inputs>
IPeriod=2000
Shift=-20
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\YARI4.ex5
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
name=Upper Cloud
draw=7
style=0
width=1
arrow=251
shift=-20
color=10025880
</graph>

<graph>
name=Upper FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=3329330
</graph>

<graph>
name=Middle FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=13458026
</graph>

<graph>
name=Lower FloatPivot
draw=1
style=0
width=2
arrow=251
shift=-20
color=16711935
</graph>

<graph>
name=Lower Cloud
draw=7
style=0
width=1
arrow=251
shift=-20
color=15631086
</graph>
<inputs>
IPeriod=100
Shift=-20
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\YARI5.ex5
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
name=BykovTrendOpen;BykovTrendHigh;BykovTrendLow;BykovTrendClose
draw=17
style=0
width=1
arrow=251
color=3329330,0,8421504,1993170,55295
</graph>
<inputs>
RISK=3
SSP=11
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
color=65535
</graph>
step=0.020000
max=0.010000
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
arrow=251
color=14772545
</graph>
period=72
method=1
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
arrow=251
shift=20
color=16777215
</graph>
period=600
method=1
</indicator>
<object>
type=1
name=M1 Horizontal Line 35486
color=65535
value1=3279.653306
</object>

<object>
type=101
name=SwingRateText
hidden=1
descr=Swing Rate: Bid 0.0 | Ask 0.0
color=16777215
selectable=0
angle=0
date1=0
value1=0.000000
fontsz=10
fontnm=Arial
anchorpos=0
</object>

<object>
type=1
name=PSAR_HLine
hidden=1
color=65535
selectable=0
value1=105879.135514
</object>

<object>
type=1
name=FloatPivot_HLine
hidden=1
color=16777215
selectable=0
value1=104358.225556
</object>

</window>
</chart>