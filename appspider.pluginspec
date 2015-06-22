Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = "appspider"
  plugin.display_name = "Appspider Plugin"
  plugin.version = '0.0.1'
  plugin.description = 'This is a plugin for Jenksin to scan web application using AppSpider'

  # You should create a wiki-page for your plugin when you publish it, see
  # https://wiki.jenkins-ci.org/display/JENKINS/Hosting+Plugins#HostingPlugins-AddingaWikipage
  # This line makes sure it's listed in your POM.
  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Appspider+Plugin'

  # The first argument is your user name for jenkins-ci.org.
  plugin.developed_by "nbugash", "Nonico Bugash <Nonico_Bugash@rapid7.com>"

  # This specifies where your code is hosted.
  # Alternatives include:
  #  :github => 'myuser/appspider-plugin' (without myuser it defaults to jenkinsci)
  #  :git => 'git://repo.or.cz/appspider-plugin.git'
  #  :svn => 'https://svn.jenkins-ci.org/trunk/hudson/plugins/appspider-plugin'
  plugin.uses_repository :github => "appspider-plugin"

  # This is a required dependency for every ruby plugin.
  plugin.depends_on 'ruby-runtime', '0.12'

  # This is a sample dependency for a Jenkins plugin, 'git'.
  #plugin.depends_on 'git', '1.1.11'
end
