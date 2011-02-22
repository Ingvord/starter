#=============================================================================
#
# file :        Makefile
#
# description : Include for the Starter class.
#
# project :     Makefile to generate a Tango server
#
# $Author$
#
# $Revision$
#
# $Log$
# Revision 3.20  2008/06/18 08:17:03  pascal_verdier
# Pb with case unsensitive on win32 fixed.
#
# Revision 3.19  2008/05/15 08:07:18  pascal_verdier
# TangoSys_MemStream replaced by TangoSys_OMemStream
# (for leaking problem under win32)
#
# Revision 3.18  2008/04/09 14:46:11  pascal_verdier
# Bug in init of NotifdState attribute fixed.
#
# Revision 3.17  2008/04/07 08:54:55  pascal_verdier
# Check if this starter instance is able to ru on this host.
#
# Revision 3.16  2008/03/27 07:58:46  pascal_verdier
# Tag 4.0
#
# Revision 3.15  2008/02/29 15:15:05  pascal_verdier
# Checking running processes by system call added.
#
# Revision 3.14  2007/09/25 12:09:44  pascal_verdier
# 64 bits mode added
#
# Revision 3.13  2007/06/12 09:33:17  pascal_verdier
# make dir added
#
# Revision 3.12  2007/02/13 06:45:13  pascal_verdier
# *** empty log message ***
#
# Revision 3.11  2006/05/15 11:02:40  pascal_verdier
# Tag revision added.
#
# Revision 3.10  2006/04/24 08:58:10  pascal_verdier
# *** empty log message ***
#
# Revision 3.9  2006/04/24 07:06:26  pascal_verdier
# A thread is started for each level when at servers startup.
#
# Revision 3.8  2006/02/09 11:59:18  pascal_verdier
# A ping thread is now started for each server.
#
# Revision 3.7  2006/02/08 07:13:55  pascal_verdier
# Minor changes.
#
# Revision 3.6  2006/01/13 15:19:49  pascal_verdier
# Make tag added.
#
# Revision 3.5  2005/10/20 10:48:23  pascal_verdier
# Add stuff for gcc.
#
# Revision 3.4  2005/04/21 07:18:48  pascal_verdier
# Add a little timeout for ping.
# Fix a bug for windows (SIGCHLD).
#
# Revision 3.3  2004/12/10 08:57:19  pascal_verdier
# Tango 5 compatibility (attribute management).
#
# Revision 3.2  2004/06/29 04:24:26  pascal_verdier
# First revision using events.
#
# Revision 3.1  2004/05/19 08:00:03  pascal_verdier
# merge changes from 3.0.1 onto trunk
#
# Revision 3.0.1.5  2004/02/27 09:53:02  pascal_verdier
# - The starter device is now warned by Database server when something change on a server.
# It replace the DbGetHostServersInfo polling.
# - HostState, ControlledRunningServers, ontrolledStoppedServers attributes added.
#
# Revision 3.0.1.4  2003/12/08 08:53:52  pascal_verdier
# Cluster (multi-host) control implemented.
# Control of notify daemon implemented but not tested.
#
# Revision 3.0.1.3  2003/10/15 10:37:08  pascal_verdier
# *** empty log message ***
#
# Revision 3.0.1.2  2003/10/08 09:18:03  pascal_verdier
# *** empty log message ***
#
# Revision 3.0.1.1  2003/09/18 12:02:49  pascal_verdier
# Problem on Windows service startup fixed.
#
# Revision 3.0  2003/06/17 12:06:36  pascal_verdier
# TANGO 3.x server.
# polling bugs fixed.
#
# Revision 2.0  2003/01/09 13:35:50  verdier
# TANGO 2.2
#
# Revision 1.22  2002/12/18 08:09:19  verdier
# omniORB compatibility
#
# Revision 1.6  2002/10/15 18:55:21  verdier
# The host state is now calculated during the State polled command.
#
#
# copyleft :    European Synchrotron Radiation Facility
#               BP 220, Grenoble 38043
#               FRANCE
#
#=============================================================================
#  		This file is generated by POGO
#	(Program Obviously used to Generate tango Object)
#
#         (c) - Software Engineering Group - ESRF
#=============================================================================
#

