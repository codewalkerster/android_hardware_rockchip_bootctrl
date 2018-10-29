LOCAL_PATH := $(call my-dir)

bootctrl_common_cflags := \
    -D_FILE_OFFSET_BITS=64 \
    -D_POSIX_C_SOURCE=199309L \
    -Wa,--noexecstack \
    -Werror \
    -Wall \
    -Wextra \
    -Wformat=2 \
    -Wno-psabi \
    -Wno-unused-parameter \
    -ffunction-sections \
    -fstack-protector-strong \
    -DAVB_AB_I_UNDERSTAND_LIBAVB_AB_IS_DEPRECATED \
    -g \
    -DAVB_ENABLE_DEBUG \
    -DAVB_COMPILATION

bootctrl_common_cppflags := \
    -Wnon-virtual-dtor \
    -fno-strict-aliasing

bootctrl_common_ldflags := \
    -Wl,--gc-sections \
    -rdynamic

bootctrl_sources := \
    libavb/avb_chain_partition_descriptor.c \
    libavb/avb_cmdline.c \
    libavb/avb_crc32.c \
    libavb/avb_crypto.c \
    libavb/avb_descriptor.c \
    libavb/avb_footer.c \
    libavb/avb_hash_descriptor.c \
    libavb/avb_hashtree_descriptor.c \
    libavb/avb_kernel_cmdline_descriptor.c \
    libavb/avb_property_descriptor.c \
    libavb/avb_rsa.c \
    libavb/avb_sha256.c \
    libavb/avb_sha512.c \
    libavb/avb_slot_verify.c \
    libavb/avb_util.c \
    libavb/avb_vbmeta_image.c \
    libavb/avb_version.c

include $(CLEAR_VARS)
LOCAL_MODULE := libavbuser_proprietary
LOCAL_CLANG := true
LOCAL_CFLAGS := $(bootctrl_common_cflags)
LOCAL_LDFLAGS := $(bootctrl_common_ldflags)
LOCAL_CPPFLAGS := $(bootctrl_common_cppflags)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
LOCAL_HEADER_LIBRARIES := libhardware_headers libsystem_headers
LOCAL_SHARED_LIBRARIES := \
    libbase
LOCAL_STATIC_LIBRARIES := \
    libfstab
LOCAL_SRC_FILES := \
    $(bootctrl_sources) \
    libavb/avb_sysdeps_posix.c \
    libavb_ab/avb_ab_flow.c \
    libavb_user/avb_ops_user.cpp \
    libavb_user/avb_user_verity.c
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libavbuser
LOCAL_CLANG := true
LOCAL_CFLAGS := $(bootctrl_common_cflags)
LOCAL_LDFLAGS := $(bootctrl_common_ldflags)
LOCAL_CPPFLAGS := $(bootctrl_common_cppflags)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
LOCAL_HEADER_LIBRARIES := libhardware_headers libsystem_headers
LOCAL_SHARED_LIBRARIES := \
    libbase
LOCAL_STATIC_LIBRARIES := \
    libfstab
LOCAL_SRC_FILES := \
    $(bootctrl_sources) \
    libavb/avb_sysdeps_posix.c \
    libavb_ab/avb_ab_flow.c \
    libavb_user/avb_ops_user.cpp \
    libavb_user/avb_user_verity.c
include $(BUILD_STATIC_LIBRARY)


# HAL Shared library for the target. Used by libhardware.
include $(CLEAR_VARS)
LOCAL_CLANG := true
LOCAL_CFLAGS := $(bootctrl_common_cflags)
LOCAL_LDFLAGS := $(bootctrl_common_ldflags)
LOCAL_SHARED_LIBRARIES := \
    libbase \
    libcutils \
    liblog
LOCAL_STATIC_LIBRARIES := \
    libavbuser_proprietary \
    libfstab
LOCAL_HEADER_LIBRARIES := libhardware_headers libsystem_headers
LOCAL_SRC_FILES := boot_control_avb.c
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE := bootctrl.rk30board
LOCAL_MODULE_OWNER := rockchip
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_SHARED_LIBRARY)

# Static library for the target. Used by update_engine_sideload from recovery.
include $(CLEAR_VARS)
LOCAL_CFLAGS := $(bootctrl_common_cflags)
LOCAL_LDFLAGS := $(bootctrl_common_ldflags)
LOCAL_SHARED_LIBRARIES := \
    libbase \
    libcutils \
    liblog
LOCAL_STATIC_LIBRARIES := \
    libavbuser \
    libfstab
LOCAL_HEADER_LIBRARIES := libhardware_headers libsystem_headers
LOCAL_SRC_FILES := boot_control_avb.c
LOCAL_MODULE := bootctrl.rk30board
include $(BUILD_STATIC_LIBRARY)
