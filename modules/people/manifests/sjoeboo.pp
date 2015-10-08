class people::sjoeboo {
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

  #include virtualbox
  #include vagrant
  class { 'vagrant':
    completion => true,
  }

  include atom
  include java
  include android::platform_tools

  #include docker

  #include authy
  include spotify

  include hipchat

  include wget
  #include zsh
  $packages = hiera('packages')
  package {$packages:
    ensure => installed,
  }
  include screen
  include tmux

  $files = hiera('files',{})
  $git_repos = hiera('git_repos',{})

  create_resources('file',$files)
  create_resources('repository',$git_repos)
  git::config::global{'core.editor':
    value => '/usr/bin/vim',
  }
}
