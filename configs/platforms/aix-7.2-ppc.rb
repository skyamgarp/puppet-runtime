platform "aix-7.2-ppc" do |plat|
  # os_version = 7.2
  plat.make "gmake"
  plat.mktemp "/opt/freeware/bin/mktemp -d -p /var/tmp"
  plat.patch "/opt/freeware/bin/patch"
  plat.rpmbuild "/usr/bin/rpm"
  plat.servicetype "aix"
  plat.tar "/opt/freeware/bin/tar"

  plat.provision_with %[
curl -O https://artifactory.delivery.puppetlabs.net/artifactory/generic__buildsources/openssl-1.0.2.1800.tar.Z;
uncompress openssl-1.0.2.1800.tar.Z;
tar xvf openssl-1.0.2.1800.tar;
cd openssl-1.0.2.1800 && /usr/sbin/installp -acgwXY -d $PWD openssl.base;
curl --output yum.sh https://artifactory.delivery.puppetlabs.net/artifactory/generic__buildsources/buildsources/aix-yum.sh && sh yum.sh]

packages = %w(
    autoconf
    cmake
    coreutils
    gawk
    gcc
    gcc-c++
    gdbm
    gmp
    libffi
    libyaml
    make
    perl
    pkg-config
    readline
    readline-devel
    sed
    tar
    zlib
    zlib-devel
  )
  plat.provision_with "yum install --assumeyes #{packages.join(' ')}"

  # No upstream rsync packages
  plat.provision_with "rpm -Uvh https://artifactory.delivery.puppetlabs.net/artifactory/rpm__remote_aix_linux_toolbox/RPMS/ppc/rsync/rsync-3.0.6-1.aix5.3.ppc.rpm"

  plat.install_build_dependencies_with "yum install --assumeyes "
  plat.vmpooler_template "aix-7.2-power"
end
