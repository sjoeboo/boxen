class people::sjoeboo {
  #Dont want them
  service {"dev.nginx":
      ensure => "stopped",
  }
  service {"dev.dnsmasq":
      ensure => "stopped",
  }

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

  #pull from hiera
  $packages = hiera('packages')
  $files = hiera('files',{})
  $git_repos = hiera('git_repos',{})


  #create things from hiera
  package {$packages:
    ensure => installed,
  }
  create_resources('file',$files)
  create_resources('repository',$git_repos)

  git::config::global{'core.editor':
    value => '/usr/bin/vim',
  }
}
