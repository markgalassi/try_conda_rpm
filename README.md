# try_conda_rpm

I prepared a set of shell scripts which install and run a program in a
conda environment, but keep the existence of conda "secret" from the
user.

You can make the source RPM on any machine (even debian) with:

```
./make-tarball.sh && rpmbuild -ts make-tarball.sh
```

This will put the source RPM at a place like `$HOME/rpmbuild/SRPMS/try_conda_rpm-0.1.0-1.src.rpm`

Then you can build it into an RPM on any RPM based system.  For
example, to do so in a minimal CentOS7 container try this:

```
docker run -it -v $HOME/rpmbuild:/rpmbuild centos:7
yum install -y epel-release
yum install -y yum-utils
cd /rpmbuild/SRPMS/
yum-builddep -y try_conda_rpm-0.1.0-1.src.rpm
rpmbuild --rebuild try_conda_rpm-0.1.0-1.src.rpm
rpm -e try_conda_rpm || true
yum install -y /root/rpmbuild/RPMS/x86_64/try_conda_rpm-0.1.0-1.x86_64.rpm
```

Then you can try it out with:

```
make_map_under_conda.sh
```

Then you can examine the file `$HOME/rpmbuild/SRPMS/dude.png` from the
host to see if it has a simple map of the world.

The idea is that the program `simple_map_trick.py` go executed by the
shell script `make_map_under_conda.sh` which took care of all the
conda junk.
