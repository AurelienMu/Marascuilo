{smcl}
{* *! version 10.0 09apr2022}{...}
{viewerdialog marascuillo "dialog marascuillo"}{...}
{viewerjumpto "Title" "marascuillo##title"}{...}
{viewerjumpto "Syntax" "marascuillo##syntax"}{...}
{viewerjumpto "Description" "marascuillo##description"}{...}
{viewerjumpto "Examples" "marascuillo##examples"}{...}
{viewerjumpto "References" "marascuillo##references"}{...}

{marker title}{...}
{title:Title}
{p2col:{bf:marascuillo}}Marascuillo Procedure

{marker syntax}{...}
{title:Syntax}
{phang}
{cmd:marascuillo} {it:response_var} {it:factor_var}{cmd:} {ifin} 

{phang}
{it:response_var} : The binary variable accross witch groups comparisons will be performed.{p_end}
{phang}
{it:factor_var} : The categorical variable, containing groups that will be compared.

{marker description}{...}
{title:Description}

{pstd}
Compute Marascuillo Procedure for multiple groups
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

{pstd}Marascuillo Procedure for 2x2 groups comparisons{p_end}
{phang2}{cmd:. marascuillo foreign rep78}

{marker references}{...}
{title:References}
{pstd} 
The Marascuillo Procedure. [{browse "https://www.itl.nist.gov/div898/handbook/prc/section4/prc474.htm":https://www.itl.nist.gov/div898/handbook/prc/section4/prc474.htm}] 
{pstd} 
Marascuilo, L.A. (1966). Large-sample multiple comparisons.  Psychological Bulletin, 65, 280-290.

