use v6.c;
use Test;
use Slang::AltTernary;

plan 2;

sub run_altTern($compare) {
    $compare < 100 ?⁈ 
        Yes "Good" 
        No  "Bad"  ;
}

is run_altTern(12) , "Good", '12 is less than 100' ;
is run_altTern(112), "Bad", '112 is more than 100' ;
