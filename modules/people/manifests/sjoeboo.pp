class people::sjoeboo {

  #Iterm2
  include iterm2::stable
  include iterm2::colors::solarized_light
  include iterm2::colors::solarized_dark

  class { 'vagrant':
    completion => true,
  }
  include atom
  include java
  include android::platform_tools
  include spotify
  include hipchat
  include wget
  include screen
  include tmux
  #include authy
  include chrome
  include docker_toolbox

  #GPG Things
  class { 'gpgtools':
    version => '2015.09'
  }
  npm_module  {'keybase-installer':
    ensure       => present,
    module       => 'keybase-installer',
    node_version => '0.10'
  }
  exec {'keybase-installer':
    command => 'keybase-installer',
    creates => "/Users/${::boxen_user}/.keybase-installer",
    require => Npm_module['keybase-installer'],
  }

  #pull from hiera
  $packages = hiera('packages',[])
  $files = hiera('files',{})
  $git_repos = hiera('git_repos',{})
  $atom_packages = hiera('atom_packages',[])

  atom::package {  $atom_packages: }

  git::config::global{'core.editor':
    value => '/usr/bin/vim',
  }
}
