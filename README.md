# try_conda_rpm

## why?

I need to be able to write python programs that I give to people as
part of an RPM installation, where they will not have to do all the
stuff that conda end users do, like modifying their .bashrc and
changing their prompt (!!)

Suppose someone has written a very simple program called
`simple_map_trick.py` (included in this repo), but it uses the library
cartopy.

cartopy is cool, but it does bring in the whole kitchen sink
(including compiled code).  Getting cartopy going is usually rather
intrusive on a non-python-person to install it properly.

## how did i do it?

I prepared a set of shell scripts which install and run a program in a
conda environment, but keep the existence of conda's whole formalism
"secret" from the user by:

a. Including all the conda directories in an RPM.

b. Having a wrapper program which does all the conda environment
variable manipulation under the hood.

So the end user installs the RPM and then runs:

```
simple_map_trick_wrap
```

and the program "just runs" without any knowledge of conda or of that
mess that is python package delivery.


## How to set this up:

Clone the repo with:

```
git clone https://github.com/markgalassi/try_conda_rpm.git
```


You can make the source RPM on any machine (even debian) with:

```
./make-tarball.sh && rpmbuild -ts make-tarball.sh
```

This will put the source RPM at a place like
`$HOME/rpmbuild/SRPMS/try_conda_rpm-0.1.0-1.src.rpm`

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
simple_map_trick_wrap
```

Then you can examine the file `$HOME/rpmbuild/SRPMS/dude.png` from the
host to see if it has a simple map of the world.

The idea is that the program `simple_map_trick.py` got executed by the
shell script `simple_map_trick_wrap`.  This wrapper took care of all
the conda junk.
