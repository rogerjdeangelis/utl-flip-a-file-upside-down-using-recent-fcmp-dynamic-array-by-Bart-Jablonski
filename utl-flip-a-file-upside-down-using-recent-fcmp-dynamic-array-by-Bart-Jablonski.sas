Flip a file upside down using recent hash dynamic array by Bart Jablonski

This is probably not the best example of some usefull functions.

I have an inexpensive power workstation with 64gb of ram.

github
https://tinyurl.com/y4msdtgp
https://github.com/rogerjdeangelis/utl-flip-a-file-upside-down-using-recent-fcmp-dynamic-array-by-Bart-Jablonski

See SAS-L
https://tinyurl.com/y4rkotmb
https://listserv.uga.edu/cgi-bin/wa?A2=ind1905c&L=SAS-L&O=D&X=53739B6391DB39F0D5&Y=rogerjdeangelis%40gmail.com&P=21545
Bart Jablonski <yabwon@GMAIL.COM>

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

* you need to include Barts hash package;
* I put the package in my autocall library c:/oto;
* see HASPAC section at the end of this postor;

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


* include Barts HASHPAC macros;
%include "c:/oto/utl_hashpac.sas";

data _null_;
  file "d:/txt/have.txt";
  do ltr="E","D","C","B","A";
     i+2;
     r=10010-i;
     rec=put(r,z5.);
     txt=repeat(ltr,43);
     put rec txt;
     putlog rec txt;
  end;
run;quit;

"d:/txt/have.txt"

10008 EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
10006 DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
10004 CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
10002 BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
10000 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

10000 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
10002 BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
10004 CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
10006 DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
10008 EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


%include "c:/oto/utl_hashpac.sas";

%utlfkil(d:/txt/want.txt); * delete if exists;

data _null_;
  file "d:/txt/have.txt";
  do ltr="E","D","C","B","A";
     i+2;
     r=10010-i;
     rec=put(r,z5.);
     txt=repeat(ltr,43);
     put rec txt;
     putlog rec txt;
  end;
run;quit;



filename have "d:/txt/have.txt";
filename want "d:/txt/want.txt";

data _null_;

    length line $60;

    %dynArray(lines, type= $ 60)

    infile have dlm='0A0D'x end=eof;

    do until(EOF);
       input txt $50.;
       %appendBefore(lines, cats(txt, i**3))
    end;

    %getVal(line, lines, 1)
    %rangeOf(lines)

    file want;
    do i = lboundLines to hboundLines;
      %getVal(line, lines, i)
      put line $50.;
      putlog line= $50.;
    end;
stop;
run;quit;


*_
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
;

NOTE: The infile HAVE is:
      Filename=d:\txt\have.txt,
      RECFM=V,LRECL=384,File Size (bytes)=260,
      Last Modified=24May2019:12:32:49,
      Create Time=24May2019:12:32:06

NOTE: The file WANT is:
      Filename=d:\txt\want.txt,
      RECFM=V,LRECL=384,File Size (bytes)=0,
      Last Modified=24May2019:12:37:35,
      Create Time=24May2019:11:01:20

LINE=10000 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
LINE=10002 BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
LINE=10004 CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
LINE=10006 DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
LINE=10008 EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

NOTE: 5 records were read from the infile HAVE.
      The minimum record length was 50.
      The maximum record length was 50.

NOTE: 5 records were written to the file WANT.
      The minimum record length was 50.

*                               _
  _____  ____ _ _ __ ___  _ __ | | ___  ___
 / _ \ \/ / _` | '_ ` _ \| '_ \| |/ _ \/ __|
|  __/>  < (_| | | | | | | |_) | |  __/\__ \
 \___/_/\_\__,_|_| |_| |_| .__/|_|\___||___/
                         |_|