CLASS    = Starter
RELEASE  = Release_4_8

TANGO_HOME   =  /segfs/tango/release

ifdef _solaris
CC = CC
OS_VERS=$(shell /csadmin/common/scripts/get_os)
ifdef _gcc
CC = c++
BIN_DIR = $(OS_VERS)_gcc
endif
ifdef _CC
CC = CC
BIN_DIR = $(OS_VERS)_CC
endif
endif

ifdef linux
#CC = c++ -Wall
CC = c++ 

PROCESSOR  = $(shell uname -p)
$(PROCESSOR)=1
ifdef x86_64
NBITS=_64
endif
BIN_DIR=$(shell /csadmin/common/scripts/get_os)$(NBITS)

endif

INCLUDE_DIRS =	-I$(TANGO_HOME)/$(BIN_DIR)/include	-I.

OBJS_DIR = 	obj/$(BIN_DIR)
LIB_DIRS = -L $(TANGO_HOME)/$(BIN_DIR)/lib

ifdef _solaris
ifdef _gcc
STD_LIB=	-lstdc++
endif

CXXFLAGS =  -g -D_PTHREADS $(INCLUDE_DIRS)
LFLAGS =  -g $(LIB_DIRS)  	\
			-ltango			\
			-llog4tango		\
			-lomniORB4 		\
			-lomniDynamic4	\
			-lomnithread	\
			-lCOS4			\
			-lpthread		\
			-lposix4 -lsocket -lnsl $(STD_LIB)
endif

ifdef linux
CXXFLAGS =  -g -D_REENTRANT $(INCLUDE_DIRS)
LFLAGS =  -g $(LIB_DIRS)	\
			-ltango			\
			-llog4tango		\
			-lomniDynamic4	\
			-lomniORB4		\
			-lomnithread	\
			-lCOS4			\
			-ldl -lpthread
endif






SVC_OBJS =	$(OBJS_DIR)/$(CLASS).o		\
			$(OBJS_DIR)/$(CLASS)Class.o	\
			$(OBJS_DIR)/CheckProcessUtil.o \
			$(OBJS_DIR)/$(CLASS)StateMachine.o	\
			$(OBJS_DIR)/$(CLASS)Util.o	\
			$(OBJS_DIR)/ClassFactory.o	\
			$(OBJS_DIR)/main.o	\
			\
			$(OBJS_DIR)/PingThread.o	\
			$(OBJS_DIR)/StartProcessThread.o
			
SVC_INC = 	$(CLASS)Class.h \
			$(CLASS).h


$(OBJS_DIR)/%.o: %.cpp
	@mkdir -p $(OBJS_DIR)
	$(CC) $(CXXFLAGS) -c $< -o $(OBJS_DIR)/$*.o
			
all: make_obj_dir make_bin_dir $(CLASS)

$(CLASS):	$(SVC_OBJS)
	$(CC) $(SVC_OBJS) -o $(CLASS) $(LFLAGS)
	mv $(CLASS) bin/$(BIN_DIR)/$(CLASS)

clean:
	rm -f $(OBJS_DIR)/*.o   bin/$(BIN_DIR)/$(CLASS)   core
	
install:
	cp bin/$(BIN_DIR)/$(CLASS)    $(TANGO_HOME)/../bin/$(BIN_DIR)
	ls -l $(TANGO_HOME)/../bin/$(BIN_DIR)


valg:
	HOST=`hostname`
	PATH=$(PATH):/segfs/tango/contrib/$(BIN_DIR)/valgrind/bin
	valgrind -v --tool=memcheck     \
			--num-callers=20        \
			--trace-children=yes    \
			--leak-check=yes        \
			--leak-resolution=high  \
			bin/$(BIN_DIR)/$(CLASS)  $(HOST) 2>log

make_obj_dir:
	@mkdir -p obj
	@mkdir -p obj/$(BIN_DIR)

make_bin_dir:
	@mkdir -p bin
	@mkdir -p bin/$(BIN_DIR)

#----------------------------------------------------
#	Tag the CVS module corresponding to this class
#----------------------------------------------------
tag:
	@cvstag "$(CLASS)-$(RELEASE)"
	@make   $(CLASS)
	@make show_tag

show_tag:
	@cvstag -d 
