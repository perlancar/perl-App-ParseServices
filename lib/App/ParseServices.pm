package App::ParseServices;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{parse_services} = {
    v => 1.1,
    summary => 'Parse /etc/services',
    args => {
        filename => {
            schema => 'filename*',
            cmdline_aliases => {f=>{}},
        },
    },
};
sub parse_services {
    my %args = @_;

    my %ps_args;
    if (defined(my $fn = $args{filename})) {
        my $content;
        local $/;
        if ($fn eq '-') {
            $content = <STDIN>;
        } else {
            open my $fh, "<", $fn or return [500, "Can't open $fn: $!"];
            $content = <$fh>;
        }
        $ps_args{content} = $content;
    }
    require Parse::Services;
    Parse::Services::parse_services(%ps_args);
}

1;
# ABSTRACT: Parse /etc/hosts (CLI)

=head1 SEE ALSO

L<Parse::Hosts>
