#!/bin/bash

DEBUG=false
DEFAULT_GROUP="jupyter"
PATH_BASE=".."
PATH_PASSWD="etc/passwd"
PATH_SHADOW="etc/shadow"
PATH_GROUP="etc/group"
PATH_HOME="home"

debug_print () {
    if $DEBUG ; then
        echo "DEBUG: ${1}"
    fi
}

error () {
    echo "Usage ${0} Username:Password"
    echo "      ${0} Username Password"
}

if [ $# -eq 1 ]; then
    TEST=`echo ${1}|grep ':'|wc -l`
    if [ $TEST -eq 1 ]; then
        USER=`echo $1|cut -d: -f1`
        PASS=`echo $1|cut -d: -f2`
    else
	error
	exit 1
    fi
elif [ $# -eq 2 ]; then
    USER=$1
    PASS=$2
else
    error
    exit 1
fi
debug_print "${USER}"
debug_print "${PASS}"

GRP=`grep ${DEFAULT_GROUP} ${PATH_BASE}/${PATH_GROUP}`
debug_print "${GRP}"
GROUPID=`echo ${GRP}|cut -d: -f3`
debug_print "${GROUPID}"

MAX_USERID=`cat ${PATH_BASE}/${PATH_PASSWD}|cut -d: -f3|sort -n|tail -1`
debug_print "${MAX_USERID}"
USERID=$(($MAX_USERID+1))
echo "${USER}:x:${USERID}:${GROUPID}::${PATH_HOME}/${USER}:/bin/bash">>$PATH_BASE/$PATH_PASSWD
debug_print "${USER}:x:${USERID}:${GROUPID}::${PATH_HOME}/${USER}:/bin/bash"

sed -i -e "s/${GRP}/${GRP},${USER}/g" $PATH_BASE/$PATH_GROUP
echo "${USER}:x:${USERID}:">>$PATH_BASE/$PATH_GROUP

SALT=`openssl rand -base64 21|tr -dc '[:alnum:]'|head -c 16`
HASHED_PASWD=`openssl passwd -6 -salt ${SALT} ${PASS}`
echo "${USER}:${HASHED_PASWD}:::::::">>$PATH_BASE/$PATH_SHADOW

cp -ra /etc/skel $PATH_BASE/$PATH_HOME/$USER
chown -R $USERID:$GROUPID $PATH_BASE/$PATH_HOME/$USER

