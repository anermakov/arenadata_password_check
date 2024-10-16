# arenadata_password_check/Makefile

MODULE_big = arenadata_password_check
OBJS = arenadata_password_check.o $(WIN32RES)
PGFILEDESC = "arenadata_password_check - strengthen user password checks"

REGRESS = arenadata_password_check

# uncomment the following two lines to enable cracklib support
# PG_CPPFLAGS = -DUSE_CRACKLIB '-DCRACKLIB_DICTPATH="/usr/lib/cracklib_dict"'
# SHLIB_LINK = -lcrack

#PG_CONFIG = pg_config
#PGXS := $(shell $(PG_CONFIG) --pgxs)
#include $(PGXS)

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/passwordcheck
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
