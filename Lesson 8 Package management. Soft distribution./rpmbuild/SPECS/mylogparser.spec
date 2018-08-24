Name:           mylogparser
Version:        1.0
Release:        1%{?dist}
Summary:        me

License:        GPL
URL:            https://yum.samusev.info
Source0:        mylogparser.tar.gz
BuildRequires:  systemd

%description
Simple service that parses logs and works via systemd.

%prep
%setup -q

%install
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/etc/sysconfig
mkdir -p $RPM_BUILD_ROOT/%{_unitdir}
install myservice.sh $RPM_BUILD_ROOT/%{_bindir}
install myserviceconfig $RPM_BUILD_ROOT/etc/sysconfig
install myservice.service $RPM_BUILD_ROOT/%{_unitdir}
install myservice.timer $RPM_BUILD_ROOT/%{_unitdir}

%files
%defattr(-,root,root)
%{_bindir}/myservice.sh
/etc/sysconfig/myserviceconfig
%{_unitdir}/myservice.service
%{_unitdir}/myservice.timer

%changelog
* Fri Aug 24 2018 Alexander Samusev <my@fakemail.com> 1.0
- Initial build