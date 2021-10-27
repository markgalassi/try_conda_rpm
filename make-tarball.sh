#! /bin/sh

PACKAGE=try_conda_rpm
MAJOR=0
MINOR=1
PATCH=0
SUFFIX=
VERSION=${MAJOR}.${MINOR}.${PATCH}${SUFFIX}
SERIES=${MAJOR}.${MINOR}
DISTDIR=${PACKAGE}-${VERSION}
DIST_FILE_LIST="${PACKAGE}.spec make-tarball.sh README.md \
              install_conda_stuff.sh simple_map_trick_wrap \
              try_conda_rpm_conda_snippet.sh \
              try_conda_rpm_env_snippet.sh \
              simple_map_trick.py try_conda_rpm.spec"
/bin/rm -rf ${DISTDIR}
echo "PACKAGE" ${PACKAGE}
echo "VERSION" ${VERSION}
mkdir ${DISTDIR}
for fname in ${DIST_FILE_LIST}; \
    do \
	the_dirname=`dirname $fname`; \
	the_basename=`basename $fname`; \
	mkdir -p ${DISTDIR}/$the_dirname; \
	cp $fname ${DISTDIR}/$the_dirname/$the_basename; \
    done
tar --format=gnu -z -c -f ${DISTDIR}.tar.gz ${DISTDIR}
/bin/rm -rf ${DISTDIR}
echo "${DISTDIR}.tar.gz is ready for distribution"
