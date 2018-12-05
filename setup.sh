# basic EasyBuild setup file -- adjust as needed

# location of production fasrcsw
export FASRCSW_PROD=/n/sw/eb
export FASRCSW_OS=centos7

# author and build host
export FASRCSW_AUTHOR="$(getent passwd $USER | cut -d: -f5), Harvard FAS Research Computing <rchelp@fas.harvard.edu>"
export FASRCSW_BUILD_HOST=builds02
test "$(hostname -s)" != "$FASRCSW_BUILD_HOST" && echo -e "\n *** WARNING *** The current host is not the default build host ($FASRCSW_BUILD_HOST) \n" >&2
if [ -z "$BASH_SOURCE" ]; then
    echo -e "\n *** ERROR *** Your bash shell is too old: no BASH_SOURCE found in the environment \n" >&2
    exit 1
else
    echo -e "\n Setting $(dirname "$(readlink -e "$BASH_SOURCE")") as FASRCSW_DEV \n"
fi
export FASRCSW_DEV="$(dirname "$(readlink -e "$BASH_SOURCE")")"

# EasyBuild needs a recent lmod version available in $PATH ( Lmod version >= 5.6.3 )
export LMOD_CMD="$FASRCSW_PROD/lmod/lmod/libexec/lmod"
export PATH="$FASRCSW_PROD/lmod/lmod/libexec:$PATH"

# build directory
if [ ! -d /scratch/$USER/easybuild ]; then
    mkdir -p /scratch/$USER/easybuild
fi

if [ ! -h ebdev/BUILD ]; then
    ln -s /scratch/$USER/easybuild ebdev/BUILD
fi

# set EasyBuild environment variables
export EASYBUILD_MODULES_TOOL=Lmod
export EASYBUILD_REPOSITORYPATH=$FASRCSW_DEV/ebdev/EBREPO
export EASYBUILD_REPOSITORY=FileRepository
export EASYBUILD_BUILDPATH=$FASRCSW_DEV/ebdev/BUILD
export EASYBUILD_UMASK=002
export EASYBUILD_SET_GID_BIT=1
export EASYBUILD_IGNORE_OSDEPS=0
export EASYBUILD_RECURSIVE_MODULE_UNLOAD=1
export EASYBUILD_GROUP_WRITABLE_INSTALLDIR=1
export EASYBUILD_HIDE_DEPS=Bison,Doxygen,JasPer,NASM,SQLite,Szip,Tcl,bzip2,cURL,flex,freetype,libjpeg-turbo,libpng,libreadline,libtool,libxml2,ncurses,zlib,M4,Serf,APR,APR-util,expat,SCons,binutils,Coreutils,GLib,Qt,SCOTCH,Tk,hwloc,libffi,libunwind,make,numactl,pkg-config,gettext,Autotools,Automake,Autoconf,GCCcore,OPARI2,OTF2,UDUNITS,ZeroMQ,OpenPGM,util-linux,libsodium,libQGLViewer,Eigen,GTS,GL2PS,PyGTS,PyQt,IPython,Python-Xlib,LOKI,SIP,NASM,PIL,libjpeg-turbo
export EASYBUILD_MODULE_NAMING_SCHEME=HierarchicalMNS
export EASYBUILD_INSTALLPATH_SOFTWARE=$FASRCSW_PROD/apps/$FASRCSW_OS
export EASYBUILD_INSTALLPATH_MODULES=$FASRCSW_PROD/modulefiles/$FASRCSW_OS
export EASYBUILD_SUFFIX_MODULES_PATH=""
export EASYBUILD_SOURCEPATH=$FASRCSW_DEV/ebdev/SOURCES

# set MODULEPATH and load EasyBuild module
module unuse /n/helmod/modulefiles/centos7/Core
export MODULEPATH=$FASRCSW_PROD/modulefiles/$FASRCSW_OS/Core:$MODULEPATH
echo "Loading EasyBuild..."
module load EasyBuild

# Print out EB version
eb --version

# set EASYBUILD_ROBOT_PATHS
export EB_RP=$EBROOTEASYBUILD/lib/python2.7/site-packages/easybuild_easyconfigs-$EBVERSIONEASYBUILD-py2.7.egg/easybuild/easyconfigs
export EASYBUILD_ROBOT_PATHS=$FASRCSW_DEV/ebdev/SPECS:$EB_RP
