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
