use nqp;

sub EXPORT(|) {
  # my sub lk(Mu \h, \k) {
  #     nqp::atkey(nqp::findmethod(h, 'hash')(h), k)
  # }

    role AltTern::Grammar {
        # All of what follows is stolen from the Rakudo grammar

        token term:sym<No>     { 'No' <?before \s> }  # actual error produced inside infix:<?⁈ No>

        token infix:sym<?⁈ No> {
            # :my %conditional := nqp::hash('prec', 'j=', 'assoc', 'right', 'dba', 'conditional', 'fiddly', 1, 'thunky', '.tt');
            :my %conditional := %('prec', 'j=', 'assoc', 'right', 'dba', 'conditional', 'fiddly', 1, 'thunky', '.tt');
            :my $*GOAL := 'No';
            $<sym>='?⁈'
            <.ws> 'Yes' <.ws>
            <EXPR('i=')>
            [  
            || 'No'
            || { self.typed_panic: "X::Syntax::Confused", reason => "Confused: Found ?⁈ without 'No' clause" }
            ]
            <O(|%conditional, :reducecheck<ternary>, :pasttype<if>)>
        }
    }

    my Mu $MAIN-grammar := nqp::atkey(%*LANG, 'MAIN');
    my $grammar := $MAIN-grammar.^mixin(AltTern::Grammar);
    my Mu $MAIN-actions := nqp::atkey(%*LANG, 'MAIN-actions');
    my $actions := $MAIN-actions;

    $*LANG.define_slang('MAIN', $grammar , $actions);

    {}
}
