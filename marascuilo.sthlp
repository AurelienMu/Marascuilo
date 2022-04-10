{smcl}
{* *! version 10.0 09apr2022}{...}
{viewerdialog marascuilo "dialog marascuilo"}{...}
{viewerjumpto "Title" "marascuilo##title"}{...}
{viewerjumpto "Syntax" "marascuilo##syntax"}{...}
{viewerjumpto "Description" "marascuilo##description"}{...}
{viewerjumpto "Examples" "marascuilo##examples"}{...}
{viewerjumpto "References" "marascuilo##references"}{...}

{marker title}{...}
{title:Title}
{p2col:{bf:marascuilo}}marascuilo Procedure

{marker syntax}{...}
{title:Syntax}
{phang}
{cmd:marascuilo} {it:response_var} {it:factor_var}{cmd:} {ifin} 

{phang}
{it:response_var} : The binary variable accross witch groups comparisons will be performed.{p_end}
{phang}
{it:factor_var} : The categorical variable, containing groups that will be compared.

{marker description}{...}
{title:Description}

{pstd}
Compute marascuilo Procedure for multiple groups
percentages comparisons.

{pstd}
Shows the contingency table of response_var x factor_var
with columns percentage of response_var

{pstd}
Displays percentages and differences for all 2 groups 
combinations, and significance according to critical
range


{marker examples}{...}
{title:Example}
{hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse  auto2, clear}{p_end}

{pstd}marascuilo Procedure for 2x2 groups comparisons{p_end}
{phang2}{cmd:. marascuilo foreign rep78}

{marker references}{...}
{title:References}
{pstd} 
The marascuilo Procedure. [{browse "https://www.itl.nist.gov/div898/handbook/prc/section4/prc474.htm":https://www.itl.nist.gov/div898/handbook/prc/section4/prc474.htm}] 
{pstd} 
Marascuilo, L.A. (1966). Large-sample multiple comparisons.  Psychological Bulletin, 65, 280-290.

