module FactsAnalyzer

import Ranking;
import Utils;

import lang::java::\syntax::Java15;
import util::Math;
import List;

/*
  It would be nicer if we had a map[Expr,Rank]
  map[int, Rank] JavaLocRank = 
   ( 66  : VeryHigh
	,246 : High
	,665 : Moderate
	,1310: Low);
*/
/*
  Volume ranking is calculated so:
    Function point per language is calculated and you can see this from LOCRatio above.
    Total lines of code divided by 1000 gives total KLOC.
  
  In Java language, 
    0-66KLOC is ranked as VeryHigh,
    66-246KLOC is ranked as High,
    246-665KLOC is ranked as Moderate,
    655-1,310KLOC is ranked as Low,
    >1,310KLOC is ranked as VeryLow
*/
public Rank AnalyzeVolume(int LOC)
{
	num kloc = LOC/1000;
	
	return if(kloc<66)
	{
	 VeryHigh(kloc);
	}
	else if(kloc<246)
	{
	 High(kloc);
	}
	else if(kloc<665)
	{
	 Moderate(kloc);
	}
	else if(kloc<1310)
	{
	 Low(kloc);
	}
	else
	{
	 VeryLow(kloc);
	}
	
	/*list[int] limits = [jr | jr <- JavaLocRank];
	for( i<-limits)
	{
		if(kloc<i)
		{
			Rank rank = JavaLocRank[i];
			return rank(kloc);
		}
	}*/
}


//TODO: how to make data types like these?
//data RiskType = Risk(tuple[int lines, int percentage]);
//data RisksType = RisksType(tuple[Risk low, Risk moderate, Risk high, Risk veryhigh]);
public Rank AnalyzeComplexity(int totalLOC, list[tuple[loc method, int CC, int lines]] facts)
{
  /*
  	Calculation based on "A Practical Model for Measuring Maintainability",
  						 Ilja Heitlager, Tobias Kuipers, Joost Visser

    for all methods
      calculate it's risk evaluation based on:
		CC		Risk evaluation
		1-10	simple, without much risk
		11-20	more complex, moderate risk
		21-50	complex, high risk
		> 50	untestable, very high risk
		
	  for each risk evaluation calculate the number of lines
	  as percentage to LOC
  */
  int low = 0;
  int moderate = 0;
  int high = 0;
  int veryhigh = 0;
  for(f <- facts) {
  	if (f.CC <= 10) {
  	  low += f.lines;
  	} else if (f.CC <= 20) {
  	  moderate += f.lines;
  	} else if (f.CC <= 30) {
  	  high += f.lines;
  	} else {
  	  veryhigh += f.lines;
  	}
  }
  lowPerc = round((low / toReal(totalLOC)) * 100);
  moderatePerc = round((moderate / toReal(totalLOC)) * 100);
  highPerc = round((high / toReal(totalLOC)) * 100);
  // to avoid rounding errors we calculate veryhigh risk as the remainder of 100%
  veryhighPerc = 100 - highPerc - moderatePerc - lowPerc;
  
  debug("======\n" + 
        "totalLOC: <totalLOC>\n" + 
        "     low: #<low>\t<lowPerc>%\n" +
        "moderate: #<moderate>\t<moderatePerc>%\n" +
        "    high: #<high>\t<highPerc>%\n" +
        "veryhigh: #<veryhigh>\t<veryhighPerc>%\n" +
        "======");

  /*
	determine ranking based on:
			maximum relative LOC
	rank	moderate	high	very high
	++		25%			0%		0%
	+		30%			5%		0%
	o		40%			10%		0%
	-		50%			15%		5%
	--		-			-		-	  
  */
  result = VeryLow(0);
  if ((moderatePerc <= 25) && (highPerc <= 0) && (veryhighPerc <= 0)) {
    result = VeryHigh(0);
  } else if ((moderatePerc <= 30) && (highPerc <= 5) && (veryhighPerc <= 0)) {
    result = High(0);
  } else if ((moderatePerc <= 40) && (highPerc <= 10) && (veryhighPerc <= 0)) {
    result = Moderate(0);
  } else if ((moderatePerc <= 50) && (highPerc <= 15) && (veryhighPerc <= 5)) {
    result = Low(0);
  }

  return result;
}

/*
  Find the percentage of duplicated code to the whole project.
  Ranking is so:
    0-3% VeryHigh
    3-5% High
    5-10% Moderate
    10-20% Low
    20-100% Very Low
*/
public Rank AnalyzeDuplication(int amountOfDuplication)
{
}

//TODO: this function is very much the same as AnalyzeComplexity!!
public Rank AnalyzeUnitSize(list[int] facts)
{
  /*
  	In "A Practical Model for Measuring Maintainability" no thresholds are
  	given what is considerd to be a 'good' unit size.
  	It is stated to use scoring guidelines from Complexity per unit,
  	but with different (non specified) threshold values.
  	
  	To get some reasonable thresholds we use research data from
  	"Code Complete", 2003, Steven C. McConnell, chapter 7.4
  	
  	For risk evaluation categorization the following threshold values are used:   
		LOC		Risk evaluation
		1-10	simple, without much risk 
		11-100	more complex, moderate risk
		101-200	complex, high risk
		> 200	untestable, very high risk
		
	Then again calculate the number of lines as percentage to LOC.
  	
  	The ranking is based on the following thresholds (same as complexity):
				maximum relative LOC
		rank	moderate	high	very high
		++		25%			0%		0%
		+		30%			5%		0%
		o		40%			10%		0%
		-		50%			15%		5%
		--		-			-		-	  
  */

  //TODO: now the totalLOC is based on methods LOC, or should it be on project LOC? 
  totalLOC = sum(facts);

  int low = 0;
  int moderate = 0;
  int high = 0;
  int veryhigh = 0;
  for(i <- facts) {
  	if (i <= 10) {
  	  low += i;
  	} else if (i <= 100) {
  	  moderate += i;
  	} else if (i <= 200) {
  	  high += i;
  	} else {
  	  veryhigh += i;
  	}
  }
  lowPerc = round((low / toReal(totalLOC)) * 100);
  moderatePerc = round((moderate / toReal(totalLOC)) * 100);
  highPerc = round((high / toReal(totalLOC)) * 100);
  // to avoid rounding errors we calculate veryhigh risk as the remainder of 100%
  veryhighPerc = 100 - highPerc - moderatePerc - lowPerc;
  
  debug("======\n" + 
        "totalLOC: <totalLOC>\n" + 
        "     low: #<low>\t<lowPerc>%\n" +
        "moderate: #<moderate>\t<moderatePerc>%\n" +
        "    high: #<high>\t<highPerc>%\n" +
        "veryhigh: #<veryhigh>\t<veryhighPerc>%\n" +
        "======");

  result = VeryLow(0);
  if ((moderatePerc <= 25) && (highPerc <= 0) && (veryhighPerc <= 0)) {
    result = VeryHigh(0);
  } else if ((moderatePerc <= 30) && (highPerc <= 5) && (veryhighPerc <= 0)) {
    result = High(0);
  } else if ((moderatePerc <= 40) && (highPerc <= 10) && (veryhighPerc <= 0)) {
    result = Moderate(0);
  } else if ((moderatePerc <= 50) && (highPerc <= 15) && (veryhighPerc <= 5)) {
    result = Low(0);
  }

  return result;
}

public Rank AnalyzeUnitTesting()
{
}