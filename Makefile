#
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Thursday, September 21 09:35:24 CEST 2017
# version : 0.0.1

TOP = $(CURDIR)
include $(TOP)/configure/CONFIG


M_DIRS:=$(sort $(dir $(wildcard $(TOP)/*/.)))


# help is defined in 
# https://gist.github.com/rcmachado/af3db315e31383502660
help:
	$(info --------------------------------------- )	
	$(info Available targets)
	$(info --------------------------------------- )
	@awk '/^[a-zA-Z\-\_0-9]+:/ {                    \
	  nb = sub( /^## /, "", helpMsg );              \
	  if(nb == 0) {                                 \
	    helpMsg = $$0;                              \
	    nb = sub( /^[^:]*:.* ## /, "", helpMsg );   \
	  }                                             \
	  if (nb)                                       \
	    print  $$1 "\t" helpMsg;                    \
	}                                               \
	{ helpMsg = $$0 }'                              \
	$(MAKEFILE_LIST) | column -ts:	

default: help


## Print ENV variables
env:
	@echo ""



dirs:
	@echo $(M_DIRS) || true



init:  
	git submodule init $(EPICS_BASE)
	git submodule update --init --recursive $(EPICS_BASE)/.


git-msync:
	git submodule sync	


base-init:  git-msync
	@git submodule deinit -f $(EPICS_BASE)/
	git submodule deinit -f $(EPICS_BASE)/
	sed -i '/submodule/,$$d'  $(TOP)/.git/config	
	git submodule init $(EPICS_BASE)
	git submodule update --init --recursive $(EPICS_BASE)/.




.PHONY: help env dirs init git-msync base-init
