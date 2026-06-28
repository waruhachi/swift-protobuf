TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = SwiftProtobuf
ARCHS = arm64 arm64e

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SwiftProtobuf_FILES = $(call rwildcard, Sources, *.m *.swift)
SwiftProtobuf_SWIFTFLAGS += -package-name SwiftProtobuf
SwiftProtobuf_INSTALL_PATH = /Library/Frameworks

include $(THEOS_MAKE_PATH)/framework.mk

before-stage::
	@$(PRINT_FORMAT_YELLOW) "Copying neccessary files for functionality"

	$(eval FRAMEWORK_DIR := $(THEOS_OBJ_DIR)/$(FRAMEWORK_NAME).framework)
	@mkdir -p $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/Project

	@cp $(THEOS_OBJ_DIR)/arm64/$(FRAMEWORK_NAME).abi.json $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/arm64-apple-ios.abi.json
	@cp $(THEOS_OBJ_DIR)/arm64/$(FRAMEWORK_NAME).swiftmodule $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/arm64-apple-ios.swiftmodule
	@cp $(THEOS_OBJ_DIR)/arm64/$(FRAMEWORK_NAME).swiftsourceinfo $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/Project/arm64-apple-ios.swiftsourceinfo
	
	@cp $(THEOS_OBJ_DIR)/arm64e/$(FRAMEWORK_NAME).abi.json $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/arm64e-apple-ios.abi.json
	@cp $(THEOS_OBJ_DIR)/arm64e/$(FRAMEWORK_NAME).swiftmodule $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/arm64e-apple-ios.swiftmodule
	@cp $(THEOS_OBJ_DIR)/arm64e/$(FRAMEWORK_NAME).swiftsourceinfo $(FRAMEWORK_DIR)/Modules/$(FRAMEWORK_NAME).swiftmodule/Project/arm64e-apple-ios.swiftsourceinfo