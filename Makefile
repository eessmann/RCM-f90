### Makefile for RCM-f90
#
## License
#
# SPDX-License-Identifier: LGPL-2.1-only

TGT = $(LIB_DIR)/librcm.a

SRC_DIR = src
INC_DIR = include
OBJ_DIR = obj
LIB_DIR = lib

SRC = $(SRC_DIR)/rcm_kinds.f90 \
      $(SRC_DIR)/rcm.f90

OBJ = $(addprefix $(OBJ_DIR)/, $(notdir $(SRC:.f90=.o)))

all: $(TGT)

$(TGT): dirs $(OBJ)
	ar rcs $(TGT) $(OBJ)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.f90
	$(FC) $(FFLAGS) -J$(INC_DIR) -o $@ -c $^

dirs: $(OBJ_DIR) $(LIB_DIR) $(INC_DIR)

$(OBJ_DIR):
	mkdir $@

$(LIB_DIR):
	mkdir $@

$(INC_DIR):
	mkdir $@

clean:
	rm -rf $(INC_DIR) $(OBJ_DIR) $(LIB_DIR)
