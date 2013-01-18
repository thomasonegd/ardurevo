# Standard things
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)
BUILDDIRS += $(BUILD_PATH)/$(d)
#BUILDDIRS += $(BUILD_PATH)/$(d)/tools

# Local flags
CFLAGS_$(d) := 

# Local rules and targets
cSRCS_$(d) :=

cppSRCS_$(d) :=
cppSRCS_$(d) += AP_Common.cpp
cppSRCS_$(d) += AP_Loop.cpp
cppSRCS_$(d) += AP_Param.cpp
cppSRCS_$(d) += AP_Var_menufuncs.cpp

#cppSRCS_$(d) += tools/eedump_apparam.c
#cppSRCS_$(d) += tools/eedump.c

cFILES_$(d) := $(cSRCS_$(d):%=$(d)/%)
cppFILES_$(d) := $(cppSRCS_$(d):%=$(d)/%)

OBJS_$(d) := $(cFILES_$(d):%.c=$(BUILD_PATH)/%.o) \
             $(cppFILES_$(d):%.cpp=$(BUILD_PATH)/%.o)
DEPS_$(d) := $(OBJS_$(d):%.o=%.d)

$(OBJS_$(d)): TGT_CFLAGS := $(CFLAGS_$(d))

TGT_BIN += $(OBJS_$(d))

# Standard things
-include $(DEPS_$(d))
d := $(dirstack_$(sp))
sp := $(basename $(sp))