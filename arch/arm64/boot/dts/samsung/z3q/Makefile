define __sec_dtbo_build
dtbo-$(2) += $(1)
$(1)-base := $(3)
endef

define sec_dtbo_build
$(foreach dtbo, $(1), $(eval $(call __sec_dtbo_build, $(dtbo),$(2),$(3))))
endef

QCOM_DTB := ../../vendor/qcom
SEC_KONA_BASE_DTB := $(QCOM_DTB)/kona.dtb $(QCOM_DTB)/kona-v2.dtb $(QCOM_DTB)/kona-v2.1.dtb

ifeq ($(CONFIG_BUILD_ARM64_DT_OVERLAY),y)

SEC_Z3Q_KOR_DTBO := kona-sec-z3q-kor-overlay-r13.dtbo kona-sec-z3q-kor-overlay-r14.dtbo kona-sec-z3q-kor-overlay-r15.dtbo kona-sec-z3q-kor-overlay-r16.dtbo

$(eval $(call sec_dtbo_build, $(SEC_Z3Q_KOR_DTBO),$(CONFIG_MACH_Z3Q_KOR_SINGLE),$(SEC_KONA_BASE_DTB)))

endif
