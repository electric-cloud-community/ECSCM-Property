####################################################################
#
# ECSCM::Property::Driver  Object to represent interactions with 
#        perforce.
####################################################################
package ECSCM::Property::Driver;
@ISA = (ECSCM::Base::Driver);
use ElectricCommander;
use Time::Local;
use HTTP::Date(qw {str2time time2str time2iso time2isoz});

if (!defined ECSCM::Base::Driver) {
    require ECSCM::Base::Driver;
}

if (!defined ECSCM::Property::Cfg) {
    require ECSCM::Property::Cfg;
}

####################################################################
# Object constructor for ECSCM::Property::Driver
#
# Inputs
#    cmdr          previously initialized ElectricCommander handle
#    name          name of this configuration
#                 
####################################################################
sub new {
    my $this = shift;
    my $class = ref($this) || $this;

    my $cmdr = shift;
    my $name = shift;

    my $cfg = new ECSCM::Property::Cfg($cmdr, "$name");
    my $sys = $cfg->getSCMPluginName();
    if ("$sys" ne "ECSCM-Property") { die "SCM config $name is not type ECSCM-Property"; }
    my ($self) = new ECSCM::Base::Driver($cmdr,$cfg);

    bless ($self, $class);
    return $self;
}

####################################################################
# isImplemented
####################################################################
sub isImplemented {
    my ($self, $method) = @_;
    
    if ($method eq 'getSCMTag') {
        return 1;
    } else {
        return 0;
    }
}

####################################################################
# getSCMTag
# 
# Get the latest changelist on this branch/client
#
# Args:
# Return: 
#    changeNumber - a string representing the last change sequence #
#    changeTime   - a time stamp representing the time of last change     
####################################################################
sub getSCMTag {
    my ($self, $opts) = @_;

    my $triggerPropertyName = $opts->{TriggerPropertyName};

    # Get the Property value
    #  The property must be fully qualified
    my ($success, $xPath, $errMsg) = $self->InvokeCommander(
                                        {SuppressLog=>1, IgnoreError=>1}, 
                                        "getProperty", $triggerPropertyName);  
    if (! $success) {
        my $messageOnly = $xPath->findvalue('//responses/error/message');
        my $printableErrMsg = $messageOnly;
        $printableErrMsg = $errMsg unless ($printableErrMsg);
        chomp($printableErrMsg);
        $printableErrMsg =~ s/\n/\n         : /g;
        $self->issueWarningMsg ("*** $printableErrMsg");
        return (undef,undef);
    }

    my $propertyValueElement = $xPath->findvalue('//value');
    my $propertyValue = $propertyValueElement->value();
    my $propertyModifyTimeElement = $xPath->findvalue('//modifyTime');
    my $propertyModifyTime = $propertyModifyTimeElement->value();
    my $modifyTimestamp = str2time($propertyModifyTime);

    return ($propertyValue, $modifyTimestamp);
}


1;
