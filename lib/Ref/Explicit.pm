package Ref::Explicit;

# ABSTRACT: Keywords to create arrayrefs and hashrefs

use strict;
use warnings;

use base 'Exporter';

our (@EXPORT, @EXPORT_OK);

@EXPORT = qw(arrayref hashref);
@EXPORT_OK = qw(arrayref hashref);

sub arrayref { \@_ }

sub hashref { +{@_} }

1;

=head1 SYNOPSIS

  use Ref::Explicit qw(arrayref hashref);

  my $arrayref = arrayref map { ... } @values;
  my @array_of_hashrefs = map { hashref $key => $value, ... } @values;

=head1 DESCRIPTION

This module exports keywords that provide an explicit syntax for creation of arrayrefs and hashrefs in contexts where the ordinary perl syntax leads to a punctuation overdose.

=func C<arrayref> (@VALUES)

Return an array reference containing the values passed as arguments. Useful if you have long C<map>-like expressions whose result you need as am array reference rather than as an ordinary list. Consider the following example:

  sub search {
    ...
    my @result = grep {
      ... # complex multiline
      ... # calculations
    } @values;

    return \@result;
  }

You need to introduce an extra variable (C<@result>) in order to return a reference. This is a very common scenario, e.g. in L<Moose> attribute builders. You could avoid the extra variable by using square brackets:

  return [ grep {
    ...
  } @values ];

But this makes the syntax ugly and the intent unclear. With C<arrayref> the above code becomes:

  return arrayref grep {
    ...
  } @values;

=func C<hashref> (@VALUES)

Return a hash reference containing the values passed as arguments. Useful within C<map>-like expressions that return a list of hashrefs. Consider the following example:

  my @names = ("Steven Spielberg", "George Lucas");
  my @persons = map { +{ name => $_, industry => 'Movies'  } } @names;

The C<+> (plus) sign tells the parser to evaluate the code in curly brackets as an anonymous hashref rather than as a block. With C<hashref> this can be written more elegantly as:

  my @persons = map { hashref name => $_, industry => 'Movies' } @names;

=head1 CAVEATS

These functions provide clarity, not speed. Use the core syntax if speed is of the essence.
