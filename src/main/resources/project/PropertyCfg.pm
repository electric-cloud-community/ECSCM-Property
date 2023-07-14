####################################################################
#
# ECSCM::Property::Cfg: Object definition of a perforce SCM configuration.
#
####################################################################
package ECSCM::Property::Cfg;
@ISA = (ECSCM::Base::Cfg);

if (!defined ECSCM::Base::Cfg) {
    require ECSCM::Base::Cfg;
}


####################################################################
# Object constructor for ECSCM::Property::Cfg
#
# Inputs
#   cmdr  = a previously initialized ElectricCommander handle
#   name  = a name for this configuration
####################################################################
sub new {
    my $class = shift;

    my $cmdr = shift;
    my $name = shift;

    my($self) = ECSCM::Base::Cfg->new($cmdr,"$name");
    bless ($self, $class);
    return $self;
}

### No global properites
1;
