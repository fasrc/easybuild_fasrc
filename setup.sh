# EasyBuild setup file

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

# EasyBuild needs a recent lmod version to be available in the $PATH 
# ERROR: EasyBuild requires vLmod >= v5.6.3 (no rc), found v5.4.1
export LMOD_CMD="/n/sw/eb/lmod/lmod/libexec/lmod"
export PATH="/n/sw/eb/lmod/lmod/libexec:$PATH"

# set EasyBuild environment variables
export EASYBUILD_MODULES_TOOL=Lmod
export EASYBUILD_REPOSITORYPATH=$FASRCSW_DEV/ebfiles_repo
export EASYBUILD_REPOSITORY=FileRepository
export EASYBUILD_BUILDPATH=$FASRCSW_DEV/BUILD
export EASYBUILD_UMASK=002
export EASYBUILD_SET_GID_BIT=1
export EASYBUILD_IGNORE_OSDEPS=0
export EASYBUILD_RECURSIVE_MODULE_UNLOAD=1
export EASYBUILD_GROUP_WRITABLE_INSTALLDIR=1
export EASYBUILD_HIDE_DEPS=Bison,Doxygen,JasPer,NASM,SQLite,Szip,Tcl,bzip2,cURL,flex,freetype,libjpeg-turbo,libpng,libreadline,libtool,libxml2,ncurses,zlib,M4,Serf,APR,APR-util,expat,SCons,binutils,Coreutils,GLib,Qt,SCOTCH,Tk,hwloc,libffi,libunwind,make,numactl,pkg-config,gettext,Autotools,Automake,Autoconf,GCCcore,OPARI2,OTF2,UDUNITS,ZeroMQ,OpenPGM,util-linux,libsodium,libQGLViewer,Eigen,GTS,GL2PS,PyGTS,PyQt,IPython,Python-Xlib,LOKI,SIP,NASM,PIL,libjpeg-turbo
export EASYBUILD_MODULE_NAMING_SCHEME=HierarchicalMNS
export EASYBUILD_ROBOT_PATHS=$FASRCSW_DEV/SPECS:$EASYBUILD_REPOSITORYPATH
export EASYBUILD_INSTALLPATH_SOFTWARE=/n/sw/eb/apps/centos7
export EASYBUILD_INSTALLPATH_MODULES=/n/sw/eb/modulefiles/centos7
export EASYBUILD_SUFFIX_MODULES_PATH=""
export EASYBUILD_SOURCEPATH=$FASRCSW_DEV/SOURCES

# set MODULEPATH and load EasyBuild module
module unuse /n/helmod/modulefiles/centos7/Core
export MODULEPATH=/n/sw/eb/modulefiles/centos7/Core:$MODULEPATH
module load EasyBuild/3.7.1
