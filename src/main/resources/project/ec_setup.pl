my $projPrincipal = "project: $pluginName";
my $ecscmProj = '$[/plugins/ECSCM/project]';

if ($promoteAction eq 'promote') {
    # Register our SCM type with ECSCM
    $batch->setProperty("/plugins/ECSCM/project/scm_types/@PLUGIN_KEY@", "Property");
    
    # Create a configuration
    $batch->setProperty('/plugins/ECSCM/project/scm_cfgs/Property/scmPlugin',
                        '@PLUGIN_KEY@');
    $batch->modifyProperty("/plugins/ECSCM/project/scm_cfgs/Property", 
                           {description => "Property configuration"});

    # Give our project principal execute access to the ECSCM project
    my $xpath = $commander->getAclEntry("user", $projPrincipal,
                                        {projectName => $ecscmProj});
    if ($xpath->findvalue('//code') eq 'NoSuchAclEntry') {
        $batch->createAclEntry("user", $projPrincipal,
                               {projectName => $ecscmProj,
                                executePrivilege => "allow"});
    }
} elsif ($promoteAction eq 'demote') {
    # unregister with ECSCM
    $batch->deleteProperty("/plugins/ECSCM/project/scm_types/@PLUGIN_KEY@");

    # delete configuration
    $batch->deleteProperty("/plugins/ECSCM/project/scm_cfgs/Property");
    
    # remove permissions
    my $xpath = $commander->getAclEntry("user", $projPrincipal,
                                        {projectName => $ecscmProj});
    if ($xpath->findvalue('//principalName') eq $projPrincipal) {
        $batch->deleteAclEntry("user", $projPrincipal,
                               {projectName => $ecscmProj});
    }
}
