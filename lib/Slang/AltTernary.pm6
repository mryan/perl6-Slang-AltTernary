use v6.c;
unit class Slang::AltTernary:ver<0.2>;

enum AltBool is export (:Yes , :!No);

=begin pod

=head1 NAME

Slang::AltTernary - blah blah blah

=head1 SYNOPSIS

  use Slang::AltTernary;

=head1 DESCRIPTION

Slang::AltTernary is ...

=head1 AUTHOR

Martin Ryan <mryan50@fastmail.fm>

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Martin Ryan

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

sub EXPORT(|) {
use nqp;
my %conditional := nqp::hash('prec', 'j=', 'assoc', 'right', 'dba', 'conditional', 'fiddly', 1, 'thunky', '.tt');

    role AltTern::Grammar {

        token infix:sym<?⁈ No> {
            :my $*GOAL := 'No';
            $<sym>='?⁈'
            <.ws> 'Yes' <.ws>
            <EXPR('i=')>
            [  
            || 'No'
            || <?before '::' <.-[=]> >       { self.typed_panic: "X::Syntax::ConditionalOperator::SecondPartInvalid", second-part => "::" }
            || <?before ':' <.-[=\w]> >      { self.typed_panic: "X::Syntax::ConditionalOperator::SecondPartInvalid", second-part => ":"  }
            || <infixish>                    { self.typed_panic: "X::Syntax::ConditionalOperator::PrecedenceTooLoose", operator => ~$<infixish> }
            || <?{ ~$<EXPR> ~~ / 'No' / }>   { self.typed_panic: "X::Syntax::ConditionalOperator::SecondPartGobbled" }
            || <?before \N*? [\n\N*?]? 'No'> { self.typed_panic: "X::Syntax::Confused", reason => "Confused: Bogus code found before the 'No' of the conditional operator" }
            ||                               { self.typed_panic: "X::Syntax::Confused", reason => "Confused: Found ?⁈ without 'No' clause" }
            ]
            <O(|%conditional, :reducecheck<ternary>, :pasttype<if>)>
        }
    }

    $*LANG.define_slang(
      'MAIN',
      $*LANG.slang_grammar('MAIN').^mixin(AltTern::Grammar),
      $*LANG.slang_actions('MAIN'),
    );
    {}
}
