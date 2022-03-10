Summary: attempt at distributing conda bundle by RPM
Name: try_conda_rpm
Version: 0.1.0
Release: 1
License: GPLv3
Group: experiments
URL: http://www.galassi.org/mark/
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%global _python_bytecompile_extra 0
%define debug_package %{nil}
# Turn off the brp-python-bytecompile script
%global __os_install_post %(echo '%{__os_install_post}' | sed -e 's!/usr/lib[^[:space:]]*/brp-python-bytecompile[[:space:]].*$!!g')
%undefine _missing_build_ids_terminate_build
# turn off scanning many areas for "requires" and "provides"; based on
# info at
# https://docs.fedoraproject.org/en-US/packaging-guidelines/AutoProvidesAndRequiresFiltering/
%global __provides_exclude_from ^$RPM_BUILD_ROOT/opt/.*$
%global __requires_exclude_from ^$RPM_BUILD_ROOT/opt/.*$
%global __provides_exclude ^.*$
%global __requires_exclude ^.*$

BuildRequires: epel-release
BuildRequires: rpm-build
BuildRequires: yum-utils
BuildRequires: rsync
Requires: python3

%description
an attempt at putting full conda downloads in an rpm

%prep
%setup -q

%build
DESTDIR=`pwd`/ ./install_conda_stuff.sh

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/opt/%{name}
cp --archive conda_base.tar.gz ${RPM_BUILD_ROOT}/opt/%{name}/
cp --archive conda_deploy.tar.gz ${RPM_BUILD_ROOT}/opt/%{name}/
mkdir -p ${RPM_BUILD_ROOT}/usr/bin/
cp simple_map_trick_wrap ${RPM_BUILD_ROOT}/usr/bin/
cp try_conda_rpm_env_snippet.sh simple_map_trick.py ${RPM_BUILD_ROOT}/usr/bin/
cp try_conda_rpm_conda_snippet.sh simple_map_trick.py ${RPM_BUILD_ROOT}/usr/bin/
#mkdir -p ${RPM_BUILD_ROOT}/opt/%{name}
#rsync -avz --delete --exclude conda_base/pkgs /opt/%{name}/ $RPM_BUILD_ROOT/opt/%{name}
##/bin/rm -rf /opt/%{name}

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc README.md
/usr/bin/*
/opt/%{name}/*


%changelog
* Wed Oct 27 2021 Mark Galassi <mark@galassi.org> - 
- Initial build.

