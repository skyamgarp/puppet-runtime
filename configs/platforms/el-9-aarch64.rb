platform 'el-9-aarch64' do |plat|
  plat.inherit_from_default

  packages = %w(
    perl
    perl-Getopt-Long
    java-1.8.0-openjdk-devel
    patch 
    swig 
    libxcrypt-compat 
    libselinux-devel 
    readline-devel 
    zlib-devel 
    systemtap-sdt-devel
  )
  plat.provision_with("dnf install -y --allowerasing  #{packages.join(' ')}")
end
