Summary: attempt at distributing conda bundle by RPM
Name: try_conda_rpm
Version: 0.1.0
Release: 1
License: GPLv3
Group: experiments
URL: http://www.galassi.org/mark/
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
an attempt at putting full conda downloads in an rpm

%prep
%setup -q

%build
./install_conda_stuff.sh

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/usr/bin/
cp make_map_under_conda.sh simple_map_trick.py ${RPM_BUILD_ROOT}/usr/bin/

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc README.md
/usr/bin/*


%changelog
* Wed Oct 27 2021 Mark Galassi <mark@galassi.org> - 
- Initial build.

