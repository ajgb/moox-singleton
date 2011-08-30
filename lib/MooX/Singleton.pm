
package MooX::Singleton;
use strictures 1;

use Role::Tiny;

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
