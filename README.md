# try_conda_rpm

The joy shown here:

https://xkcd.com/353/

often then becomes this:

https://xkcd.com/1987/

when you start dealing with python packaging.

Here is one attempt I made at handling one python packaging situation.

## Why?

I need to be able to write python programs that I give to people as
part of an RPM installation, where they will not have to do all the
stuff that conda end users do, like modifying their .bashrc and
changing their prompt (!!)

Suppose someone has written a very simple program called
`simple_map_trick.py` (included in this repo), but it uses the library
cartopy.

cartopy is cool, but it does bring in the whole kitchen sink
(including compiled code).  Getting cartopy going is usually rather
intrusive for a non-python-person trying to install it properly.

## How did i do it?

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

### Clone repo and make source tarball and RPM.

Clone the repo with:

```
git clone https://github.com/markgalassi/try_conda_rpm.git
cd try_conda_rpm
```


You can make the source RPM on any machine (even debian) with:

```
./make-tarball.sh
rpmbuild -ts try_conda_rpm-VERSION.tar.gz
```

This will put the source RPM at a place like
`$HOME/rpmbuild/SRPMS/try_conda_rpm-0.1.0-1.src.rpm`

### Make the binary RPM

Then you can build it into an RPM on any RPM based system -- well, at
this time (2021-10-28) you need to be root to build the RPM, but
that's OK for a container setup.

So as an example, to make the binary RPM in a minimal CentOS7 docker
container, try this:

```
docker run -it -v $HOME/rpmbuild:/rpmbuild centos:7
# NOTE: at this point you might need to paste some environment
# variables settings into your docker container, for exmaple if
# you use a nework proxy you will want to paste all those environment
# variables before you start the yum install commands
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

## Saving that RPM off of the container

Remember that once you are done with the container, that binary RPM
file you created will vaporize, so you can save it off.  If you are
using a container, and if you used the path I gave, you can just save
it into the rpmbuild directory which you mapped with something like:

```
cp /root/rpmbuild/RPMS/x86_64/try_conda_rpm-0.1.0-1.x86_64.rpm /rpmbuild/RPMS/x86_64/
```