;
options mprint source;
data _null_1;

  /* declare empty numeric array ABC with index _I_ and data _ABCcell_ */
  %dynArray(ABC)


  do i = 1 to 5;
    /* add new data to the end of ABC, index is automatically incremented by 1 (i.e. max(_I_) + 1)*/
    %appendTo(ABC, i**3)
    /* add new data to the end of GHI, index is automatically incremented by 1 (i.e. max(_I_) + 1)*/
    %appendTo(GHI, cats("test", i**3))
  end;

  do i = 1 to 5;
    /* add new data to the begining of ABC, index is automatically decremented by 1 (i.e. min(_I_) - 1)*/
    %appendBefore(ABC, -(i**3))
    /* add new data to the begining of GHI, index is automatically decremented by 1 (i.e. min(_I_) - 1)*/
    %appendBefore(GHI, cats("test", -(i**3)))
  end;


  /* like: test = ABC[3]; */
  %getVal(test, ABC, 3);

  /* get current values of lbound and hbound of ARRAY, default names: lbound<ARRAYNAME> and hbound<ARRAYNAME> */
  %rangeOf(ABC)
  do i = lboundABC to hboundABC;
    %getVal(test, ABC, i);
    put '%getVal ' i= test=;
  end;

  test = -17;
  /* like: ABC[8] = test; */
  /* like: ABC[7] = -42; */
  %putVal(ABC, 8, test);
  %putVal(ABC, 7, -42);

  %putVal(ABC, 7, -555);

  /* one loop for 2 tables, first array sets up loop's index */
  %loopOver(ABC GHI);
    j = _ABCcell_;
    t = _GHIcell_;
    output;
  %loopEnd;

  /* loop in loop (can't use one array twice! ends with infinite loop) */
  %loopOver(ABC);
    %loopOver(GHI);
    j = _ABCcell_;
    t = _GHIcell_;
    put "**" j= t=;
    %loopEnd;
  %loopEnd;

run;

*_               _
| |__   __ _ ___| |__  _ __   __ _  ___
| '_ \ / _` / __| '_ \| '_ \ / _` |/ __|
| | | | (_| \__ \ | | | |_) | (_| | (__
|_| |_|\__,_|___/_| |_| .__/ \__,_|\___|
                      |_|
;

* save in autocall library;
filename ft15f001 "c:/oto/utl_hashpac.sas";
parmcards4;

/* Bart Jablonski <yabwon@GMAIL.COM> */

/* macros */
%macro dynArray(ARRAY, TYPE=8, HASHEXP=8);
  if _N_ = 1 then
  do;
    length _I_ _RC_ 8 _&ARRAY.CELL_ &type. ;
    declare hash &ARRAY.(ordered:"A", hashexp:&HASHEXP.);
    &ARRAY..defineKey("_I_");
    &ARRAY..defineData("_I_","_&ARRAY.CELL_");
    &ARRAY..defineDone();
    &ARRAY..clear();
    declare hiter IT_&ARRAY.("&ARRAY.");
    drop _&ARRAY.CELL_ _I_ _RC_;
  end;
%mend dynArray;

%macro appendTo(ARRAY, VARIABLE);
  call missing(_I_);
  _RC_ = IT_&ARRAY..last();
  _I_ + 1;
  _&ARRAY.CELL_ = &VARIABLE.;
  _RC_ = &ARRAY..replace();
%mend appendTo;

%macro appendBefore(ARRAY, VARIABLE);
  call missing(_I_);
  _RC_ = IT_&ARRAY..first();
  _I_ + (-1);
  _&ARRAY.CELL_ = &VARIABLE.;
  _RC_ = &ARRAY..replace();
%mend appendBefore;


%macro loopOver(ARRAYS);
  %local ARRAY i;
  %let ARRAY = %scan(&ARRAYS., 1);
  _RC_ = IT_&ARRAY..first();
  _RC_ = IT_&ARRAY..prev();
  do while(IT_&ARRAY..next()=0);

    %let i = 2;
    %let ARRAY = %scan(&ARRAYS., &i.);
    %do %while(&ARRAY. ne);

      call missing(_&ARRAY.CELL_);
      _RC_ = &ARRAY..find();

      %let i = %eval(&i.+1);
      %let ARRAY = %scan(&ARRAYS., &i.);
    %end;
/*end;*/
%mend loopOver;

%macro loopEnd;
end;
%mend loopEnd;


%macro getVal(VARIABLE, ARRAY, INDEX);
  call missing(_&ARRAY.CELL_);
  _I_ = &INDEX;
  _RC_ = &ARRAY..find();
  &VARIABLE. = _&ARRAY.CELL_;
%mend getVal;

%macro putVal(ARRAY, INDEX, VARIABLE);
  if not missing(&INDEX.) then
    do;
      _I_ = &INDEX;
      _&ARRAY.CELL_ = &VARIABLE. ;
      _RC_ = &ARRAY..replace();
    end;
%mend putVal;

%macro rangeOf(ARRAY, START=lbound&ARRAY., END=hbound&ARRAY.);
  _RC_ = IT_&ARRAY..first();
  &START. = _I_;
  _RC_ = IT_&ARRAY..last();
  &END. = _I_;
  drop &START. &END.;
%mend rangeOf;
;;;;
run;quit;

