#!/usr/bin/perl

package File::SafeDO;
use strict;
#use diagnostics;

use vars qw(
	$VERSION @ISA @EXPORT_OK
);
require Exporter;
@ISA = qw(Exporter);

$VERSION = do { my @r = (q$Revision: 0.03 $ =~ /\d+/g); sprintf "%d."."%02d" x $#r, @r };

@EXPORT_OK = qw(
        DO
);

use Config;

=head1 NAME

File::SafeDO -- safer do file for perl

=head1 SYNOPSIS

  use File::SafeDO qw(
        DO
  );

  $rv = DO($file)

=head1 DESCRIPTION

=over 4

=item * $rv = DO($file);

This is a fancy 'do file'. It first checks that the file exists and is
readable, then does a 'do file' to pull the variables and subroutines into
the current name space. The 'do' is executed with full perl warnings so that 
syntax and construct errors are reported to STDERR.

  input:	file/path/name
  returns:	last value in file
	    or	undef on error
	    prints warning

=back

=cut

sub DO($) {
  my $file = shift;
  return undef unless
	$file &&
	-e $file &&
	-f $file &&
	-r $file;
  $_ = $Config{perlpath};		# bring perl into scope
  return undef if eval q|system($_, '-w', $file)|;
  do $file;
}

=head1 DEPENDENCIES

	none

=head1 EXPORT_OK

	DO

=head1 AUTHOR

Michael Robinton, michael@bizsystems.com

=head1 COPYRIGHT

Copyright 2003 - 2004, Michael Robinton & BizSystems
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or 
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

=cut

1;
