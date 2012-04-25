
package MooX::Singleton;
# ABSTRACT: turn your Moo class into singleton

use strictures 1;
use Role::Tiny;

=head1 SYNOPSIS

    package MyApp;
    use Moo;
    with 'MooX::Singleton';

    package main;

    my $instance = MyApp->instance(@optional_init_args);
    my $same = MyApp->instance;


=head1 DESCRIPTION

Role::Tiny role that provides L<"instance"> method turning your object into singleton.

=method instance

    my $singleton = MyApp->instance(@args1);
    my $same = MyApp->instance;
    # @args2 are ignored
    my $above = MyApp->instance(@args2);

Creates a new object initialized with arguments provided and then returns it.

NOTE: Subsequent calls to C<instance> will return the singleton instance ignoring
any arguments. This is different from L<MooseX::Singleton> which does not allow any
arguments.

=cut

sub instance {
    my $class = shift;

    no strict 'refs';
    my $instance = \${"$class\::_instance"};
    return defined $$instance ? $$instance
        : ( $$instance = $class->new(@_) );
}

sub _has_instance {
    my $class = ref $_[0] || $_[0];

    no strict 'refs';
    return ${"$class\::_instance"};
}

sub _clear_instance {
    my $class = ref $_[0] || $_[0];

    no strict 'refs';
    undef ${"$class\::_instance"};

    return $class;
}

1;
